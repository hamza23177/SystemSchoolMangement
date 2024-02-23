<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;
use App\Http\Controllers\ResponseController;
use App\Models\Address;
use App\Models\Class_Teacher;
use App\Models\ClassRoom;
use App\Models\Employee;
use App\Models\Master;
use App\Models\Student;
use App\Models\Teacher;
use Illuminate\Support\Facades\File as FacadesFile;
use Illuminate\Support\Facades\Hash;


class AdminFunctionController extends ResponseController
{
    
       public function __construct()
       {
       $this->middleware('AdminAuth:admin');
       }


    ///////// generate Password

    public function generatePassword()
    {
      $lowercase = range('a','z');
      $uppercase = range('A','Z');
      $digits = range(0,9);
      $special =['#','$'];
      $chars = array_merge($lowercase,$uppercase,$digits,$special);
      $length = env('PASSWORD_LENGTH',8);

      do
      {
        $password=array();

        for($i = 0; $i < $length;$i ++)
        {
            $int= rand(0,count($chars)-1);
            array_push($password,$chars[$int]);
        }
      }while(empty(array_intersect($special,$password)));

      $passwords=implode('',$password);
      return $passwords ;
    }



/////////// create master
    
    public function createMaster(Request $request)
    {
        $validate=Validator::make($request->all(),
        [
           'work_time'=>'required',
           'salary'=>'required|numeric',

           'f_name'=>'required',
           'm_name'=>'required',
           'l_name'=>'required',
           'birthday'=>'required',
           'phone'=>'required|numeric',
           'job_type'=>'required',
           'edu_degree'=>'required',
           'start_date'=>'required',
           'active'=>'required|boolean',
        
           'city'=>'required',
           'region'=>'required',
           'street'=>'required',
           'bulid_num'=>'required'
        ]);
       if($validate->fails()){
       return $this->responseError($validate->errors());
       }


       $fullName=$request->f_name." ".$request->m_name." ".$request->l_name;
      
       $fullNames=[
        'full_name'=> $fullName
        ];
       $validate_fullName=Validator::make($fullNames,
       [
          'full_name'=>'required|unique:employees,full_name',
       ]);
       if($validate_fullName->fails()){
        return $this->responseError($validate_fullName->errors());
         }

         
       $addres= Address::create([

       'city'=>$request->get('city'),
       'region'=>$request->get('region'),
       'street'=>$request->get('street'),
       'bulid_num'=>$request->get('bulid_num'),
       'street'=>$request->get('street'),
            ] );

        $password=$this->generatePassword();

        $employee= Employee::create([

            'f_name'=>$request->get('f_name'),
            'm_name'=>$request->get('m_name'),
            'l_name'=>$request->get('l_name'),
            'full_name'=>$fullName,
            'birthday'=>$request->get('birthday'),
            'phone'=>$request->get('phone'),
            'job_type'=>$request->get('job_type'),
            'edu_degree'=>$request->get('edu_degree'),
            'start_date'=>$request->get('start_date'),
            'active'=>$request->get('active'),
            'address_id'=>$addres->id,
            'password'=>Hash::make($password),
            
            ] );

        $master= Master::create([

         'work_time'=>$request->get('work_time'),
         'salary'=>$request->get('salary'),
         'employee_id'=>$employee->id,
         ] );       
        
      
       
        return $this->responseDatawithpassword($master,$password,$fullName,'successful');
    }
  
    //updet master
    public function updateMaster(Request $request)
    {
        $validate=Validator::make($request->all(),
        [
            'id'=>'required|exists:masters,id',
            'work_time'=>'required',
            'salary'=>'required|numeric',

            'f_name'=>'required',
            'm_name'=>'required',
            'l_name'=>'required',
            'birthday'=>'required',
            'phone'=>'required|numeric',
            'job_type'=>'required',
            'edu_degree'=>'required',
            'start_date'=>'required',

            'city'=>'required',
            'region'=>'required',
            'street'=>'required',
            'bulid_num'=>'required'
        ]);

        if($validate->fails()){
            return $this->responseError($validate->errors());
        }
        $fullName=$request->f_name." ".$request->m_name." ".$request->l_name;


        Master::where('id',$request->id)->first()->update([
            'work_time'=>$request->get('work_time'),
            'salary'=>$request->get('salary'),
        ] );

        $master= Master::where('id',$request->id)->first();

        Employee::where('id',$master->employee_id)->first()->update([
            'f_name'=>$request->get('f_name'),
            'm_name'=>$request->get('m_name'),
            'l_name'=>$request->get('l_name'),
            'full_name'=>$fullName,
            'birthday'=>$request->get('birthday'),
            'phone'=>$request->get('phone'),
            'email'=>$request->get('email'),
            'job_type'=>$request->get('job_type'),
            'edu_degree'=>$request->get('edu_degree'),
            'start_date'=>$request->get('start_date'),
        ] );

        $employee= Employee::where('id',$master->employee_id)->first();

        Address::where('id',$employee->address_id)->first()->update([
            'city'=>$request->get('city'),
            'region'=>$request->get('region'),
            'street'=>$request->get('street'),
            'bulid_num'=>$request->get('bulid_num'),
            'street'=>$request->get('street'),
        ] );
        $user=Master::where('id',$master->id)->with('employee')->get();
        return $this->responseData($user,'successful');
    }


//////////create teacher

