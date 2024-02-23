<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;
use App\Http\Controllers\ResponseController;
use App\Models\Address;
use App\Models\ClassRoom;
use App\Models\Employee;
use Illuminate\Support\Facades\Hash;
use App\Models\Master;
use App\Models\Student;
use App\Models\Teacher;
class AdminqueareController extends ResponseController
{
    public function __construct()
    {
      $this->middleware('AdminAuth:admin');
    }

    
//////////////////// get class by name & level
    
    public function getClassByname(Request $request)
    {
        $validate=Validator::make($request->all(),
        [
            'room_name'=>'required',
            'level'=>'required',
         ]);

         if($validate->fails()){
            return $this->responseError($validate->errors());
           }

           $classroom=ClassRoom::where('level',$request->level)->where('room_name','=',$request->room_name)->first();
           if(!$classroom)
           {
            return $this->responseData([],'classroom not exists');
           }
         
           return $this->responseData( $classroom,'succeed');
    }

///////////// get all classes by level

    public function getClassesBylevel(Request $request)
    {
    
        $validate=Validator::make($request->all(),
        [
            'level'=>'required|exists:class_rooms,level',
         ]);

         if($validate->fails()){
            return $this->responseError($validate->errors());
           }

           $classroom=ClassRoom::where('level','=',$request->level)->get();
           
           return $this->responseData( $classroom,'succeed');
    }


//////////// get all classes

    public function allClasses(Request $request)
    {  
            $classroom=ClassRoom::latest()->orderBy('level', 'desc')->get();
          
           return $this->responseData( $classroom,'succeed');
    }


//////////////////// get student by name
    
    public function getStudentByname(Request $request)
    {
        $validate=Validator::make($request->all(),
        [
            'full_name'=>'required|exists:students,full_name',
        ]);

        if($validate->fails()){
            return $this->responseError($validate->errors());
        }

        $student=Student::where('full_name','=',$request->full_name)->first();
        return $this->responseData( $student,'succeed');
    }



//////////// get all student

    public function allStudent(Request $request)
    {  
        $student=Student::latest()->orderBy('full_name', 'asc')->get();
        return $this->responseData( $student,'succeed');
    }

//////////////////// get teacher by name
    
    public function getTeacherByName(Request $request)
    {
        $validate=Validator::make($request->all(),
        [
            'full_name'=>'required|exists:employees,full_name',
        ]);

        if($validate->fails()){
            return $this->responseError($validate->errors());
        }

        $employee=Employee::where('full_name','=',$request->full_name)->first();
        $teacher=Teacher::find($employee->id)->first();
    
        return $this->responseData( $teacher,'succeed');
    }



//////////// get all teacher

    public function allTeacher(Request $request)
    {  
            $teacher=Teacher::all();
        
        return $this->responseData( $teacher,'succeed');
    }

//////////////////// get master by name
    
    public function getMasterByname(Request $request)
    {
        $validate=Validator::make($request->all(),
        [
            'full_name'=>'required|exists:employees,full_name',
        ]);

        if($validate->fails()){
            return $this->responseError($validate->errors());
        }

        $employee=Employee::where('full_name','=',$request->full_name)->first();

        $master=Master::find($employee->id)->first();
    
        return $this->responseData( $master,'succeed');
    }



//////////// get all master

    public function allMaster(Request $request)
    {  
            $master=Master::all();
        
        return $this->responseData( $master,'succeed');
    }



}