<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;
use App\Http\Controllers\ResponseController;
use App\Models\Student;

class AuthStudentController extends ResponseController
{
     // constructor
 public function __construct()
 {
   $this->middleware('StudentAuth:students')->except('login');   
 }


/////////// login
    public function login (Request $request)
    
    {
     $validate=Validator::make($request->all(),
     [
     'full_name'=>'required|string|exists:students,full_name',
     'password'=>'required|min:8'
     ]);
 
     if($validate->fails()){
                 return $this->responseError($validate->errors());
     }
    
     $credate=$request->only('password','full_name');
 
     if (! $token=auth('student')->attempt($credate) )
     {
       return $this->responseError('username or password invalid');
     }
 
     $user =Student::where('full_name',$request->full_name)->first();
     
     
      return $this->responseData($user,$token,'login sccessful');
    }
 
//////////logout
public function logout()
{
  $logout=auth()->guard('student')->logout();
  return $this->responseData([],'logout sccessful');
}
}