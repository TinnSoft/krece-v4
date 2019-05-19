<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;
use Illuminate\Database\QueryException;
use Carbon\Carbon;
use App\Models\PaymentTerms;
use DB;

class PaymentTermsController extends Controller
{

   
    public function getPaymentTermsList()
    {
        $data= PaymentTerms::where('account_id',  Auth::user()->account_id)
                ->where('isDeleted',  0)
               ->orderBy('created_at', 'asc')
               ->select('id', 'account_id','user_id',
               'name','days','public_id'
               )
               ->get();  

               return response()
               ->json([
                   'form' =>  $data,
               ]);
    }

    public function create()
    {
        

        return response()
        ->json([
           'form' =>['name'=>null,'days'=>0],
        ]);
    }
        
    public function store(Request $request)
    {   
        $this->validate($request, [   
            'days' => 'required|numeric'
        ]);

        $data = $request->except('description'); 

        $currentPublicId = PaymentTerms::where('account_id',  Auth::user()->account_id)->max('public_id')+1;
        $data['public_id'] = $currentPublicId;
        $data['account_id'] = Auth::user()->account_id;
        $data['user_id'] = Auth::user()->id;    
                
        $payterm = PaymentTerms::create($data);
                  
        return response()
            ->json([
                'created' => true,
                'id' => $payterm->id
            ]);
    }


    public function edit($id)
    {    

          $paytermslist = PaymentTerms::where('account_id',  Auth::user()->account_id)
                ->where('isDeleted',  0)
                ->where('id',(int)$id)
               ->orderBy('created_at', 'desc')
               ->select('id','account_id','user_id',
               'name','days'
               )->first();           

      
         if (!$paytermslist)
        {
            $notification = array(
                'message' => 'No se encontró ninguna referencia creada!', 
                'alert-type' => 'error'
            );
          return redirect('/payterms')->with($notification);
        }
        return response()
        ->json([
           'form' => $paytermslist
        ]);

    }

   public function update(Request $request, $id)
    {       
      
        $this->validate($request, [                
            'days' => 'required|numeric'
        ]);
       
        $payterm = PaymentTerms::findOrFail($id);    
        $data = $request->except('payterm_type'); 
        $payterm->update($data);
        
        return response()
            ->json([
                'updated' => true,
                'id' => $payterm->id              
            ]);
    }
    
    public function destroy($id)
    {
            $payterm = PaymentTerms::findOrFail((int)$id);

            $payterm['isDeleted']=1;
            $payterm['deleted_at']=$now = Carbon::now();
            $payterm->save();
            
            return response()
            ->json([
                'deleted' => true
            ]);
    }

}