    public function createTeacher(Request $request)
    {
        $validate=Validator::make($request->all(),
        [
           'subject'=>'required',
           'session_price'=>'required|numeric',
           'salary'=>'required',
          
           'f_name'=>'required',
           'm_name'=>'required',
           'l_name'=>'required',
           'birthday'=>'required',
           'phone'=>'required|numeric',
           'job_type'=>'required',
           'edu_degree'=>'required',
           'start_date'=>'required',
           'active'=>'required|boolean',

           'city'=>'required',
           'region'=>'required',
           'street'=>'required',
           'bulid_num'=>'required'
        ]);
    
       if($validate->fails()){
         return $this->responseError($validate->errors());
        }
       $fullName=$request->f_name." ".$request->m_name." ".$request->l_name;
        $fullNames=[
            'full_name'=> $fullName
        ];
       $validate_fullName=Validator::make($fullNames,
       [
          'full_name'=>'required|unique:employees,full_name',
       ]);
       
       if($validate_fullName->fails()){
           return $this->responseError($validate_fullName->errors());
        }
        
       $addres= Address::create([

        'city'=>$request->get('city'),
        'region'=>$request->get('region'),
        'street'=>$request->get('street'),
        'bulid_num'=>$request->get('bulid_num'),
        'street'=>$request->get('street'),

            ] );
       $password=$this->generatePassword();

       $employee= Employee::create([

            'f_name'=>$request->get('f_name'),
            'm_name'=>$request->get('m_name'),
            'l_name'=>$request->get('l_name'),
            'full_name'=>$fullName,
            'birthday'=>$request->get('birthday'),
            'phone'=>$request->get('phone'),
            'email'=>$request->get('email'),
            'job_type'=>$request->get('job_type'),
            'edu_degree'=>$request->get('edu_degree'),
            'start_date'=>$request->get('start_date'),
            'active'=>$request->get('active'),
            'address_id'=>$addres->id,
            'password'=>Hash::make($password),
            
            ] );

        $teacher= Teacher::create([

         'subject'=>$request->get('subject'),
         'session_price'=>$request->get('session_price'),
         'salary'=>$request->get('salary'),
         'employee_id'=>$employee->id,
         ] );       
        

        
       
        return $this->responseDatawithpassword($teacher,$password,$fullName,'successful');
    }

    //update teacher
    public function updateTeacher(Request $request)
    {
        $validate=Validator::make($request->all(),
        [
            'id'=>'required|exists:teachers,id',
            'subject'=>'required',
            'session_price'=>'required|numeric',
            'salary'=>'required',

            'f_name'=>'required',
            'm_name'=>'required',
            'l_name'=>'required',
            'birthday'=>'required',
            'phone'=>'required|numeric',
            'job_type'=>'required',
            'edu_degree'=>'required',
            'start_date'=>'required',

            'city'=>'required',
            'region'=>'required',
            'street'=>'required',
            'bulid_num'=>'required'
        ]);

        if($validate->fails()){
            return $this->responseError($validate->errors());
        }
        $fullName=$request->f_name." ".$request->m_name." ".$request->l_name;
        Teacher::where('id',$request->id)->first()->update([

            'subject'=>$request->get('subject'),
            'session_price'=>$request->get('session_price'),
            'salary'=>$request->get('salary'),
        ] );

        $teacher= Teacher::where('id',$request->id)->first();

        Employee::where('id',$teacher->employee_id)->first()->update([
            'f_name'=>$request->get('f_name'),
            'm_name'=>$request->get('m_name'),
            'l_name'=>$request->get('l_name'),
            'full_name'=>$fullName,
            'birthday'=>$request->get('birthday'),
            'phone'=>$request->get('phone'),
            'email'=>$request->get('email'),
            'job_type'=>$request->get('job_type'),
            'edu_degree'=>$request->get('edu_degree'),
            'start_date'=>$request->get('start_date'),
        ] );

        $employee= Employee::where('id',$teacher->employee_id)->first();

        Address::where('id',$employee->address_id)->first()->update([
            'city'=>$request->get('city'),
            'region'=>$request->get('region'),
            'street'=>$request->get('street'),
            'bulid_num'=>$request->get('bulid_num'),
            'street'=>$request->get('street'),
        ] );



        $user=Teacher::where('id',$teacher->id)->with('employee')->get();

        return $this->responseData($user,'successful');
    }
  


//////////////// create student

