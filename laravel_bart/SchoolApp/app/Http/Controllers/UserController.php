<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class UserController extends Controller
{
     public function login()
    {
         return response()->json('re', 200);
    }
}