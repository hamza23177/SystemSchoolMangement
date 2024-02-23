<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class TestEventController extends Controller
{
    public function testEvent(Request $request) 
    {
         $firstName = $request->first_name;
         $lastName = $request->last_name;
         $account_detail = ['fname'=>'$firstName','lname'=>'$lastName'];
        $event = ''; 
        event(new TestEventController($account_detail)); 
        return response()->json(['status'=>'success','data'=>$account_detail]);
     }

  
}