    public function createStudent(Request $request){
        $validate=Validator::make($request->all(),
        [
           'f_name'=>'required',
           'm_name'=>'required',
           'l_name'=>'required',
           'mother_name'=>'required',
           'birthday'=>'required',
           'phone'=>'required|numeric',
           'parent_phone'=>'required',
           'class_room_id'=>'required',
        
           'city'=>'required',
           'region'=>'required',
           'street'=>'required',
           'bulid_num'=>'required'
        ]);

        if($validate->fails()){
              return $this->responseError($validate->errors());
         }

        $fullName=$request->f_name." ".$request->m_name." ".$request->l_name;
       
           $fullNames=[
               'full_name'=> $fullName
                 ];
           $validate_fullName=Validator::make($fullNames,
           [
              'full_name'=>'required|unique:students,full_name',
           ]);
           
           if($validate_fullName->fails()){
               return $this->responseError($validate_fullName->errors());
            }
        $class=ClassRoom::find($request->class_room_id);
        if(!$class)
         {
          return $this->responseData([],'class id not exists');
         }
        $addres= Address::create([
         'city'=>$request->get('city'),
         'region'=>$request->get('region'),
         'street'=>$request->get('street'),
         'bulid_num'=>$request->get('bulid_num'),
         'street'=>$request->get('street'),
            ] );
         $password=$this->generatePassword();
        $student= Student::create([
            
         'f_name'=>$request->get('f_name'),
         'm_name'=>$request->get('m_name'),
         'l_name'=>$request->get('l_name'),
         'full_name'=>$fullName,
         'mother_name'=>$request->get('mother_name'),
         'birthday'=>$request->get('birthday'),
         'phone'=>$request->get('phone'),
         'email'=>$request->get('email'),
         'parent_phone'=>$request->get('parent_phone'),
         'class_room_id'=>$request->get('class_room_id'),
         'address_id'=>$addres->id,
         'password'=>Hash::make($password),
         ] );
                
                       
         return $this->responseDatawithpassword($student,$password,$fullName,'successful');

    }

    //update student
    public function updateStudent(Request $request){
        $validate=Validator::make($request->all(),
        [
            'id'=>'required|exists:students,id',
            'f_name'=>'required',
            'm_name'=>'required',
            'l_name'=>'required',
            'mother_name'=>'required',
            'birthday'=>'required',
            'phone'=>'required|numeric',
            'parent_phone'=>'required',
            'class_room_id'=>'required',

            'city'=>'required',
            'region'=>'required',
            'street'=>'required',
            'bulid_num'=>'required'
        ]);

        if($validate->fails()){
            return $this->responseError($validate->errors());
        }

       
        $fullName=$request->f_name." ".$request->m_name." ".$request->l_name;
        $class=ClassRoom::find($request->class_room_id);
        if(!$class)
        {
            return $this->responseData([],'class id not exists');
        }


        Student::where('id',$request->id)->first()->update([

            'f_name'=>$request->get('f_name'),
            'm_name'=>$request->get('m_name'),
            'l_name'=>$request->get('l_name'),
            'full_name'=>$fullName,
            'mother_name'=>$request->get('mother_name'),
            'birthday'=>$request->get('birthday'),
            'phone'=>$request->get('phone'),
            'email'=>$request->get('email'),
            'parent-phone'=>$request->get('parent-phone'),
            'class_room_id'=>$request->get('class_room_id'),
        ] );

        $student= Student::where('id',$request->id)->first();
        Address::where('id',$student->address_id)->first()->update([

            'city'=>$request->get('city'),
            'region'=>$request->get('region'),
            'street'=>$request->get('street'),
            'bulid_num'=>$request->get('bulid_num'),
            'street'=>$request->get('street'),

        ] );


        $user=student::where('id',$student->id)->get();

        return $this->responseData($user,'successful');

    }

///////////// create class

