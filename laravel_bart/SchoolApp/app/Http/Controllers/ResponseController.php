<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Http\Controllers\Controller ;
use Illuminate\Support\Facades\Hash;
use Tymon\JWTAuth\Facades\JWTAuth;
class ResponseController extends Controller
{
    public function responseError($messageError=[])
    {
      $response=[
          'states'=>false,
          'message'=>$messageError,
          'data'=>null,
      ];
      return response()->json($response, 400);
    }
    public function responseData($ruselt,$message)
    {
        $response=[
            'states'=>true,
            'message'=>$message,
            'data'=> $ruselt
        ];
        return response()->json($response, 200);

    }
 

    public function responseDatawithToken($ruselt,$token,$message)
    {
        $response=[
            'states'=>true,
            'message'=>$message,
            'token'=>$token,
            'data'=> $ruselt
        ];
        return response()->json($response, 200);

    }

    public function responseDatawithpassword($ruselt,$password,$full_name,$message)
    {
        $response=[
            'states'=>true,
            'message'=>$message,
            'password'=>$password,
            'full_name'=>$full_name,
            'data'=> $ruselt
        ];
        return response()->json($response, 200);

    }
}