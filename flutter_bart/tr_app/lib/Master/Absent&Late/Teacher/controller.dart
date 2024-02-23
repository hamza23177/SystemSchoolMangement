import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:tr_app/Master/Absent&Late/Teacher/component/modelteacher.dart';
import 'package:tr_app/Screen/Welcome/welcome_screen.dart';
import 'package:tr_app/api/request/response.dart';

class TeachersController extends GetxController {
  var isloding = false.obs;
  var teacherlist = <ModelTeacher>[].obs;
  RxInt index = 0.obs;
  TextEditingController textcontroller = TextEditingController();

  @override
  void onInit() {
    getteachers();
    super.onInit();
  }

  getteachers() async {
    Req response = Req();
    if (index.value != 0) {
      var data = {"full_name": textcontroller.text};
      var datajson = jsonEncode(data);
      try {
        isloding(true);
        var data =
            await response.postdata(datajson, "master/get_Teacher_Byname");
        var body = jsonDecode(data.body);
        var se = body["data"];
        var bd = jsonEncode(se);
        if (data.statusCode == 200) {
          teacherlist.value = modelTeacherFromJson(bd);
        }
        if (data.statusCode == 401) {
          Get.offAll(() => WelcomeScreen());
        }
      } finally {
        isloding(false);
      }
    }
  }
}
