<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;
use App\Http\Controllers\ResponseController;
use App\Models\Employee;

class AuthEmployeeController extends ResponseController
{

 // constructor
 public function __construct()
 {
   $this->middleware('EmployeeAuth:employee')->except('login');   
 }

/////////// login

    public function login (Request $request)
    
    {
     $validate=Validator::make($request->all(),
     [
     'full_name'=>'required|string|exists:employees,full_name',
     'password'=>'required|min:8'
     ]);
 
     if($validate->fails()){
                 return $this->responseError($validate->errors());
     }
    
     $credate=$request->only('password','full_name');
 
     if (! $token=auth('employee')->attempt($credate) )
     {
       return $this->responseError('username or password invalid');
     }
 
     $user =Employee::where('full_name',$request->full_name)->first();
     
     
      return $this->responseData($user,$token,'login sccessful');
    }
 
//////////logout
public function logout()
{
  $logout=auth()->guard('employee')->logout();
  return $this->responseData([],'logout sccessful');
}
}