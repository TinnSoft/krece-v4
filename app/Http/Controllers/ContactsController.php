<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;
use Illuminate\Database\QueryException;
use Carbon\Carbon;
use App\Models\{
    Contact,
    Contact_others,
    PaymentTerms,
    Seller,
    ListPrice,
    Estimate,
    CreditNote,
    Remision,
    InvoiceSaleOrder,
    Payment,
    PurchaseOrder
};
use App\Contracts\IContactsRepository;
use App\Repositories\PaymentRepository;
use DB;
use App\Utilities\Helper;
use App\Mail\SendEmailToCustomer;
use Illuminate\Support\Facades\Mail;
use App\Contracts\IPdfRepository;


class ContactsController extends Controller
{

      protected $contactsRepo;

      protected $paymentRepo;

      protected $pdfRepo;


     public function __construct(IContactsRepository $contactsRepo, PaymentRepository $paymentRepo, IPdfRepository $pdfRepo)
     {
         
        $this->contactsRepo = $contactsRepo;
        
        $this->paymentRepo = $paymentRepo;
        
        $this->pdfRepo = $pdfRepo;
  
    }
    

    private static function getSellerList()
    {      
        return Seller::where('account_id',  Auth::user()->account_id)
            ->where('isDeleted',  0)
               ->orderBy('created_at', 'desc')
               ->select('id', 'name','dni',
               'work_phone','private_phone','observations','isEnabled'
               )->get();    
  
    }
 
    //Filtra los contactos dependiendo de su tipo
    //tipos: Cliente, proveedor, todos
    public function ContactIndex($condition=null)
    {

        $contacts=null;
         switch ($condition)
        {
            case CONTACT_IS_CUSTOMER;
                $contacts = Contact::GetCustomerAttributes()
               ->where('isCustomer',  1)->get();   
                break;
            
            case CONTACT_IS_PROVIDER;
                 $contacts = Contact::GetCustomerAttributes()
               ->where('isProvider',  1)->get();   
                break;

            case CONTACT_IS_SELLER;
                $contacts =$this->getSellerList();
               break;

            default;
                $contacts = Contact::GetCustomerAttributes()->get();  
                break;

        };
        
        return response()
        ->json([
            'records' => $contacts
        ]);

        //return response()->json($contacts);
  
    }

    //Rtorna la información necesaria para el header de las facturas/cotizaciones.etc
    public function BaseInfo()
    {        
        return [                
            'paymentterms' => Helper::PaymentTerms(),
            'sellers'=>Helper::sellers(),
            'listprice'=>Helper::listPrice()           
            ];
    }

    public function create()
    {
        return response()
        ->json([
            'form' => Contact::initialize(),
            'base' => $this->BaseInfo()
        ]);
    }
        
    public function store(Request $request)
    {   
        $this->validate($request, [     
            'name' => 'required'
        ]);

        $items=[];
        
       

        if($request['contact_others'])
        {
            foreach($request->contact_others as $item) {
                if($item['name'])
                {
                    $item['notify']=Helper::convertBooleanToInt( $item['notify']);
                    $item['account_id'] = Auth::user()->account_id; 
                    $item['user_id'] = Auth::user()->id;      
                    $items[] = new Contact_others($item);
                }
            }
        }
        
        $data = $request->except('contact_others');  

        $currentPublicId = Contact::where('account_id',  Auth::user()->account_id)->max('public_id')+1;
        $data['public_id'] = $currentPublicId;
        $data['account_id'] = Auth::user()->account_id;
        $data['user_id'] = Auth::user()->id;      

        $data['isProvider']=Helper::convertBooleanToInt($data['isProvider']);
        $data['isCustomer']=Helper::convertBooleanToInt($data['isCustomer']);
        $data['include_account_state']=0; 
        
        /*
        return response()
        ->json([
        'x' => $data
        ], 422);*/

        $contact = Contact::create($data);
       
        $contact->contact_others()->saveMany($items);
     
        return response()
            ->json([
                'created' => true,
                'id' => $contact->public_id
            ]);
    }


