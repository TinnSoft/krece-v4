<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;
use Illuminate\Database\QueryException;
use Carbon\Carbon;
use App\Models\Retention;
use App\Models\RetentionType;
use DB;

class RetentionController extends Controller
{

    public function getRetentionList()
    {
        $data= Retention::with('retention_type')
                ->where('retention.account_id',  Auth::user()->account_id)
                ->where('retention.isDeleted',  0)
               ->orderBy('created_at', 'desc')
               ->select('retention.id', 'retention.account_id',
               'retention.name','retention.value','retention.description',
               'retention.type_id','public_id'
               )->get();  

               return response()
               ->json([
                   'form' =>  $data,
               ]);
    }
    public function create()
    {
        return response()
        ->json([
           'form' =>['name'=>null,'value'=>null, 'type_id'=>null, 'description'=>null],
           'base'=>$this->BaseInfo()
        ]);     
    }
        
    public function store(Request $request)
    {   
        $this->validate($request, [     
            'name' => 'required',               
            'value' => 'required|numeric',
            'type_id' => 'required',
        ]);
   
        $data = $request->except('retention_type'); 
       
        $data['account_id'] = Auth::user()->account_id;
        $data['user_id'] = Auth::user()->id;    

        $retention = Retention::create($data);
         
        return response()
            ->json([
                'created' => true,
                'id' => $retention->id
            ]);
    }


    public function BaseInfo()
    {  
        return RetentionType::select('id as value', 'name as label')              
               ->orderBy('id', 'asc')
               ->get();
    }

    public function edit( $id)
    {    

          $retentionlist = Retention::with('retention_type')
                ->where('account_id',  Auth::user()->account_id)
                ->where('isDeleted',  0)
                ->where('id',(int)$id)
               ->orderBy('created_at', 'desc')
               ->select('id','account_id',
               'name','value','description',
               'type_id'
               )->first();           
 
         if (!$retentionlist)
        {
            $notification = array(
                'message' => 'No se encontró ninguna referencia creada!', 
                'alert-type' => 'error'
            );
          return redirect('/retention')->with($notification);
        }
        return response()
        ->json([
           'form' => $retentionlist,
           'base'=>$this->BaseInfo()
        ]);

    }

   public function update(Request $request, $id)
    {       
      
        $this->validate($request, [     
            'name' => 'required',               
            'value' => 'required|numeric',
            'type_id' => 'required',
        ]);
       
        $retention = Retention::findOrFail((int)$id);    
        $data = $request->except('retention_type'); 
        $retention->update($data);
        
        return response()
            ->json([
                'updated' => true,
                'id' => $retention->id              
            ]);
    }
    
    public function destroy( $id)
    {
            $retention = Retention::findOrFail((int)$id);

            $retention['isDeleted']=1;
            $retention['deleted_at']=$now = Carbon::now();
            $retention->save();
            
            return response()
            ->json([
                'deleted' => true
            ]);
    }

}
