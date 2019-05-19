<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;
use Illuminate\Database\QueryException;
use Carbon\Carbon;
use App\Models\RemisionDetail;
use App\Models\Remision;
use App\Models\RemisionDocumentType;
use App\Models\Seller;
use App\Models\Tax;
use App\Models\Currency;
use App\Models\ListPrice;
use App\Models\Contact;
use App\Models\Product;
use App\Models\ResolutionNumber;
use App\Utilities\Helper;
use PDF;
use App\Events\RecordActivity;
use App\Contracts\IEmailRepository;
use App\Contracts\IPdfRepository;

class RemisionController extends Controller
{
    protected $emailRepo;

    protected $iPdfRepo;

    public function __construct(IEmailRepository $emailRepo, IPdfRepository $iPdfRepo)
    {
        $this->emailRepo = $emailRepo;
        $this->iPdfRepo = $iPdfRepo;
    }
    public function getRemisionList()
    {
        //Obtener las cotizaciones creadas hasta la fecha
        $model = Remision::with('contact')
               ->GetAll(0)
               ->orderBy('created_at', 'desc')
                ->GetSelectedFields()
               ->get();

        
        return response()
        ->json([
            'records' => $model
        ]);
    }

    //Rtorna la información necesaria para el header de las facturas/cotizaciones.etc
    private static function BaseInfo()
    {
        $DocumentType = RemisionDocumentType::select('id as value', 'description as label')
               ->orderBy('id', 'asc')
               ->get();

        return [
            'contacts' => Helper::contacts(),
            'sellers'=>Helper::sellers(),
            'listprice'=>Helper::listPrice(),
            'currency'=>Helper::currencylist(),
            'productlist'=>Helper::productlist(),
            'taxes'=>Helper::taxes(),
            'documentType'=> $DocumentType
                    ];

    }

    public function create()
    {
        return response()
        ->json([
           'form' => Remision::initialize(),
           'base' =>  $this->baseInfo()
        ]);
    }
        
    public function store(Request $request)
    {

        $this->validate($request, [
            'customer_id' => 'required',
            'date' => 'required',
            'due_date' => 'required',
            'notes' => 'required',
            'document_type_id' => 'required',
            'detail.*.unit_price' => 'required|numeric|min:1',
            'detail.*.quantity' => 'required|integer|min:1',
            'detail.*.product_id' => 'required',
        ]);

        $products = collect($request->detail)->transform(function ($detail) {
            $baseprice=$detail['quantity'] * $detail['unit_price'];
            $totalDiscount= $baseprice*($detail['discount']/100);
            $totalTax=($baseprice- $totalDiscount)*($detail['tax_amount']/100);
            $detail['total_tax']=$totalTax;
            $detail['total'] = $baseprice + $totalTax - $totalDiscount;
            $detail['user_id'] =  Auth::user()->id;
            
            return new RemisionDetail($detail);
        });
        

        if ($products->isEmpty()) {
            return response()
            ->json([
                'custom_message' => 'Uno o mas productos son requeridos.'
            ], 422);
        };

        
        $data = $request->except('detail', 'documentType', 'list_price', 'currency', 'contact', 'seller');
        
        $data['public_id'] = Helper::PublicId(Remision::class);
        $data['document_type_id'] =  (int)$data['document_type_id'];
        $data['resolution_id'] = Helper::ResolutionId(ResolutionNumber::class, 'remision')['number'];
        $data['status_id'] = 1;
        $data['account_id'] = Auth::user()->account_id;
        $data['user_id'] = Auth::user()->id;
        $data['date']=Helper::dateFormatter($data['date']);
        $data['due_date']= Helper::dateFormatter($data['due_date']);
        
        //Default
        if (!$data['currency_code']) {
            $data['currency_code']="COP";
        }

        $remision = Remision::create($data);
        $remision->detail()->saveMany($products);
     
        //Incrementa el numero de cotización
        ResolutionNumber::where('key', 'remision')
                ->increment('number');
       
        event(new RecordActivity('Create', 'Se creó la remisión número: '
            .$remision->resolution_id.' para el cliente '.$remision->contact->name,
            'Remision', '/remision/'.$remision->public_id));

        return response()
            ->json([
                'created' => true,
                'id' => $remision->public_id
            ]);
    }

    public function show($id)
    {       

          $model = Remision::with('detail', 'list_price', 'seller','contact')
                    ->GetByPublicId(0, $id)
                    ->GetSelectedFields()
                    ->first();            

        if (!$model) {
            $notification = array(
                'custom_message' => 'No se encontró ninguna referencia de remision creadas!',
                'redirectTo'=>'/remision'
            );
            return response()
            ->json([
                 $notification
            ]);
        }
        $taxes=Helper::getTotalTaxes($model->public_id, 'remision', 'remision_detail');
        $model=Helper::_InvoiceFormatter($model);

        return response()
        ->json([
            'model' => $model,
            'totalTaxes'=>$taxes
        ]);
    }



