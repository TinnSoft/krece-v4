<?php

namespace App\Models;


use Illuminate\Database\Eloquent\Model;
use App\Models\Contact;
use App\Models\Seller;
use App\Models\ListPrice;
use App\Utilities\DatesTranslator;
use Auth;
use App\Events\RecordActivity;
use App\Utilities\Helper;

class PurchaseOrder extends Model
{
	
	use DatesTranslator;
	
	
	protected $table = 'purchase_order';
	
	
	protected $fillable=[
	'public_id','customer_id','description','account_id','user_id','sub_total','total_discounts','total_taxes',
	'currency_code','observations','notes','date','due_date','total','isDeleted','resolution_id','terms','status_id'
	];
	
	protected $dates = ['deleted_at'];
	
	
	public function detail()
	{
		
		return $this->hasMany(PurchaseOrderDetail::class)->with('category','taxes');
		
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
		return $this->hasOne(Account::class,'id','account_id')->select(array('id','name','address','phone','identification','city','logo'));
	}
	
	public function scopeGetAll($query,$isDeleted)
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
                    'sub_total','total_discounts','total_taxes','total','date','due_date','notes','observations','exchange_rate',
                    'created_at','updated_at','resolution_id','status_id','terms');
	}

	public static function initialize()
    {

		

        return [
			'resolution_id'=>Helper::ResolutionId(ResolutionNumber::class,'purchase_order')['number'],
            'public_id' => Helper::PublicId(PurchaseOrder::class),
			'customer_id' => null, 
			'observations'=>null,
			'notes'=>null,
			'terms'=>null,
			'sub_total'=>0,
			'total_discounts'=>0,
			'total_taxes'=>0,
			'total'=>0,
			'currency_code'=>Helper::default_currency()['code'],
			'date' => null, 
			'due_date' => null,
            'detail' => [PurchaseOrderDetail::initialize()]
        ];
    }
}

