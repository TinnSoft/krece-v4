<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Auth;

class Contact extends Model
{
    protected $table = 'contact';
    protected $dates = ['deleted_at'];

    protected $fillable = [
        'name','nit','address','account_id','user_id','public_id','city','email','phone1','phone2','fax',
        'phone_mobile','list_price_id','seller_id','payment_terms_id','observation','include_account_state','isProvider','isCustomer',
        'isDeleted','deleted_at'
    ];

   
     public function contact_others()
    {
        return $this->hasMany(Contact_others::class);
    }

    public function estimates()
    {
        return $this->hasMany(Estimate::class);
    }
      public function list_price()
    {
        return $this->hasOne(ListPrice::class, 'id', 'list_price_id')->select(array('id', 'name'));
    }
     public function seller()
    {
        return $this->hasOne(Seller::class, 'id', 'seller_id')->where('isEnabled',1)->where('isDeleted',0)->select(array('id', 'name'));        
    }
     public function payment_terms()
    {
        return $this->hasOne(PaymentTerms::class, 'id', 'payment_terms_id')->select(array('id', 'name'));        
    }
    public function scopeGetCustomerAttributes($query)
    {
        return $query->where('account_id',  Auth::user()->account_id)
                ->where('isDeleted', 0)                       
                ->select('id', 'name','nit','address','account_id','user_id','public_id','city','email','phone1','phone2','fax',
                    'phone_mobile','list_price_id','seller_id','payment_terms_id','observation','include_account_state',
                    'isProvider','isCustomer');

    }

    public static function initialize()
    {
        return [
			'name'=>null,
			'nit'=>null,
			'address'=>null,
			'email' => null, 
			'city'=>null,
			'phone1'=>null,
			'phone2'=>null,
			'fax'=>null,
			'phone_mobile'=>null,
			'observation'=>null,
			'seller_id'=>null,
            'isCustomer' => false, 
            'isProvider' => false, 
			'payment_terms_id'=>null,
			'list_price_id' => null
        ];
    }

}
