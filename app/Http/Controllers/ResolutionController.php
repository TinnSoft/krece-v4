<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;
use Illuminate\Database\QueryException;
use Carbon\Carbon;
use App\Models\{
    Resolution,
    ResolutionNumber,
    Estimate,
    Remision
};


class ResolutionController extends Controller
{

   

     public function resolution_InvoiceNumbers()
    {
        return Resolution::where('account_id',  Auth::user()->account_id)
                ->where('isDeleted',  0)
                ->orderBy('public_id', 'asc')
                ->GetSelectedFields()
                ->get();    

    }
    public function resolutionAll()
    {
         $data = ResolutionNumber::where('account_id',  Auth::user()->account_id)              
                ->orderBy('id', 'asc')
                ->select('key','number','id','text','id')
                ->get();  
                
                return response()
                ->json([
                    'form' =>  $data,
                    'invoice'=>$this->resolution_InvoiceNumbers()
                ]);
    }

    public function create()
    {
        return response()
        ->json([
           'form' => Resolution::initialize(),
        ]);     
    }
        
    public function store(Request $request)
    {    
          $this->validate($request, [     
            'name' => 'required',
            'initial_number' => 'required_if:auto_increment,true'
            ]);        
        
        $data = $request->all();  

        $currentPublicId = Resolution::where('account_id',  Auth::user()->account_id)->max('public_id')+1;
        $data['public_id'] = $currentPublicId;
        $data['account_id'] = Auth::user()->account_id;
        $data['user_id'] = Auth::user()->id;     
        $data['isDefault'] = (int)$data['isDefault'] ;       
        $data['next_invoice_number'] =  $data['initial_number'];
        if ($data['auto_increment']=='true')
        {
            $data['auto_increment']=1;
        }
        else
        {
            $data['auto_increment']=0;
        }
        
        try{
       $item = Resolution::create($data);
        }
        catch(\exception $e){
             return response()
            ->json([
                'products_empty' => [$e]
            ], 422);
        }
        return response()
            ->json([
                'created' => true,
                'id' => $item->public_id
            ]);
    }

  

    public function edit($id)
    {
        
         $resol = Resolution::where('account_id',  Auth::user()->account_id)
                 ->where('isDeleted',  0)
                  ->where('id',  $id)
                ->orderBy('public_id', 'asc')
                ->GetSelectedFields()
                ->first();    
            
         if (!$resol)
        {
            $notification = array(
                'message' => 'No se encontró ningún valor en nuestra base de datos!', 
                'alert-type' => 'error'
            );
          return redirect('/resolution')->with($notification);
        }

        if ($resol['auto_increment']===1)
        {
            $resol['auto_increment']=true;
        }
        else
        {
            $resol['auto_increment']=false;
        }

        return response()
        ->json([
            'form' =>  $resol
        ]);
 
         
    }

    public function update(Request $request, $id)
    {   
        
        $this->validate($request, [     
            'name' => 'required',
            'initial_number' => 'required_if:auto_increment,true'
        ]);

        
        $data = $request->all();  
        $data['account_id'] = Auth::user()->account_id;
        $data['user_id'] = Auth::user()->id;
        $data['isDefault']=(int)$data['isDefault'];
         
       if ($data['isDefault']==1)
       {
           Resolution::where('account_id',  Auth::user()->account_id)
                 ->where('isDeleted',  0)
                 ->where('isDefault',1)            
                ->update(['isDefault' => 0]);
       }
        
       if ($data['auto_increment']=='true')
       {
           $data['auto_increment']=1;
       }
       else
       {
           $data['auto_increment']=0;
       }
     
        $item = Resolution::findOrFail($id);
        
        $item->update($data);

       
        
       
       $validateDefaults=Resolution::where('account_id',  Auth::user()->account_id)
                 ->where('isDeleted',  0)
                 ->where('isDefault',1)            
                ->count();
          

       if ($validateDefaults==0)
       {
           try{
         
                $toUpdate=Resolution::where('account_id',  Auth::user()->account_id)
                 ->where('public_id',1)  
                ->first();
               $toUpdate['isDefault']=1;
               $toUpdate->save();

           }
           catch (\exception $e){}
               
       }

        return response()
            ->json([
                'updated' => true,
                'id' => $item->public_id             
            ]);
    }
    
    public function update_state(Request $request,$id)
    {
            $data = $request->all(); 
            $data['isActive']= (int)$data['isActive'];
             
            $item = Resolution::findOrFail($id);
            if($item['isDefault']==1)
            {
                return response()
                ->json([
                'updated' => false,
                'custom_message'=>'No es posible actualizar este ítem ya que es principal, seleccione otro'                          
                ]);
            }
            $item->update($data);
            
            return response()
            ->json([
                'updated' => true,
                'custom_message'=>'Ítem Actualizado correctamente'                                                     
            ]);
    }

    public function update_numeration(Request $request)
    {
            $data = $request->all(); 
           
           $resolutionNumber=null;
           //solo actualizar el número de resolución cuando éste sea mayor al actual de la tabla correspondiente
            foreach($data as $item) {
                if(isset($item['id'])) {
                     
                     switch ($item['key']) {
                        case 'estimate':                                  
                                $resolutionNumber=  Estimate::where('account_id',  Auth::user()->account_id)->max('resolution_id')+1;                            
                            break;
                        case 'purchase_order':
                            //$resolutionNumber=  PurchaseOrder::where('account_id',  Auth::user()->account_id)->max('resolution_id')+1;
                            break;
                        case 'credit_note':
                            //$resolutionNumber=  CreditNote::where('account_id',  Auth::user()->account_id)->max('resolution_id')+1;
                            break;
                        case 'remision':
                            $resolutionNumber=  Remision::where('account_id',  Auth::user()->account_id)->max('resolution_id')+1;
                            break;
                         default:
                               // abort(404, 'Operación desconocida');
                                break;
                        }
                    if($resolutionNumber)
                    {
                        if ($item['number']>= $resolutionNumber)
                        {
                            ResolutionNumber::where('id',$item['id'])->update(['number'=>$item['number']]);
                        }

                    }
                    $resolutionNumber=null;
                } 
            }
           
            return response()
            ->json([
                'updated' => true                           
            ]);
    }

    public function destroy($id)
    {

            $data = Resolution::where('account_id',  Auth::user()->account_id)
                ->where('id',  $id)
                ->firstOrFail();   
            
            $data['isDeleted']=1;
            $data['deleted_at']=$now = Carbon::now();
            $data->save();
            
            return response()
            ->json([
                'deleted' => true
            ]);
    }
}
