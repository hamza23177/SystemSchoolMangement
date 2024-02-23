<?php

use GuzzleHttp\Middleware;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use PHPUnit\TextUI\XmlConfiguration\Group;
use App\Http\Controllers\AdminController;
use App\Http\Controllers\AdminFunctionController;
use App\Http\Controllers\AdminqueareController;
use App\Http\Controllers\AffiliationRequestController;
use App\Http\Controllers\AuthEmployeeController;
use App\Http\Controllers\AuthStudentController;
use App\Http\Controllers\MasterController;
use App\Http\Controllers\TeacherController;
use App\Http\Controllers\StudentController;
use App\Http\Controllers\TestEventController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/
Route::prefix('admin/')->group(function(){
    Route::controller(AdminController::class)->group(function(){
        Route::post('login','login');
        Route::post('logout','logout');
        Route::post('create_admin','createAdmin');
        Route::post('delete_admin','deletAdmin');
        Route::post('update_admin','updateAdmin');
    });
    Route::controller(AdminFunctionController::class)->group(function(){
        Route::post('create_Master','createMaster');
        Route::post('update_Master','updateMaster');
        Route::post('create_Teacher','createTeacher');
        Route::post('update_Teacher','updateTeacher');
        Route::post('delete_Teacher','deleteTeacher');
        Route::post('set_teacher_Schedule','teacherSchedule');
        Route::post('set_Teacher_ForClass','setTeacherForClass');
        Route::post('create_Student','createStudent');
        Route::post('update_Student','updateStudent');
        Route::post('delete_Student','deleteStudent');
        Route::post('change_Student_Password','changeStudentPassword'); 
        Route::post('change_Employee_Password','changeEmployeePassword'); 
        Route::post('create_Class','createClass');
        Route::post('endService','endService');
    });
    Route::controller(AdminqueareController::class)->group(function(){
        Route::post('get_Class_Byname','getClassByname');
        Route::post('get_Classes_By_level','getClassesBylevel');
        Route::post('all_Classes','allClasses');
        Route::post('get_Student_By_name','getStudentByname');
        Route::post('all_Student','allStudent');
        Route::post('get_Teacher_By_Name','getTeacherByName');
        Route::post('all_Teacher','allTeacher');
        Route::post('get_Master_By_name','getMasterByname');
        Route::post('all_Master','allMaster');
    });
});


Route::prefix('master/')->group(function(){
    Route::controller(MasterController::class)->group(function(){
        Route::post('get_Class_Byname','getClassByname');
        Route::post('get_Class_By_Id','getClassById');
        Route::post('get_Classes_By_level','getClassesBylevel');
        Route::get('get_My_Classes','getMyClasses');
        Route::post('set_Mark_For_Class','setMarkForClass');
        Route::post('get_Student_By_name','getStudentByname');
        Route::post('get_Teacher_Byname','getTeacherByname');
        Route::post('set_Note_Student','setNoteStudent');
        Route::post('set_Note_Class','setNoteClass');
        Route::post('get_Note_class','getNoteclass');
        Route::post('add_Image_Program_Class','addImageProgramClass');
        Route::post('add_File_To_Class','addFileToClass');
        Route::post('set_Absence_Or_Late_St','setAbsenceOrLateSt');
        Route::post('set_Absence_Or_Late_Em','setAbsenceOrLateEm');
        Route::get('profile','profile');
        Route::post('set_Image_Profile','setImageProfile');
        Route::get('get_Image_Profile','getImageProfile');
    });
    
    
});
Route::prefix('teacher/')->group(function(){
    Route::controller(TeacherController::class)->group(function(){
        Route::post('get_Class_Byname','getClassByname');
        Route::post('get_Classes_By_level','getClassesBylevel');
        Route::post('get_Class_By_Id','getClassById');
        Route::get('get_My_Classes','getMyClasses');
        Route::post('set_Valuation','setValuation');
        Route::post('get_Student_By_name','getStudentByname');
        Route::post('set_Note_Student','setNoteStudent');
        Route::post('set_Note_Class','setNoteClass');
        Route::post('set_Image_Profile','setImageProfile');
        Route::get('get_Absence_Or_Late','getAbsenceOrLate');
        Route::get('profile','profile');
        Route::post('add_File_To_Class','addFileToClass');
        Route::get('get_Image_Profile','getImageProfile');
        Route::get('get_Time_Table','getTimeTable');
        Route::get('get_My_subject','getMysubject');
    });
    
    
});

Route::prefix('student/')->group(function(){
    Route::controller(StudentController::class)->group(function(){
        Route::get('get_Mark','getMark');
        Route::get('get_Note_Student','getNoteStudent');
        Route::get('get_Note_Class','getNoteClass');
        Route::get('get_Valuation','getValuation');
        Route::get('get_Absence_Or_Late','getAbsenceOrLate');
        Route::get('profile','profile');
        Route::post('set_Image_Profile','setImageProfile');
        Route::get('get_Image_Profile','getImageProfile');
        Route::get('get_Time_Table','getTimeTable');
        Route::get('get_My_File','getMyFiles');
        Route::get('get_File','getFile');

    });
    
    
});
    
        Route::post('employee/login',[AuthEmployeeController::class,'login']);
        Route::get('employee/logout',[AuthEmployeeController::class,'logout']);

        Route::post('student/login',[AuthStudentController::class,'login']);
        Route::get('student/logout',[AuthStudentController::class,'logout']);
   
        Route::post('affiliation_request_employee',[AffiliationRequestController::class,'affiliation_request_employee']);
        Route::post('affiliation_request_student',[AffiliationRequestController::class,'affiliation_request_student']);
   


        
    
   
    
    

   
    
    
    
 