<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;
use App\Http\Controllers\ResponseController;
use App\Models\AffiliationRequestEmployee;
use App\Models\AffiliationRequestStudent;

class AffiliationRequestController extends ResponseController
{
 
    public function affiliation_request_employee(Request $request)
    {
        $validate=Validator::make($request->all(),
        [
            'name'=>'required|max:200',
            'phone'=>'required|numeric',
            'name_degree'=>'required|max:200',
            'target_job'=>'required|max:200',
            'subject_target'=>'required|max:200',
            'cv'=>'mimes:jpg,jpeg,png,gif,pdf,docx,pptx,zip,rar|max:10000'
           
        ]);

        if($validate->fails()){
            return $this->responseError($validate->errors());
        }
        $affrequest= AffiliationRequestEmployee::create([

            'name'=>$request->get('name'),
            'phone'=>$request->get('phone'),
            'name_degree'=>$request->get('name_degree'),
            'target_job'=>$request->get('target_job'),
            'subject_target'=>$request->get('subject_target'),
           
        ] );
        if($request->cv){
            $file=time().'.'.$request->file->extension();
            $request->file->move(storage_path('app/CV'),$file);
            $affrequest->cv=$file;
            $affrequest->save();        
        }

        return $this->responseData($affrequest,'successful');
     
    }

    public function affiliation_request_student(Request $request)
    {
        $validate=Validator::make($request->all(),
        [
            'name'=>'required|max:200',
            'phone'=>'required|numeric',
            'last_level'=>'required|max:200',
            'last_level_degree'=>'required|max:200',
            'target_level'=>'required|max:200',
         ]);

         if($validate->fails()){
            return $this->responseError($validate->errors());
           }
           $affrequest= AffiliationRequestStudent::create([

            'name'=>$request->get('name'),
            'phone'=>$request->get('phone'),
            'last_level'=>$request->get('last_level'),
            'last_level-degree'=>$request->get('last_level_degree'),
            'target_level'=>$request->get('target_level'),
           
            ] );       
            
    
           
           
            return $this->responseData($affrequest,'successful');
     
    }


}