import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:tr_app/Screen/Welcome/welcome_screen.dart';
import 'package:tr_app/Teacher/valuation/model.dart';
import 'package:tr_app/api/request/response.dart';

class StudentsnController extends GetxController {
  var isloding = false.obs;
  var studentlist = <ValuationModel>[].obs;
  RxInt index = 0.obs;
  TextEditingController textcontroller = TextEditingController();

  @override
  void onInit() {
    getstudents();
    super.onInit();
  }

  getstudents() async {
    Req response = Req();
    if (index.value != 0) {
      var data = {"full_name": textcontroller.text};
      var datajson = jsonEncode(data);
      try {
        isloding(true);
        var data =
            await response.postdata(datajson, "teacher/get_Student_By_name");
        var body = jsonDecode(data.body);
        print(body.toString());
        var se = body["data"];
        var bd = jsonEncode(se);
        if (data.statusCode == 200) {
          studentlist.value = modelStudentsFromJson(bd);
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
