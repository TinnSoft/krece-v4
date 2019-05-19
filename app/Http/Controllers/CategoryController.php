<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;
use Illuminate\Database\QueryException;
use App\Models\{
    Category
};


class CategoryController extends Controller
{

    public function create()
    {
        return response()
        ->json([
            'form' => Category::initialize()
        ]);
    }
 
    public function CategoryIncome()
    {
        $income = Category::where('type_id',  CATEGORY_TYPE_INCOME)
                ->where('parent_id',"!=",  null)
                ->CategoryAttributes()              
                ->get()->toTree();

        return response()->json($income);  
    }

    public function CategoryAll()
    {   
        $categories=  Category::CategoryAttributes()->get()->toTree();
       
        return response()->json($categories);  
    }
        
    public function store(Request $request)
    {   
        $this->validate($request, [     
            'name' => 'required',
            'parent_id' => 'required',
        ]);
        
        $data = $request->all();  
          
          //get parent info
        $parent = Category::find($data['parent_id']);
        

        $newCategory=[ 'name' => $data['name'],
                    'account_id'=>Auth::user()->account_id,
                    'user_id'=>  Auth::user()->id,
                    'type_id'=>$parent['type_id'],
                     'niif_account'=>$data['niif_account'],
                    'isEditable'=>1,
                    'description'=>$data['description']
                    ];

        try{    
           Category::create($newCategory, $parent); 

        }
        catch(\exception $e){
              return response()
            ->json([
                'created' => false               
            ]);
        }

        return response()
            ->json([
                'created' => true               
            ]);
    }

    public function edit($id)
    {
         $category = Category::where('id',  $id)              
                ->orderBy('created_at', 'desc')
                ->first();    
         

         if (!$category)
        {
            $notification = array(
                'custom_message' => 'No se encontró ninguna referencia de categoría creadas!', 
                'alert-type' => 'error'
            );
            return response()
            ->json([
                $notification
            ]);
        }
 
        return response()
        ->json([
            'form' =>  $category
        ]);
         
         
    }


    public function update(Request $request, $id)
    {      
        $this->validate($request, [     
            'name' => 'required'
        ]);

        $data = $request->except('parent_id');     
       
        $category = Category::findOrFail($id);

       
        try{
            $category->update($data);    
        }
        catch (\exception $e){
            return response()
            ->json([
                'updated' => false,
                'message' => "No se pudo actualizar correctamente la categoría, intente de nuevo"            
            ]);
        }
      
        return response()
            ->json([
                'updated' => true                  
            ]);
    }
    
    public function destroy($id)
    {       

        try{
            $node = Category::findOrFail($id);
            $node->delete();
            return response()
            ->json([
                'deleted' => true
            ]);
        }
        catch(\exception $e){
            return response()
            ->json([
                'deleted' => false
            ]);
        }
    }
    
}
