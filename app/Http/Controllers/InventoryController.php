<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;
use Illuminate\Database\QueryException;
use Carbon\Carbon;
use App\Models\{
    ProductInventoryType,
    product_inventory_type,
    Seller,
    Tax,
    ListPrice,
    Product
};
use App\Utilities\Helper;
use App\Contracts\IProductsRepository;
use DB;
use App\Repositories\PaymentRepository;

class InventoryController extends Controller
{
    protected $productRepo;
    protected $paymentRepo;

     public function __construct(IProductsRepository $productRepo, PaymentRepository $paymentRepo)
     {
        $this->productRepo = $productRepo;
        $this->paymentRepo = $paymentRepo;
    }
    

     public function InventoryIndex()
    {
       $products = Product::where('account_id',  Auth::user()->account_id)
                ->where('isDeleted',  0)
                ->orderBy('public_id', 'desc')
                ->select( 'name','reference','sale_price','description','isActive','public_id','tax_id','category_id','id','list_price_id'
               )->get();    

               return response()
               ->json([
                   'records' => $products
               ]);
    }

   
    public function BaseInfo()
    {
    
        $measure_unit = ProductInventoryType::select('measure_unit  as label','id as value', 'measure_type as stamp')        
        ->orderBy('id', 'asc')
        ->get()
        ->toArray();
        
        $baseInfo=[                
                'taxes' => Helper::taxes(),
               'measure_unit'=>$measure_unit,
               'listprice'=>Helper::listPrice()              
            ];
             
     return $baseInfo;

    }

    public function create()
    {
        return response()
        ->json([
            'form' => Product::initialize(),
            'base' => $this->BaseInfo()
        ]);
    }
        
    public function store(Request $request)
    {                

          $this->validate($request, [     
            'name' => 'required',
            'sale_price' => 'required',
            'tax_id' => 'required',
            'category_id' => 'required',
            'inv_type_id'=>'required_if:inv_inStock,1',
            'inv_unit_cost'=>'required_if:inv_inStock,1',
            'inv_quantity_initial'=>'required_if:inv_inStock,1'
            ]);        
        
        $data = $request->except('tax','list_price');  

         

        $currentPublicId = Product::where('account_id',  Auth::user()->account_id)->max('public_id')+1;
        $data['public_id'] = $currentPublicId;
        $data['account_id'] = Auth::user()->account_id;
        $data['user_id'] = Auth::user()->id;       
        if ( $data['inv_inStock']==true)
         {
              $data['inv_inStock'] =1;
         }
         elseif ( $data['inv_inStock']==false)
         {
              $data['inv_inStock'] =0;
         }
         else 
         {
              $data['inv_inStock'] =0;
         }
       
        
       $item = Product::create($data);
     
        return response()
            ->json([
                'created' => true,
                'id' => $item->public_id
            ]);
    }

    public function getInventoryReports($process_type, $product_id)
    {      
        $filter_field='product_id';
        switch ($process_type)
        {
            case 'remision';
                return $this->productRepo->getRemisionList($product_id, $filter_field);
                break;
            case 'estimate';
                return $this->productRepo->getEstimateList($product_id, $filter_field);
                break;
            case 'invoice';
                return $this->productRepo->getInvoiceList($product_id, $filter_field);
                break;
            case 'bill';
                return $this->productRepo->getBillList($product_id, $filter_field);
                break;
            case 'credit_note';
                return $this->productRepo->getCreditNoteList($product_id, $filter_field);
                break;
            case 'debit_note';
                return $this->productRepo->getDebitNoteList($product_id, $filter_field);
                break;
            case 'po';
                return $this->productRepo->getPOList($product_id, $filter_field);
                break;
                 
        };
    }

    private static function getProductList($id){
        return  Product::with(['tax','list_price','measure_unit','category'])
                ->where('account_id',  Auth::user()->account_id)
                ->where('public_id',  $id)
                ->where('isDeleted',  0)
                ->orderBy('created_at', 'desc')
                ->select( 'id','name','reference','sale_price','description','tax_id','public_id','inv_type_id','list_price_id',
                'inv_unit_cost','inv_inStock','inv_quantity_initial','isActive','inv_quantity_actual','category_id'
                )->first();  
    }

    public function show($id)
    {
         $products = $this->getProductList($id);

        if (!$products)
        {
            $notification = array(
                'message' => 'No se encontró ninguna referencia en nuestra base de datos!', 
                'alert-type' => 'error'
            );

          return redirect('/inventory')->with($notification);
        }
      
         
        return response()
        ->json([
            'model' => $products,
        ]);
    }

    public function edit($id)
    {
        
         $products = $this->getProductList($id);
        
         if (!$products)
        {
            $notification = array(
                'message' => 'No se encontró ningún valor en nuestra base de datos!', 
                'alert-type' => 'error'
            );
          return redirect('/inventory')->with($notification);
        }

        if ( $products['inv_inStock']==1)
        {
             $products['inv_inStock'] =true;
        }
        else if( $products['inv_inStock']==0)
        {
             $products['inv_inStock'] =false;
        }
        
        return response()
        ->json([
            'form' =>  $products,
            'base' => $this->BaseInfo()
        ]);
         
    }

    

    public function update(Request $request, $id)
    {   
        //Actualizar solamente de activo para inactivo o biseversa
        try{
            $data = $request->except('tax');         
            $avoidValidate=$data['validate'];
            $data = $request->except('validate'); 
             $data['isActive']= (int)$data['isActive'];

            $item = Product::findOrFail($id);
            $item->update($data);
            
            return response()
            ->json([
                'updated' => true                           
            ]);
        }
        catch(\exception $e){}

        $this->validate($request, [     
            'name' => 'required',
            'sale_price' => 'required',
            'tax_id' => 'required',
            'category_id' => 'required',
            'inv_type_id'=>'required_if:inv_inStock,1',
            'inv_unit_cost'=>'required_if:inv_inStock,1',
            'inv_quantity_initial'=>'required_if:inv_inStock,1'
        ]);
        
    
      
        $data = $request->except('list_price','measure_unit','tax');  
        $data['account_id'] = Auth::user()->account_id;
        $data['user_id'] = Auth::user()->id;
         
         if ( $data['inv_inStock']==true)
         {
              $data['inv_inStock'] =1;
         }
         elseif ( $data['inv_inStock']==false)
         {
              $data['inv_inStock'] =0;
         }
         else 
         {
              $data['inv_inStock'] =0;
         }

        $item = Product::findOrFail($id);
        $item->update($data);
       
        return response()
            ->json([
                'updated' => true,
                'id' => $item->public_id             
            ]);
    }
    
    public function destroy($id)
    {

            $contact = Product::where('account_id',  Auth::user()->account_id)
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
}
