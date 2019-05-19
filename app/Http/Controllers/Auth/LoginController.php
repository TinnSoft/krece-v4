<?php

namespace App\Http\Controllers\Auth;

use Auth;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use App\Events\UserLoggedIn;
use App\Events\RecordActivity;
use Illuminate\Auth\SessionGuard;

class LoginController extends Controller
{
    /*
    |--------------------------------------------------------------------------
    | Login Controller
    |--------------------------------------------------------------------------
    |
    | This controller handles authenticating users for the application and
    | redirecting them to your home screen. The controller uses a trait
    | to conveniently provide its functionality to your applications.
    |
    */

    use AuthenticatesUsers;

    /**
     * Where to redirect users after login.
     *
     * @var string
     */
    //protected $redirectTo = '/home';

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('guest')->except('logout');
    }

    protected function attemptLogin(Request $request)
    {   
        $token = $this->guard()->attempt($this->credentials($request));       
        //  abort(404);
        if ($token) {
            $this->guard()->setToken($token);

            return true;
        }

        return false;
    }

    protected function sendLoginResponse(Request $request)
    {
        
        $this->clearLoginAttempts($request);

        $token = (string) $this->guard()->getToken();
        $expiration = $this->guard()->getPayload()->get('exp');

        
        event(new UserLoggedIn());
        
        event(new RecordActivity('LogIn',$this->guard()->user()->name.' ha iniciado sesion',
        'User','/profile/'.$this->guard()->user()->id.'/edit'));


        return [
            'token' => $token,
            'token_type' => 'bearer',
            'expires_in' => $expiration - time(),
        ];
    }
    /**
     * Log the user out of the application.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function logout(Request $request)
    {
        try{
        $this->guard()->logout();
        }catch(\Exception $e){
            Session::flush();
            Session::regenerate();
            return redirect('login');
        }       
       
       //return redirect('/');
    }
}
