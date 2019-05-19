<?php

namespace App\Models;


use Illuminate\Database\Eloquent\Model;
use App\Models\Contact;
use App\Models\Seller;
use App\Models\ListPrice;
use App\Utilities\DatesTranslator;
use Auth;
use App\Utilities\Helper;


class Bill extends Model
{
	
	use DatesTranslator;
	
	
	protected $table = 'bill';
	
	
	protected $fillable=[
	'public_id','customer_id','description','account_id','user_id','sub_total','total_discounts','total_taxes',
	'currency_code','observations','date','due_date','list_price_id','total','isDeleted','resolution_id',
	'status_id'
	];
	
	protected $dates = ['deleted_at'];
	
	
	public function detail()
	{
		
		return $this->hasMany(BillDetail::class)->with('category','taxes');
		
	}
	
	
	public function contact()
	{
		
		return $this->hasOne(Contact::class, 'id', 'customer_id')->select(array('id', 'name','address','city','nit','phone1','public_id'));
		
	}
	
	
	public function currency()
	{
		
		return $this->hasOne(Currency::class, 'code_id','currency_code')->select(array('code_id as code', 'code_id'));
		
	}
	
	public function account()
	{
		return $this->hasOne(Account::class,'id','account_id')->with('account_regime')
		->select(array('id','name','address','phone','identification','city','logo','regime_id'));
	}
	
	public function scopeAccountID($query,$isDeleted)
	{
		
		return $query->where('account_id',  Auth::user()->account_id)
                ->where('isDeleted',$isDeleted);
	}
	
	  public function scopeGetByPublicId($query,$isDeleted,$id)
    {
        return $query->where('account_id',  Auth::user()->account_id)
                ->where('isDeleted',$isDeleted)
                 ->where('public_id',  $id);
    }

	 public function scopeGetSelectedFields($query)
    {
        return $query->select('id','account_id','public_id','customer_id','currency_code',
                    'sub_total','total_discounts','total_taxes','total','date','due_date','observations','exchange_rate',
                    'created_at','updated_at','resolution_id','status_id');
	}

	public static function initialize()
    {

        return [
			'resolution_id'=>Helper::ResolutionId(ResolutionNumber::class,'bill')['number'],	
            'public_id' => Helper::PublicId(Bill::class),
			'customer_id' => null, 
			'observations'=>null,
			'sub_total'=>0,
			'total_discounts'=>0,
			'total_taxes'=>0,
			'total'=>0,
			'seller_id'=>null,
			'currency_code'=>Helper::default_currency()['code'],
			'date' => null, 
			'due_date' => null,
            'detail' => [BillDetail::initialize()]
        ];
    }
}

