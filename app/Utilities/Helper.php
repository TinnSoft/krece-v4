<?php namespace App\Utilities;
use App\Models\{
    Seller,
    Tax,
    ListPrice,
    Contact,
    Product,
    PaymentTerms,
    Category
};
use Illuminate\Support\Facades\DB;
use Auth;
use Carbon\Carbon;

class Helper
{
 public static function formatMoney($value)
 {
     $valconverted=$value;
     try{
     $valconverted=number_format($value, '2', '.', ',');
     }
     catch(\exception $e){}

    return $valconverted;
 }
   public static function setCustomDateFormat($dateval)
    {   
        //Convertir formato a ISO8601   
       // $day=$dateval->day;
       // $month=$dateval->month;
       // $year=$dateval->year;
       // return $day.'/'. $month.'/'.$year;   
       return $dateval->toIso8601String();
    }

    public static function currencylist()
    {
       return  DB::table('currency')
        ->join('currency_code', function ($join) {
            $join->on('currency.code_id', '=', 'currency_code.code')
                 ->where('currency.account_id', Auth::user()->account_id);
        })
        ->orderBy('currency_code.order', 'desc')
               ->select('currency.code_id', 'currency_code.code','currency_code.symbol',
               'currency_code.code as label','currency.code_id as value')
               ->get()
                ->toArray();
    }
     public static function bank_account()
    {
            return DB::table('bank_account')
                ->join('bank_account_type', 'bank_account.bank_account_type_id', '=', 'bank_account_type.id')
                ->where('bank_account.account_id',Auth::user()->account_id)
                ->where('bank_account.isDeleted','=',0)
                ->orderBy('bank_account_type.description', 'asc')
                ->select('bank_account.id', 'bank_account.id as value','bank_account.bank_account_name as label',  'bank_account_type.description as stamp')
                ->get();
    }

    public static function contacts()
    {
         return Contact::with('seller')
                ->select('id', 'name','seller_id','public_id','name as label','id as value')
                ->where('account_id',  Auth::user()->account_id)->where('isCustomer', '=', 1)
                ->where('isDeleted',0)
               ->orderBy('created_at', 'asc')
               ->get()
               ->toArray();
    }

    public static function providers()
    {
         return Contact::with('seller')
                ->select('id', 'name','seller_id','public_id', 'id as value','name as label')
                ->where('account_id',  Auth::user()->account_id)->where('isProvider', '=', 1)
                ->where('isDeleted',0)
               ->orderBy('created_at', 'asc')
               ->get()
                ->toArray();
    }


    public static function sellers()
    {

        return Seller::select('id', 'name','name as label','id as value')
                ->where('account_id',  Auth::user()->account_id)
                ->where('isDeleted',  0)
                ->where('isEnabled',  1)
               ->orderBy('created_at', 'asc')
               ->get()
               ->toArray();
    }

    public static function listPrice()
    {
         return ListPrice::select('id', 'name','name as label','id as value')
                ->where('account_id',  Auth::user()->account_id)
                ->where('isDeleted',  0)
               ->orderBy('created_at', 'asc')
               ->get()
               ->toArray();
    }
    public static function taxes()
    {
       return Tax::select(DB::raw("CONCAT(name,' (',amount,'%)') as label"),'amount','id','id as value')
       ->where('account_id',  Auth::user()->account_id)
                ->where('isDeleted',  0)
               ->orderBy('created_at', 'asc')
               ->get()
               ->toArray();
    }

    //Cuando la variable $INV es diferente de null entonces trae únicamente los ítems inventariables
    //Caso contrario trae todos los productos activos
    public static function productlist($Inv=null)
    {
       $query=  Product::select('id', 'name','description','sale_price','reference','public_id',
       'id as value', 'name as label')
                    ->where('account_id',  Auth::user()->account_id)
                    ->where('isDeleted',  0)
                    ->where('isActive',  1)
                ;
          if ($Inv==true)
          {
               $query= $query->where('inv_inStock',  1);
          }
        
        return $query 
                ->orderBy('created_at', 'asc') 
                ->get()
                ->toArray();
    }
   

