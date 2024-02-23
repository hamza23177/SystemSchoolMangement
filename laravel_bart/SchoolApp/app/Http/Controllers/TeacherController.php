<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;
use App\Http\Controllers\ResponseController;
use App\Models\Absence_Let_emp;
use App\Models\Class_Note;
use App\Models\Class_StudyFile;
use App\Models\Class_Teacher;
use App\Models\ClassRoom;
use App\Models\Employee;
use App\Models\Note;
use App\Models\Student;
use App\Models\Student_Note;
use App\Models\StudyFile;
use App\Models\Teacher;
use App\Models\Valuation;
use Illuminate\Support\Facades\File as FacadesFile;

class TeacherController extends ResponseController
{
    
       
    // constructor    
    public function __construct() 
    {
       $this->middleware('EmployeeAuth:employee');     
    }


///////// set Valuation

    public function setValuation(Request $request)
    {
        $validate=Validator::make($request->all(),
        [
            'description'=>'required',
            'lecture'=>'required',
            'subject'=>'required',
            'student_id'=>'required|exists:students,id'
        
        ]);

        if($validate->fails()){
            return $this->responseError($validate->errors());
        }
        
        $valuation=Valuation::create([
            'description'=> $request->description,
            'teacher_id'=> $request->user('employee')->id,
            'lecture'=> $request->lecture,
            'subject'=> $request->subject,
            'student_id'=> $request->student_id,
        ]);
     

        return $this->responseData( $valuation,'succeed');
    }
////////////////// set note student 

    public function setNoteStudent(Request $request)
    {
        $validate=Validator::make($request->all(),
        [
            'note'=>'required',
            'student_id'=>'required|exists:students,id'
        ]);

        if($validate->fails()){
            return $this->responseError($validate->errors());
        }
        
        $note=Note::create([
            'note'=> $request->note,
            'employee_id'=> $request->user('employee')->id,
        ]);
        $student_note=Student_Note::create([
            'note_id'=> $note->id,
            'student_id'=> $request->student_id,
        ]);

        return $this->responseData( $student_note,'succeed');
    }

////////////////// set note Class 

    public function setNoteClass(Request $request)
    {
        $validate=Validator::make($request->all(),
        [
            'note'=>'required',
            'class_room_id'=>'required|exists:class_rooms,id'
        ]);

        if($validate->fails()){
            return $this->responseError($validate->errors());
        }
        
        $note=Note::create([
            'note'=> $request->note,
            'employee_id'=> $request->user('employee')->id,
        ]);
        $class_note=Class_Note::create([
            'note_id'=> $note->id,
            'class_room_id'=> $request->class_room_id,
        ]);

        return $this->responseData( $class_note,'succeed');
    }

    
//////////// get class by name & level
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

    public function getClassesByLevel(Request $request)
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

 //////////// get class by ID
 
       public function getClassById(Request $request)
       {
           $validate=Validator::make($request->all(),
           [
               'classroom_id'=>'required|exists:class_rooms,id',
               
            ]);
   
            if($validate->fails()){
               return $this->responseError($validate->errors());
              }
   
              $classroom=ClassRoom::where('id',$request->classroom_id)->with('student')->first();
              
              return $this->responseData( $classroom,'succeed');
       }

///////////// get my classes 

    public function getMyClasses(Request $request)
    {

        $teacher=Teacher::where('employee_id',$request->user('employee')->id)->first();
        $classroom=Class_Teacher::where('teacher_id',$teacher->id)->get();
        $list=[];
        foreach ($classroom as $key => $value) {
           
           array_push($list,$value["class_room_id"]) ;
        }
        $classrooms=ClassRoom::whereIn('id',$list)->get();  
        if(!$classroom)
        {
            return $this->responseData( [],'not found');
        }
         return $this->responseData( $classrooms,'succeed');
    }

///////////// get my subject 

    public function getMysubject(Request $request)
    {

        $teacher=Teacher::where('employee_id',$request->user('employee')->id)->first();
      
  
     
         return $this->responseData( $teacher['subject'],'succeed');
    }
///////// get student by name

    public function getStudentByname(Request $request)
    {
        $validate=Validator::make($request->all(),
        [
            'full_name'=>'required|exists:students,full_name',
        ]);

        if($validate->fails()){
            return $this->responseError($validate->errors());
        }

        $student=Student::where('full_name','like','%'.$request->full_name.'%')->get();
        
        return $this->responseData( $student,'succeed');
    }

    ////////////////// profile

    public function profile(Request $request)
    {
            $student=Employee::where('id',$request->user('employee')->id)->first();

            return $this->responseData( $student,'succeed');
    }

////////////////// set image profile

    public function setImageProfile(Request $request)
    {
            
            $validate=Validator::make($request->all(),
            [
                'image'=>'mimes:jpg,jpeg,png,gif|required|max:10000',
            ]);
        
            if($validate->fails()){
                return $this->responseError($validate->errors());
            }

            $image=time().'.'.$request->image->extension();
            
            $request->image->move(public_path('images'),$image); 
        
            $employee=Employee::where('id',$request->user('employee')->id)->first();
            if($employee->image)
            {
                FacadesFile::delete(public_path("images/$employee->image"));
            }
            $employee->image=$image;
            $employee->save();
            
            return  response()->download(public_path("images/$employee->image"), $employee->image);
    }

////////////////// get image profile

    public function getImageProfile(Request $request)
    {   
        $employee=Employee::where('id',$request->user('employee')->id)->first();
        if(!$employee->image)
        {
            return $this->responseData([],'not found');
        }
        return  response()->download(public_path("images/$employee->image"), $employee->image);
    }


 ////////////////// get timeTable

    public function getTimeTable(Request $request)
    {   
        $employee=Employee::where('id',$request->user('employee')->id)->first();
        $teacher=Teacher::where('employee_id', $employee->id)->first();
        if(!$teacher->time_table)
        {
            return $this->responseData([],'not found');
        }
        return  response()->download(public_path("images/$teacher->time_table"), $teacher->time_table);
    }

////////////////// add file to class

    public function addFileToClass(Request $request)
    {
        $validate=Validator::make($request->all(),
        [
            'file_name'=>'required',
            'file'=>'required|mimes:jpg,jpeg,png,gif,pdf,docx,pptx,zip,rar',
            'class_room_id'=>'required|exists:class_rooms,id'
        ]);

        if($validate->fails()){
            return $this->responseError($validate->errors());
        }

        $file=time().'.'.$request->file->extension();
        $request->file->move(storage_path('app/Files'),$file); 
        $studefile=StudyFile::create([
            'file_name'=>$request->get('file_name'),
            'file'=>$file,
            'employee_id'=>$request->user('employee')->id,
        ]);
        
        $classstudy=Class_StudyFile::create([
            'study_file_id'=>$studefile->id,
            'class_room_id'=>$request->class_room_id,
        ]);
        

        return  $this->responseData($studefile,'success');
    }

////////////////// get absence or late student 

    public function getAbsenceOrLate(Request $request)
    {
            $empl=Absence_Let_emp::where('employee_id',$request->user('employee')->id)->get();
             if(!$empl)
             {
                return $this->responseData([],'not results');
             }
            return $this->responseData( $empl,'succeed');
    }
}