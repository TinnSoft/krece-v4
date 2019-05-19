<?php

namespace App\Models;

//use Laravel\Passport\HasApiTokens;
use Tymon\JWTAuth\Contracts\JWTSubject;
use Illuminate\Notifications\Notifiable;
use Illuminate\Foundation\Auth\User as Authenticatable;


class User extends Authenticatable implements JWTSubject
{
    use  Notifiable;
    //HasApiTokens
    
    protected $table = 'user';
    protected $dates = ['deleted_at'];
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name', 'email', 'password','account_id','last_login','phone','role_id',
        'last_name','remember_token','transaction_token','status_id','modified_by',
        'created_by','public_id','is_admin'
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'remember_token','transaction_token',
        'created_at','updated_at','deleted_at','modified_by','created_by',
        'oauth_user_id','oauth_provider_id'
    ];

    public function rules()
    {
        return [
            'name' => 'required|max:255',
            'email' => 'required|email|max:255|unique:user',
            'password' => 'required|min:6|confirmed',
        ];
    }
    
    public function getJWTIdentifier()
    {
    
        return $this->getKey();
    }

    /**
     * @return array
     */
    public function getJWTCustomClaims()
    {
        return [];
    }
   
}
