import 'dart:convert';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:tr_app/Screen/Welcome/welcome_screen.dart';
import 'package:tr_app/Teacher/Absent&Late/modelAbsent.dart';
import 'package:tr_app/api/request/response.dart';

class AbsentController extends GetxController {
  var isloding = false.obs;
  var absentlist = <ModelAbsent>[].obs;
  @override
  void onInit() {
    getAbsents();
    super.onInit();
  }

  getAbsents() async {
    Req response = Req();
    try {
      isloding(true);
      var data = await response.getdata( "teacher/get_Absence_Or_Late");
      var body = jsonDecode(data.body);
      var se = body["data"];
      var bd = jsonEncode(se);
      if (data.statusCode == 200) {
        absentlist.value = modelAbsentFromJson(bd) ;
      }
      if (data.statusCode == 401) {
        Get.offAll(() => WelcomeScreen());
      }
    } finally {
      isloding(false);
    }  
  }
}
 