     public static function category_outcome()
    {
        /*
        return Category::with('detail')
                    ->select('id', 'name','type_id','id as value', 'name as label')
                    ->where('account_id',  Auth::user()->account_id)
                    ->where('isDeleted',  0)
                    ->whereIn('type_id', [2])
                   // ->whereIsRoot()
                ->orderBy('created_at', 'asc')
                ->get()
                ->toArray();*/

               return DB::table('category')
                ->join('category_type', 'category_type.id', '=', 'category.type_id')
                ->where('category.account_id',Auth::user()->account_id)
                ->where('category.parent_id','>',0)
                ->select('category.id','category.type_id', 'category.name', 'category.name as label','category.id as value', 'category_type.type as stamp')
                ->get();
    }


     public static function category_all()
    {
        return Category::
        //Category::with('detail')
                    //->select('id as value', 'name as label','type_id')
                    select('id as value', 'name as label')
                    ->where('account_id',  Auth::user()->account_id)
                    ->where('isDeleted',  0)
                   // ->whereIsRoot()
                ->orderBy('created_at', 'asc')
                ->get()
                ->toArray();
    }

      public static function PaymentTerms()
    {
        return PaymentTerms::select('id as value', 'name as label','days')
                    ->where('account_id',  Auth::user()->account_id)
                    ->where('isDeleted',  0)
                ->orderBy('created_at', 'asc')
                ->get()
                ->toArray();
        
    }

    public static function ResolutionId($model,$key)
    {
        return $model::where('account_id',  Auth::user()->account_id)
                        ->where('key','=',$key)
                        ->select('number')
                        ->first()
                        ->toArray();
    }
    public static function PublicId($model)
    {
         return $model::where('account_id',  Auth::user()->account_id)->max('public_id')+1;
    }

    public static function listprice_default()
    {
        return ListPrice::select('id', 'name')
                ->where('account_id',  Auth::user()->account_id)
                ->where('isDeleted',  0)
               ->orderBy('created_at', 'asc')
               ->first();
    }

    public static function default_currency()
    {
         return [
            'code_id' => CURRENCY_CODE_DEFAULT,
           'code' => CURRENCY_CODE_DEFAULT,
           'symbol' => '$'];
    }
    //realiza el formato de mneda y fecha para los arreglos tipo factura (nvoice, remision, estimate, etc..)
    public static function _InvoiceFormatter($model_in)
    {
        $model_in['total']=Helper::formatMoney($model_in['total']);
        $model_in['sub_total']=Helper::formatMoney($model_in['sub_total']);
        $model_in['total_taxes']=Helper::formatMoney($model_in['total_taxes']);
        $model_in['total_discounts']=Helper::formatMoney($model_in['total_discounts']);
       
       foreach($model_in->detail as $item) 
        {
            $item['unit_price']=Helper::formatMoney($item['unit_price']);
            $item['total']=Helper::formatMoney($item['total']);
        }  
        
        $model_in['date']= Carbon::parse($model_in['date'])->toFormattedDateString(); 
        $model_in['due_date']=Carbon::parse($model_in['due_date'])->toFormattedDateString(); 

        return $model_in;
    }

    public static function _taxesFormatter($model_in)
    {
        foreach($model_in as $item) 
        {           
            $item->total=Helper::formatMoney($item->total);
        }
        return $model_in;
    }

    public static function dateFormatter($date)
    {
        return Carbon::parse($date);//parse from ISO8601 format
    }

     public static function getTotalTaxes($invoice_id, $mainTable, $detailTable)
        {
            $taxes=
            DB::table($mainTable)
            ->join($detailTable, $mainTable.'.id', '=', $detailTable.'.'.$mainTable.'_id')
            ->join('tax', $detailTable.'.tax_id', '=', 'tax.id')
            ->where($mainTable.'.account_id',Auth::user()->account_id)
            ->where($mainTable.'.public_id',$invoice_id)
            ->where($detailTable.'.tax_amount','>',0)
            ->select(DB::raw("CONCAT(tax.name,' (',".$detailTable.".tax_amount,'%)') AS name"),
            DB::raw('SUM('.$detailTable.'.total_tax) as total'))
            ->groupBy('tax.name',$detailTable.'.tax_amount')
            ->get();
            
            return  Helper::_taxesFormatter($taxes);
        }

    public static function convertBooleanToInt($data)
    {
        if ($data==true)
        {
            return 1;
        }
        return 0;
    }
}