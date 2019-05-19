<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\Category;
use App\Models\Tax;
use Illuminate\Support\Facades\DB;

class DebitNoteDetail extends Model
{   
   
    protected $table = 'debit_note_detail';
    protected $fillable=['debit_note_id','user_id','category_id','unit_price','discount','tax_id','tax_amount',
    'name','description','quantity','total_tax','total'];
     protected $dates = ['deleted_at'];

    public function debitnote()
    {
        return $this->belongsTo(DebitNote::class);
    }

        public function category()
    {
        return $this->hasOne(Category::class, 'id', 'category_id')->select(array('id', 'name'));    
    }
        public function taxes()
    {
        return $this->hasOne(Tax::class, 'id', 'tax_id')->select(array(DB::raw("CONCAT(name,' (',amount,'%)') AS text"),'amount as value','id'));        
    }
    public static function initialize()
    {
        return [
            'unit_price'=>0,
            'quantity'=>1,
            'total'=>0,
            'category_id'=>null,
            'description'=>null,
            'discount'=>0,
            'tax_amount'=>null,
            'tax_id'=>null,
            'total_tax'=>null,
            'reference'=>null
        ];
    }
}
