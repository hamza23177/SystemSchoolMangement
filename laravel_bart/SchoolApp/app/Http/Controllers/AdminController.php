<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use App\Models\Admin;
use Carbon\Carbon;
use Ramsey\Uuid\Type\Time;
use Tymon\JWTAuth\Facades\JWTAuth;

class AdminController extends ResponseController
{
    
   // constructor
    public function __construct()
    {
      $this->middleware('AdminAuth:admin')->except('login','createAdmin');
    //  $this->middleware('BossAdmin:admin')->except('login','logout');
    }


 //////// create Admin
    
   public function createAdmin(Request $request){
    //  $d=date_parse("2022-07-05T13:00:18.000000Z");
    // //  return $d['year']+1;
    // return anArray($d);
       $validate=Validator::make($request->all(),
        [
           'name'=>'required',
           'phone'=>'required|unique:admins|string|phone|max:255',
           'password'=>'required|min:8|'
        ]);
    
       if($validate->fails()){
       return $this->responseError($validate->errors());
       }

        Admin::create(['name'=>$request->get('name'),
       'phone'=>$request->get('phone'),
       'password'=>Hash::make($request->get('password')),
            ] );

        $user=Admin::where('phone',$request->phone)->first();
        $token = JWTAuth::fromUser($user);
        return $this->responseData($token,'Registeration sccessful');
      }

  //////////// delet admin
    
    public function deletAdmin(Request $request){

      $validate=Validator::make($request->all(),
       [
          'phone'=>'required|exists:admins|string|phone|max:255',
       ]);
   
       if($validate->fails()){
       return $this->responseError($validate->errors());
       }
     
       $boss=Admin::where('id','=','1')->first();
    
       $admin= Admin::where('phone','=',$request->phone)->first();

       if(! $admin)
       {
        return $this->responseData([],'not found');
       }

       if($admin==$boss){
       return $this->responseData([],'cant delet this accoutn');
       }

       $admin->delete();
       return $this->responseData([],'deleted successfully');
     
   }
  //update admin
  public function updateAdmin(Request $request)
  {
      $validate=Validator::make($request->all(),
      [
      'phone'=>'required|string|exists:admins,phone|max:255',
      'oldpassword'=>'required|min:8|',
      'newpassword'=>'required|min:8|'
      ]);
      if($validate->fails()){
        return $this->responseError($validate->errors());
        }
      $admin=Admin::where('phone',$request->phone)->first();
     
      if(Hash::check($request->oldpassword,$admin->password))
      {

      $newpassword=Hash::make($request->get('newpassword'));
      $admin->password=$newpassword;
      Admin::where('phone',$request->phone)->first()->update(['password'=>$newpassword]);
      return $this->responseData($admin,'updated successfully');
      }
      return $this->responseData([],'invalid oldPassword');
  }
///////// Login
    
   public function login (Request $request)
   {
   
    $validate=Validator::make($request->all(),
    [
    'phone'=>'required|string|phone|max:255',
    'password'=>'required|min:8|'
    ]);

    if($validate->fails()){
                return $this->responseError($validate->errors());
    }
                   
    $credate=$request->only('phone','password');

    if (!auth()->guard('admin')->validate($credate) )
    {
      return $this->responseError('phone or password invalid');
    }

    $user =Admin::where('phone',$request->phone)->first();
    $token = JWTAuth::fromUser($user);
    return $this->responseData($token,'login sccessful');
}


//////// Logout

public function logout()
{
  $logout=auth()->guard('admin')->logout();
  return $this->responseData(null,'logout sccessful');
}

 }