    public function createClass(Request $request)
    {
        $validate=Validator::make($request->all(),
        [
            'room_name'=>'required',
            'date'=>'required',
            'master_id'=>'required',
            'level'=>'required',
         ]);

         if($validate->fails())
         {
            return $this->responseError($validate->errors());
         }

        $master=Master::find($request->master_id);
           if(!$master)
           {
            return $this->responseData([],'master id not exists');
           }
          
        $class=ClassRoom::create([
            
         'room_name'=>$request->get('room_name'),
         'date'=>$request->get('date'),
         'phone'=>$request->get('phone'),
         'master_id'=>$request->get('master_id'),
         'level'=>$request->get('level'),
        ] );
         

            
        return $this->responseData($class,'successful');
    }

    //change password employee
    public function changeEmployeePassword(Request $request)
    {
        $validate=Validator::make($request->all(),
        [
            'id'=>'required|exists:employees,id',
        ]);

        if($validate->fails()){
            return $this->responseError($validate->errors());
        }

        $password=$this->generatePassword();
        Employee::where('id',$request->id)->first()->update([
            'password'=>Hash::make($password),
        ] );
        $employee=Employee::find($request->id);
        return $this->responseDatawithpassword($employee,$password,$employee->full_name,'successful');
    }

    //delete teacher
    public function deleteTeacher(Request $request)
    {
        $validate=Validator::make($request->all(),['id'=>'required|exists:teachers,id',]);

        if($validate->fails()){
            return $this->responseError($validate->errors());
        }
        $teacher=Teacher::where('id','=',$request->id)->first();
        $teacher->delete();
        return $this->responseData([],'deleted successfully');

    }

    //delete student
    public function deleteStudent(Request $request)
    {
        $validate=Validator::make($request->all(),['id'=>'required',]);

        if($validate->fails()){
            return $this->responseError($validate->errors());
        }
        $student=Student::where('id','=',$request->id)->first();
        if(! $student)
        {
            return $this->responseData([],'not found');
        }
        $student->delete();
        return $this->responseData([],'deleted successfully');

    }

    ////chang password student
    public function changeStudentPassword(Request $request)
    {
        $validate=Validator::make($request->all(),
        [
            'id'=>'required|exists:students,id',
        ]);

        if($validate->fails()){
            return $this->responseError($validate->errors());
        }

        $password=$this->generatePassword();
        Student::where('id',$request->id)->first()->update([
            'password'=>Hash::make($password),
        ] );
        $student=Student::find($request->id);
        return $this->responseDatawithpassword($student,$password,$student->full_name,'successful');
    }


////////// end service

    public function endService (Request $request)
    {

        $validate=Validator::make($request->all(),
        [
            'full_name'=>'required|exists:employees,full_name',
            'end_date'=>'required',

        ]);

        if($validate->fails())
        {
            return $this->responseError($validate->errors());
        }
        
        $employee=Employee::where('full_name',$request->full_name)->first();
        $employee->active=false;
        $employee->end_date=$request->end_date;
        $password=$this->generatePassword();
        $employee->password=Hash::make($password);
        $employee->save();
        return $this->responseDatawithpassword($employee,$password,$employee->full_name,'success');

    }

/////add scheduule for a teacher
    public function teacherSchedule(Request $request)
    {
        $validate=Validator::make($request->all(),
        [
            'id'=>'required|exists:teachers,id',
            'time_table'=>'mimes:jpg,jpeg,png,gif|required|max:10000',
        ]);

        if($validate->fails()){
            return $this->responseError($validate->errors());
        }

        $time_table=time().'.'.$request->time_table->extension();
        $request->time_table->move(public_path('images'),$time_table);
        $teacher=Teacher::where('id',$request->id)->first();

        if($teacher->time_table)
        {
            FacadesFile::delete(public_path("images/$teacher->time_table"));
        }
        
        $teacher->time_table=$time_table;
        $teacher->save();
        return $this->responseData($teacher,'successful');
    }
  ////////////////// set  teacher for class

    public function setTeacherForClass(Request $request)
    {
        $validate=Validator::make($request->all(),
        [
            'teacher_id'=>'required|exists:teachers,id',
            'class_room_id'=>'required|exists:class_rooms,id'
        ]);
    
        if($validate->fails()){
            return $this->responseError($validate->errors());
            }

        $classteacheer=Class_Teacher::create([
            'teacher_id'=>$request->teacher_id,
            'class_room_id'=>$request->class_room_id,
        ]);
            
        

            return  $this->responseData($classteacheer,'success');
    }


}