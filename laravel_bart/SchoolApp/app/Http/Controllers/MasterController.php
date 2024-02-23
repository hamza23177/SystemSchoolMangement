<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;
use App\Http\Controllers\ResponseController;
use App\Models\Absence_Let_emp;
use App\Models\Absence_Let_st;
use App\Models\Class_Note;
use App\Models\Class_StudyFile;
use App\Models\ClassRoom;
use App\Models\Employee;
use App\Models\Mark;
use App\Models\Master;
use App\Models\Note;
use App\Models\Student;
use App\Models\Student_Note;
use App\Models\StudyFile;
use Illuminate\Support\Facades\File as FacadesFile;
use Symfony\Component\HttpFoundation\File\File;

class MasterController extends ResponseController
{
    // constructor
    public function __construct()
    {
     $this->middleware('EmployeeAuth:employee');   
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

           $classroom=ClassRoom::where('level',$request->level)->where('room_name','=',$request->room_name)->with('student')->first();
           if(!$classroom)
           {
            return $this->responseData([],'classroom not exists');
           }
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

///////////// get my classes 

    public function getMyClasses(Request $request)
    {
         $master =Master::where('employee_id',$request->user('employee')->id)->first();
        $classroom=ClassRoom::where('master_id',$master->id)->get();
        
        return $this->responseData( $classroom,'succeed');
    }
////////// set mark for class

    public function setMarkForClass(Request $request)
    {
        $validate=Validator::make($request->all(),
        [
            'subject'=>'required',
            'type'=>'required',
            'mark'=>'required',
            'student_id'=>'required|exists:students,id',
         ]);

         if($validate->fails()){
            return $this->responseError($validate->errors());
         }
    
         $mark=Mark::create([
          'subject'=> $request->subject,
          'mark'=> $request->mark,
          'type'=> $request->type,
          'student_id'=> $request->student_id,
         ]);
        return $this->responseData($mark,'success');

    }



///////// get student by name

    public function getStudentByname(Request $request)
    {
        $validate=Validator::make($request->all(),
        [
            'full_name'=>'required',
         ]);
    
         if($validate->fails()){
            return $this->responseError($validate->errors());
           }
    
           $student=Student::where('full_name','like','%'.$request->full_name.'%')->get();
           
           return $this->responseData( $student,'succeed');
    }

///////// get teacher by name

    public function getTeacherByname(Request $request)
    {
        $validate=Validator::make($request->all(),
        [
            'full_name'=>'required',
         ]);
    
         if($validate->fails()){
            return $this->responseError($validate->errors());
           }
    
           $student=Employee::where('full_name','like','%'.$request->full_name.'%')->where('job_type','teacher')->get();
           
           return $this->responseData( $student,'succeed');
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




    ////////////////// get note class 

    public function getNoteclass(Request $request)
    {
        $validate=Validator::make($request->all(),
        [
            'class_room_id'=>'required|exists:class_rooms,id'
         ]);
    
         if($validate->fails()){
            return $this->responseError($validate->errors());
           }
          
       
           $class_note=Class_Note::where('class_room_id',$request->class_room_id)->get();
           
    
           return $this->responseData( $class_note,'succeed');
    }


    ////////////////// add image program class

    public function addImageProgramClass(Request $request)
    {
        $validate=Validator::make($request->all(),
        [
            'image'=>'mimes:jpg,jpeg,png|required',
            'class_room_id'=>'required|exists:class_rooms,id'
         ]);
    
         if($validate->fails()){
            return $this->responseError($validate->errors());
           }
           $image=time().'.'.$request->image->extension();
          
           $request->image->move(public_path('images'),$image); 
       
           $class=ClassRoom::find($request->class_room_id)->first();
           if($class->image)
           {
            FacadesFile::delete(public_path("images/$class->image"));
           }
           $class->image=$image;
           $class->save();
           
           return  response()->download(public_path("images/$class->image"), $class->image);
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

////////////////// set absence or late student 

    public function setAbsenceOrLateSt(Request $request)
    {
        $validate=Validator::make($request->all(),
        [
            'type'=>'required',
            'student_id'=>'required|exists:students,id'
         ]);
    
         if($validate->fails()){
            return $this->responseError($validate->errors());
           }
          
           $abs_alt=Absence_Let_st::create([
               'type'=> $request->type,
               'student_id'=> $request->student_id,
           ]);
           return $this->responseData( $abs_alt,'succeed');
          
    }


    ////////////////// set absence or late Teacher 

    public function setAbsenceOrLateEm(Request $request)
    {
        $validate=Validator::make($request->all(),
        [
            'type'=>'required',
            'employee_id'=>'required|exists:employees,id'
         ]);
    
         if($validate->fails()){
            return $this->responseError($validate->errors());
           }
          
           $abs_alt=Absence_Let_emp::create([
               'type'=> $request->type,
               'employee_id'=> $request->employee_id,
           ]);
           return $this->responseData( $abs_alt,'succeed');
          
    }
    
    ////////////////// profile

    public function profile(Request $request)
    {
            $employee=Employee::where('id',$request->user('employee')->id)->first();
            return $this->responseData( $employee,'succeed');
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
        $employee=employee::where('id',$request->user('employee')->id)->first();
        if(!$employee->image)
        {
            return $this->responseData([],'not found');
        }
        return  response()->download(public_path("images/$employee->image"), $employee->image);
    }

}