<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use File;
use Carbon\Carbon;
use App\Models\Documents;


class UploadController extends Controller
{
    protected $rootFolder='public/krece';

    public function uploadDocument(Request $request)
    {
        //verifica si el directorio está creado
        Storage::makeDirectory($this->rootFolder);
       

        if ($request->hasfile('file') && $request->file('file')->isValid()) {
            
            $originalName=$request->file->getClientOriginalName();
            $model=$request->all()['model'];
            $publicID=$request->all()['publicID'];
            $lastfilename=Storage::putFile($this->rootFolder, $request->file('file'));

            $documentsModel= new Documents;
            $documentsModel->user_id=Auth::user()->id;
            $documentsModel->model_id=$publicID;
            $documentsModel->model=$model;
            $documentsModel->filename=$originalName;
            $documentsModel->new_filename=$lastfilename;
            $documentsModel->save();

            return response()
            ->json([
               'saved' => true,
               'list' => $this->documentList($publicID, $model)
            ]);
        }

        return response()
        ->json([
            'saved' => false
        ], 422);
    }


    public function getDocuments($id, $model)
    {
        $documentlist= $this->documentList($id, $model);

        return response()
        ->json([
           'list' => $documentlist
        ]);
    }

    private static function documentList($id, $model)
    {
        return Documents::where('user_id', Auth::user()->id)
        ->where('model_id', '=', $id)
        ->where('model', '=', $model)
        ->orderBy('created_at', 'desc')
        ->select('id', 'filename', 'new_filename', 'created_at')->get();
    }

  
    public function delete($id)
    {
      
        try {
            $documentRow = Documents::findOrFail($id);
            $fileName=$documentRow->new_filename;
            Storage::delete($fileName);
            $documentRow->delete();
            return response()
            ->json([
                'deleted' => true
            ]);
        } catch (\exception $e) {
            return response()
            ->json([
                'deleted' => false
            ]);
        }
    }

    public function download($id)
    {
        try {
            $documentRow = Documents::findOrFail($id);
            $fileName=$documentRow->new_filename;
            //return response()->download(storage_path($fileName)); 
            $name=$documentRow->filename;
            $headers='';

            //return response()->file($fileName);
          // return response()->download($fileName);
           return response()->download(storage_path($fileName)); 
           //return storage_path($fileName)->download($filename);
           
        } catch (\exception $e) {
            return response()
            ->json([
                'download' => false
            ]);
        }

        
    }
}
