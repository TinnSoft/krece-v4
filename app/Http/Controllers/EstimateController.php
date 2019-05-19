<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;
use Illuminate\Database\QueryException;
use Carbon\Carbon;
use App\Models\{
    EstimateDetail,
    Estimate,
    Seller,
    Tax,
    Currency,
    ListPrice,
    Contact,
    Product,
    ResolutionNumber,
    Account
};
use App\Utilities\Helper;
use PDF;
use App\Events\RecordActivity;
use Jenssegers\Date\Date;
use App\Contracts\IEmailRepository;
use App\Contracts\IPdfRepository;

class EstimateController extends Controller
{
    protected $emailRepo;
    protected $iPdfRepo;
    public function __construct(IEmailRepository $emailRepo, IPdfRepository $iPdfRepo)
    {
        $this->emailRepo = $emailRepo;
        $this->iPdfRepo = $iPdfRepo;
    }
    
    public function getEstimateList()
    {
        //Obtener las cotizaciones creadas hasta la fecha
        $estimate = Estimate::with('contact')
        ->GetAll(0)
        ->orderBy('created_at', 'desc')
        ->GetSelectedFields()
        ->get();
        
        return response()
        ->json([
            'records' => $estimate
        ]);

    }
    
    //Rtorna la información necesaria para el header de las facturas/cotizaciones.etc
 
        
    public function create()
        {  
            $baseInfo=[
                'contacts' => Helper::contacts(),
                'sellers'=>Helper::sellers(),
                'listprice'=>Helper::listPrice(),
                'currency'=>Helper::currencylist(),
                'productlist'=>Helper::productlist(),
                'taxes'=>Helper::taxes(),
                        ];
            
           return response()
           ->json([
               'form' => Estimate::initialize(),
               'base' => $baseInfo
           ]);

        }
        