    public function show($id)
    {       

        $contact = Contact::with('list_price')
                ->GetCustomerAttributes()
                ->where('public_id',  $id)
                ->first();   

        if (!$contact)
        {
            
            $notification = array(
                'message' => 'No se encontró ninguna referencia de cotizacion creadas!', 
                'alert-type' => 'error'
            );             
          return redirect('/contact')->with($notification);
        }
      
        return response()
        ->json([
            'model' => $contact,
        ]);
    }

  
    public function edit($id)
    {
         $contact = Contact::with(['contact_others'])
                ->GetCustomerAttributes()
                ->where('public_id',  $id)              
                ->orderBy('created_at', 'desc')
                ->first();    
        
        $contact['isProvider']=(bool)$contact['isProvider'];
        $contact['isCustomer']=(bool)$contact['isCustomer'];

        foreach($contact->contact_others as $item) {
            $item['notify']=(bool)$item['notify'];
      }

         if (!$contact)
        {
            $notification = array(
                'custom_message' => 'No se encontró ninguna referencia de cotizacion creadas!', 
                'alert-type' => 'error'
            );
            return response()
            ->json([
                $notification
            ]);
        }
 
        return response()
        ->json([
            'form' =>  $contact,
            'base' => $this->BaseInfo()
        ]);
         
         
    }

    public function update(Request $request, $id)
    {      
         $this->validate($request, [     
            'name' => 'required'
        ]);
       
         $items=[];
        
        foreach($request->contact_others as $item) {
              if($item['name'])
              {
                $item['notify']=Helper::convertBooleanToInt($item['notify']);
                $item['account_id'] = Auth::user()->account_id; 
                $item['user_id'] = Auth::user()->id;      
                $items[] = new Contact_others($item);
              }
        }        
    
        $data = $request->except('contact_others');  
        $data['account_id'] = Auth::user()->account_id;
        $data['user_id'] = Auth::user()->id;     

        $data['isProvider']=Helper::convertBooleanToInt($data['isProvider']);
        $data['isCustomer']=Helper::convertBooleanToInt($data['isCustomer']);
        
        
        $contact = Contact::findOrFail($id);
        try{
            $contact->update($data);    
        }
        catch (\exception $e){
            return response()
            ->json([
                'updated' => false,
                'message' => "No se pudo actualizar correctamente el contacto, intente de nuevo"            
            ]);
        }
        contact_others::where('contact_id', $contact->id)->delete();
        $contact->contact_others()->saveMany($items);
        
        return response()
            ->json([
                'updated' => true,
                'id' => $contact->public_id             
            ]);
    }
    
    //Obtener todos los reportes segun el filtro específico por cliente
    public function getContactReports($process_type, $contact_id)
    {
        $contact_field='customer_id';
        switch ($process_type)
        {
            case 'remision';
                return $this->contactsRepo->getRemisionList($contact_id,$contact_field);
                break;
            case 'estimate';
                return $this->contactsRepo->getEstimateList($contact_id,$contact_field);
                break;
            case 'invoice';
                return $this->contactsRepo->getInvoiceList($contact_id,$contact_field);
                break;
            case 'bill';
                return $this->contactsRepo->getBillList($contact_id,$contact_field);
                break;
            case 'credit_note';
                return $this->contactsRepo->getCreditNoteList($contact_id,$contact_field);
                break;
            case 'debit_note';
                return $this->contactsRepo->getDebitNoteList($contact_id,$contact_field);
                break;
            case 'po';
                return $this->contactsRepo->getPOList($contact_id,$contact_field);
                break;
            case 'payment';
                return $this->paymentRepo->getTransactions($contact_id,'customer_id');
                break;
                 
        };
    }

    public function destroy($id)
    {

            $contact = Contact::where('account_id',  Auth::user()->account_id)
                ->where('public_id',  $id)
                ->firstOrFail();   
            
            $contact['isDeleted']=1;
            $contact['deleted_at']=$now = Carbon::now();
            $contact->save();
            
            return response()
            ->json([
                'deleted' => true
            ]);
    }

    public function sendEmailToContact(Request $request)
    {

        $data=$request->all();
        $model=null;
        
        switch ($data['model_from'])
        {
            case 'estimate';
                $model=Estimate::class;              
                break;
            
            case 'credit-note';
                $model=CreditNote::class;              
                break;

            case 'remision';
                $model=Remision::class;              
                break;
            
            case 'invoice';
                $model=InvoiceSaleOrder::class;              
                break;

             case 'payment-in';
                $model=Payment::class;              
                break;

            case 'payment-out';
                $model=Payment::class;              
                break;

            case 'po';
                $model=PurchaseOrder::class;              
                break;
        
            default;
            
            break;
    
        };

               
        Mail::to($data['to'])
            ->send(new SendEmailToCustomer($data['body'],$data['subject'],$data['public_id'],$model, $this->pdfRepo));
      
      return response()
            ->json([
                'created' => true
            ]);
    }
}
