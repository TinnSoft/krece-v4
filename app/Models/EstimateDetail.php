<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\Product;

class EstimateDetail extends Model
{   
   
    protected $table = 'estimate_detail';
    protected $fillable=['unit_price','quantity','total','product_id','description','user_id','discount',
    'tax_amount','tax_id','total_tax','reference'];
     protected $dates = ['deleted_at'];

    public function estimate()
    {
        return $this->belongsTo(Estimate::class);
    }

        public function product()
    {
        return $this->hasOne(Product::class, 'id', 'product_id')->select(array('id', 'name'));         
    }

    public static function initialize()
    {
        return [
            'unit_price'=>0,
            'quantity'=>1,
            'total'=>0,
            'product_id'=>null,
            'description'=>null,
            'discount'=>0,
            'tax_amount'=>null,
            'tax_id'=>null,
            'total_tax'=>null,
            'reference'=>null
        ];
    }
    
}