    public function store(Request $request)
        {
          
            $this->validate($request, [
            'customer_id' => 'required',
            'date' => 'required',
            'due_date' => 'required',
            'notes' => 'required',
            'detail' => 'required|array|min:1',
            'detail.*.unit_price' => 'required|numeric|min:0',
            'detail.*.quantity' => 'required|integer|min:1',
            'detail.*.product_id' => 'required',
            ]);
            
            
            $products = collect($request->detail)->transform(function($detail) {
                $baseprice=$detail['quantity'] * $detail['unit_price'];
                $totalDiscount= $baseprice*($detail['discount']/100);
                $detail['total'] = $baseprice- $totalDiscount;
                $detail['user_id'] =  Auth::user()->id;
                $detail['total_tax']=($baseprice- $totalDiscount)*($detail['tax_amount']/100);
                return new EstimateDetail($detail);
            });
            

            if($products->isEmpty()) {
                return response()
                ->json([
                'custom_message' => 'Uno o mas productos son requeridos.'
                ], 422);
            };
            
            $data = $request->except('detail','contact','seller');
           
            $data['public_id'] = Helper::PublicId(Estimate::class);
            $data['resolution_id'] = Helper::ResolutionId(ResolutionNumber::class,'estimate')['number'];
            $data['account_id'] = Auth::user()->account_id;
            $data['user_id'] = Auth::user()->id;
          
        
            $data['date']=Helper::dateFormatter($data['date']);          
            $data['due_date']= Helper::dateFormatter($data['due_date']);

            
            
            if (!$data['currency_code'])
            {
                $data['currency_code']=CURRENCY_CODE_DEFAULT;
            }
            

            $estimate = Estimate::create($data);
            $estimate->detail()->saveMany($products);
            
            //Incrementa el numero de cotización
            ResolutionNumber::where('key', 'estimate')
            ->increment('number');
            
            event(new RecordActivity('Create','Se creó la Cotización número: '
            .$estimate->resolution_id.' para el cliente '.$estimate->contact->name,
            'Estimate','/estimate/'.$estimate->public_id));
            
            return response()
            ->json([
            'created' => true,
            'id' => $estimate->public_id,
            'message'=>'Se ha creado la cotización No: '.$estimate->public_id
            ]);
    }
        
        
        public function show($id)
        {
            
            $estimate = Estimate::with('detail','list_price','seller','contact')
            ->GetByPublicId(0,$id)
            ->GetSelectedFields()
            ->first();
            
            if (!$estimate)
            {
                $notification = array(
                'message' => 'No se encontró ninguna referencia de cotizacion creadas!',
                'alert-type' => 'error'
                );
                //return redirect('/estimate')->with($notification);
                return response()
                ->json([
                     $notification
                ]);
            }
            $taxes=Helper::getTotalTaxes($estimate->public_id,'estimate','estimate_detail');
            $estimate=Helper::_InvoiceFormatter($estimate);

            return response()
            ->json([
                'estimate' => $estimate,
                'totalTaxes'=>$taxes
            ]);
            
        }
        
        
        public function edit($id)
        {
           
            $estimate = Estimate::with(['detail','contact','list_price','currency','seller'])
            ->GetByPublicId(0,$id)
            ->GetSelectedFields()
            ->first();
            
           
            $baseInfo=[
                'contacts' => Helper::contacts(),
                'sellers'=>Helper::sellers(),
                'listprice'=>Helper::listPrice(),
                'currency'=>Helper::currencylist(),
                'productlist'=>Helper::productlist(),
                'taxes'=>Helper::taxes(),
                        ];
            
            if (!$estimate)
            {
                return response()
                ->json([
                    'custom_message' => 'No se encontró la cotizacion seleccionada, intente nuevamente!',
                    'redirectTo'=>'/estimate'
                ], 422);
            }
         
            $estimate['date']= Helper::setCustomDateFormat(Carbon::parse($estimate['date']));
            $estimate['due_date']= Helper::setCustomDateFormat(Carbon::parse($estimate['due_date']));

            
            if (request()->get('convert')=='clone')
            {
                $PublicId = Estimate::where('account_id',  Auth::user()->account_id)->max('public_id')+1;
                $estimate['public_id']= $PublicId;
                $estimate['date']=Helper::setCustomDateFormat(Carbon::now());
                $estimate['due_date']=null;
                $estimate['notes']=null;
               // return view('estimate.clone', compact('estimate'));
            }
           

            return response()
            ->json([
                'form' => $estimate,
                'base' => $baseInfo
            ]);
        }
        
        
        public function update(Request $request, $id)
        {
            
            $this->validate($request, [
            'customer_id' => 'required',
            'date' => 'required',
            'due_date' => 'required',
            'notes' => 'required',
            'detail' => 'required|array|min:1',
            'detail.*.unit_price' => 'required|numeric|min:1',
            'detail.*.quantity' => 'required|integer|min:0',
            'detail.*.product_id' => 'required',
            ]);
            
            $estimate = Estimate::findOrFail($id);
            
            $products = collect($request->detail)->transform(function($detail) {
                $baseprice=$detail['quantity'] * $detail['unit_price'];
                $totalDiscount= $baseprice*($detail['discount']/100);
                $detail['total'] = $baseprice- $totalDiscount;
                $detail['user_id'] =  Auth::user()->id;
                $detail['total_tax']=($baseprice- $totalDiscount)*($detail['tax_amount']/100);
                return new EstimateDetail($detail);
            });
            
            if($products->isEmpty()) {
                return response()
                ->json([
                'custom_message' => 'Uno o mas productos son requeridos.'
                ], 422);
            };
            
            
            $data = $request->except('detail');
            
            $data['user_id'] = Auth::user()->id;
            $data['date']=Helper::dateFormatter($data['date']);
            $data['due_date']= Helper::dateFormatter($data['due_date']);
            $estimate->update($data);
            
            EstimateDetail::where('estimate_id', $estimate->id)->delete();
            
            $estimate->detail()->saveMany($products);
            
            event(new RecordActivity('Update','Se actualizó la Cotización número: '
            .$estimate->resolution_id.' para el cliente '.$estimate->contact->name,
            'Estimate','/estimate/'.$estimate->public_id));
            
            return response()
            ->json([
            'updated' => true,
            'id' => $estimate->public_id
            ]);
        }
        
        public function destroy($id)
        {
            
            $estimate = Estimate::GetByPublicId(0,$id)
            ->firstOrFail();
            
            $estimate['isDeleted']=1;
            $estimate['deleted_at']=$now = Carbon::now();
            $estimate->save();
            
            event(new RecordActivity('Delete','Se eliminó la cotización número: '
            .$estimate->resolution_id,
            'Estimate',null));
            
            return response()
            ->json([
            'deleted' => true,
            'message'=>'Has eliminado la cotización No: '.$estimate->public_id
            ]);
        }
        
        public function pdf($id, Request $request)
        {
            
            $mypdf=$this->iPdfRepo->create(Estimate::class, $id);

            $filename = "Cotizacion_"."{ $id}.pdf";
            
            if($request->get('opt') === 'download') {
                return $mypdf->download($filename);
            }
            
            event(new RecordActivity('Print','Se ha impreso el pdf de la cotización No: '
            .$id,'Estimate','/estimate/'.$id));
            
            return $mypdf->stream();
            
        }

        public function getTemplateEmailToCustomer($estimate_number)
        {           
           return $this->emailRepo->TemplateEmailToCustomer(Estimate::class,$estimate_number);
        }
    }