<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Estimate;
class SettingsController extends Controller
{
    /**
     * Update the user's profile information.
     *
     * @param  \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function updateProfile(Request $request)
    {
 
        $user = $request->user();
        
        $this->validate($request, [
            'name' => 'required',
            'email' => 'required|email|unique:user,email,'.$user->id,
        ]);
        
      //  return tap($user)->update($request->only('name', 'email'));
         $estimate = Estimate::with('contact')
        ->GetAll(0)
        ->orderBy('created_at', 'desc')
        ->GetSelectedFields()
        ->get();
        
        return response()->json($estimate);

    }

    /**
     * Update the user's password.
     *
     * @param  \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function updatePassword(Request $request)
    {
        $this->validate($request, [
            'password' => 'required|confirmed|min:6'
        ]);

        $request->user()->update([
            'password' => bcrypt($request->password)
        ]);
    }
}
