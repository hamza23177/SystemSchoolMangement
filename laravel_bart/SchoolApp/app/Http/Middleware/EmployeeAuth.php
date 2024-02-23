<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class EmployeeAuth
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure(\Illuminate\Http\Request): (\Illuminate\Http\Response|\Illuminate\Http\RedirectResponse)  $next
     * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse
     */
    public function handle(Request $request, Closure $next)
    {

        if (!auth()->guard('employee')->user() )
        {
            $response=[
                'ststes'=>false,
                'message'=>'invaled token',
                'data'=>null,
            ];
            return response()->json($response, 401);
        }
        if (!auth()->guard('employee')->user()->active )
        {
            auth()->guard('employee')->logout();
            $response=[
                'ststes'=>false,
                'message'=>'invaled token',
                'data'=>null,
            ];
            return response()->json($response, 401);
        }
        return $next($request);
    }
}