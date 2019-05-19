<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Documents extends Model
{
    protected $table = 'documents';
    protected $fillable=['user_id','model_id','model','filename','new_filename'];
}
