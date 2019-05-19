<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Resolution extends Model
{   
    protected $dates = ['deleted_at'];
    protected $table = 'resolution';
    protected $fillable=['public_id','user_id','account_id','name','next_invoice_number',
    'prefix','invoice_text',
    'isDefault','isActive','auto_increment','deleted_at','isDeleted','initial_number'];

     public function scopeGetSelectedFields($query)
    {
        return $query->select('id','public_id','next_invoice_number','name','prefix','invoice_text','isDefault','isActive',
        'auto_increment','initial_number','final_number');
    }
    public static function initialize()
    {

        return [
            'name'=>null,
            'initial_number'=>null,
			'next_invoice_number'=>null,
			'prefix'=>null,
            'invoice_text' =>null,
			'isDefault' => '0', 
			'auto_increment'=>true,
      ];
    }
}