    public function edit($id)
    {
        
        $remision = Remision::with(['detail','contact','list_price','currency','seller'])
        ->GetByPublicId(0, $id)
        ->GetSelectedFields()
        ->first();
        
        if (!$remision) {
            return response()
            ->json([
                'custom_message' => 'No se encontró la remision seleccionada, intente nuevamente!',
                'redirectTo'=>'/remision'
            ], 422);
        }

        $remision['date']= Helper::setCustomDateFormat(Carbon::parse($remision['date']));
        $remision['due_date']= Helper::setCustomDateFormat(Carbon::parse($remision['due_date']));
        
        if (request()->get('convert')=='clone') {
            $PublicId = Helper::PublicId(Remision::class);
            $remision['public_id']= $PublicId;
            $remision['date']=Helper::setCustomDateFormat(Carbon::now());
            $remision['due_date']=Helper::setCustomDateFormat(Carbon::now()->addDays(30));
            $remision['notes']=null;
            //return view('remision.clone', compact('remision'));
        }

        return response()
        ->json([
            'form' => $remision,
            'base' => $this->baseInfo()
        ]);
    }

    
    public function update(Request $request, $id)
    {
              
        $this->validate($request, [
            'customer_id' => 'required',
            'date' => 'required',
            'due_date' => 'required',
            'notes' => 'required',
            'detail.*.unit_price' => 'required|numeric|min:1',
            'detail.*.quantity' => 'required|integer|min:1',
            'detail.*.product_id' => 'required',
        ]);
       
        $remision = Remision::findOrFail($id);

        $products = collect($request->detail)->transform(function ($detail) {
            $baseprice=$detail['quantity'] * $detail['unit_price'];
            $totalDiscount= $baseprice*($detail['discount']/100);
            $totalTax=($baseprice- $totalDiscount)*($detail['tax_amount']/100);
            $detail['total_tax']=$totalTax;
            $detail['total'] = $baseprice + $totalTax - $totalDiscount;
            $detail['user_id'] =  Auth::user()->id;

            return new RemisionDetail($detail);
        });
        
        if ($products->isEmpty()) {
            return response()
            ->json([
                'custom_message' => ['Uno o mas productos son requeridos.']
            ], 422);
        };
        
        $data = $request->except('detail');

        $data['user_id'] = Auth::user()->id;
        $data['date']=Helper::dateFormatter($data['date']);
        $data['due_date']= Helper::dateFormatter($data['due_date']);
        $remision->update($data);
       
        RemisionDetail::where('remision_id', $remision->id)->delete();
        $remision->detail()->saveMany($products);

        event(new RecordActivity('Update', 'Se actualizó la remisión número: '
            .$remision->resolution_id.' para el cliente '.$remision->contact->name,
            'Remision', '/remision/'.$remision->public_id));

        return response()
            ->json([
                'updated' => true,
                'id' => $remision->public_id
            ]);
    }
    
    public function destroy($id)
    {

            $remision = Remision::GetByPublicId(0, $id)
                ->firstOrFail();
            
            $remision['isDeleted']=1;
            $remision['deleted_at']=$now = Carbon::now();
            $remision->save();
            
            event(new RecordActivity('Delete', 'Se eliminó la remisión número: '
            .$remision->resolution_id,
            'Remision', null));

            return response()
            ->json([
                'deleted' => true
            ]);
    }

    public function pdf($id, Request $request)
    {
        
        $mypdf=$this->iPdfRepo->create(Remision::class, $id);

        $filename = "Remision_"."{$id}.pdf";

        if ($request->get('opt') === 'download') {
            return $mypdf->download($filename);
        }
        
        event(new RecordActivity('Print', 'Se ha impreso el pdf de la remision No: '
            .$id, 'Remision', '/remision/'.$id));

        return $mypdf->stream();
    }
    
    public function update_state(Request $request, $id)
    {
       
            $data = $request->all();
      
            $data['status_id']= (int)$data['status_id'];

            try
            {
                $item = Remision::findOrFail($id);
                $item->update($data);               

                event(new RecordActivity('Update', 'Se actualizó el estado de la remisión número: '
                .$item->resolution_id.' para el cliente '.$item->contact->name,
                'Remision', '/remision/'.$item->public_id));

                return response()
                ->json([
                    'updated' => true
                ]);
            }
            catch(\Exception $e){               

                return response()
                ->json([
                    'updated' => false
                ],422);

            }


           
    }

    public function getTemplateEmailToCustomer($resolution_id)
    {
           return $this->emailRepo->TemplateEmailToCustomer(Remision::class, $resolution_id);
    }
}
