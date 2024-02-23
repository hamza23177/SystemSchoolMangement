<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Http\Controllers\ResponseController;
use App\Models\Absence_Let_st;
use App\Models\Class_Note;
use App\Models\Class_StudyFile;
use App\Models\ClassRoom;
use App\Models\Mark;
use App\Models\Note;
use App\Models\Student;
use App\Models\Student_Note;
use App\Models\StudyFile;
use App\Models\Valuation;
use Illuminate\Support\Facades\File as FacadesFile;
class StudentController extends ResponseController
{

/////// constructor

    public function __construct()
    {
        $this->middleware('StudentAuth:students');
    }

//////////// get marks student

    public function getMark(Request $request)
    {
        $class=ClassRoom::find($request->user('student')->class_room_id)->first();
        $studentmark=Mark::where('student_id',$request->user('student')->id)->where('created_at','>',$class->created_at)->orderby('type')->orderby('created_at')->get();
        return $this->responseData($studentmark,'successful');
    }


////////////////// get note student 

    public function getNoteStudent(Request $request)
    {
        $class=ClassRoom::find($request->user('student')->class_room_id)->first();
        $student_note=Student_Note::where('student_id',$request->user('student')->id)->where('created_at','>',$class->created_at)->get();
        $list=[];
        foreach ($student_note as $key => $value) {
           
           array_push($list,$value["note_id"]) ;
        }
        $notes = Note::whereIn('id',$list)->orderby('created_at')->get();
            return $this->responseData( $notes,'succeed');
    }

////////////////// get note class 

    public function getNoteClass(Request $request)
    {
            $student=Student::where('id',$request->user('student')->id)->first();
            $classid=$student->class_room_id;
          
            $notesid=Class_Note::where('class_room_id',$classid)->get();
            $list=[];
            foreach ($notesid as $key => $value) {
               
               array_push($list,$value["note_id"]) ;
            }
            $notes = Note::whereIn('id',$list)->orderby('created_at')->get();
            return $this->responseData( $notes,'succeed');
    }

////////////////// get valuation student 

    public function getValuation(Request $request)
    {
        $class=ClassRoom::find($request->user('student')->class_room_id)->first();
        $valuations=Valuation::where('student_id',$request->user('student')->id)->where('created_at','>',$class->created_at)->orderby('created_at')->get();
            return $this->responseData( $valuations,'succeed');
    }

////////////////// get absence or late student 

    public function getAbsenceOrLate(Request $request)
    {
        $class=ClassRoom::find($request->user('student')->class_room_id)->first();
            $student=Absence_Let_st::where('student_id',$request->user('student')->id)->where('created_at','>',$class->created_at)->orderby('created_at')->get();
             if(!$student)
             {
                return $this->responseData([],'not results');
             }
            return $this->responseData( $student,'succeed');
    }
////////////////// profile

    public function profile(Request $request)
    {
            $student=Student::where('id',$request->user('student')->id)->first();

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
        
            $student=Student::where('id',$request->user('student')->id)->first();
            if($student->image)
            {
                FacadesFile::delete(public_path("images/$student->image"));
            }
            $student->image=$image;
            $student->save();
            
            return  response()->download(public_path("images/$student->image"), $student->image);
    }

////////////////// get image profile

    public function getImageProfile(Request $request)
    {   
        $student=Student::where('id',$request->user('student')->id)->first();
        if(!$student->image)
        {
            return $this->responseData([],'not found');
        }
        return  response()->download(public_path("images/$student->image"), $student->image);
    }

    
////////////////// get time table

    public function getTimeTable(Request $request)
    {   
        $class=ClassRoom::where('id',$request->user('student')->class_room_id)->first();
        if(!$class->image)
        {
           return $this->responseData([],'not exists yet');
        }
        return  response()->download(public_path("images/$class->image"), $class->image);
    }

////////// get files student

    public function getMyFiles(Request $request)
    {
        $classstudy=Class_StudyFile::where('class_room_id',$request->user('student')->class_room_id)->get();
        $list=[];
        foreach ($classstudy as $key => $value) {
           
           array_push($list,$value["study_file_id"]) ;
        }
         $studefile=StudyFile::whereIn('id',$list)->orderby('created_at')->get();
 
           return  $this->responseData($studefile,'success');
    }


////////////////// get time table

    public function getFile(Request $request)
    {   
        $studefile=StudyFile::where('file',$request->name)->first();
        return  response()->download(storage_path("app/Files/$studefile->file"), $studefile->file_name);
    }


}