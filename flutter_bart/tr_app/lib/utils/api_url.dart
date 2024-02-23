class EndPoint {
  // Emulation => _url = 'http://10.0.2.2:8000/api/'

  // physic device => _url = 'http://192.168.43.1:8000/api/'
  
  static const baseUrl = 'http://192.168.43.192:8000/api/';

  static _Master apiMaster = const _Master();
  static _Teacher apiTeacher = const _Teacher();
  static _Student apiStudent = const _Student();

  static const loginEmployee = 'employee/login';
  static const logoutEmployee = 'employee/logout';

  static const loginStudent = 'student/login';
  static const logoutStudent = 'student/logout';

  static const affiliationEmployee = 'affiliation_request_employee';
  static const affiliationStudent = 'affiliation_request_student';  
}


class _Master{
  const _Master();
  static const subBaseUrl ='master/';

  static const getClassByname = 'get_Class_Byname';
  static const getClassById = 'get_Class_By_Id';
  static const getClassesBylevel = 'get_Classes_By_level';
  static const getMyClasses = 'get_My_Classes';
  static const setMarkForClass = 'set_Mark_For_Class';
  static const getStudentByname = 'get_Student_By_name';
  static const setNoteStudent = 'set_Note_Student';
  static const setNoteClass = 'set_Note_Class';
  static const getNoteclass = 'get_Note_class';
  static const addImageProgramClass = 'add_Image_Program_Class';
  static const addFileToClass = 'add_File_To_Class';
  static const setAbsenceOrLateSt = 'set_Absence_Or_Late_St';
  static const setAbsenceOrLateEm = 'set_Absence_Or_Late_Em';
  static const profile = 'profile';
  static const setImageProfile = 'set_Image_Profile';
  static const getImageProfile = 'get_Image_Profile';

}


class _Teacher{
  const _Teacher();
  static const subBaseUrl ='teacher/';

  static const getClassByname = 'get_Class_Byname';
  static const getClassesBylevel = 'get_Classes_By_level';
  static const getMyClasses = 'get_My_Classes';
  static const setValuation = 'set_Valuation';
  static const getStudentByname = 'get_Student_By_name';
  static const setNoteStudent = 'set_Note_Student';
  static const setNoteClass = 'set_Note_Class';
  static const setImageProfile = 'set_Image_Profile';
  static const getAbsenceOrLate = 'get_Absence_Or_Late';
  static const profile = 'profile';
  static const addFileToClass = 'add_File_To_Class';
  static const getImageProfile = 'get_Image_Profile';
  static const getTimeTable = 'get_Time_Table';

}


class _Student{
  const _Student();
  static const subBaseUrl ='student/';

  static const agetMarks = 'get_Mark';
  static const getNoteStudent = 'get_Note_Student';
  static const getNoteClass = 'get_Note_Class';
  static const getValuation = 'get_Valuation';
  static const getAbsenceOrLate = 'get_Absence_Or_Late';
  static const profile = 'profile';
  static const setImageProfile = 'set_Image_Profile';
  static const getImageProfile = 'get_Image_Profile';
  static const getTimeTable = 'get_Time_Table';

}