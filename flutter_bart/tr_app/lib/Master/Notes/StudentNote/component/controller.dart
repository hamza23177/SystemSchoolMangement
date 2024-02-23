import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:tr_app/Master/marks/component/model.dart';
import 'package:tr_app/Screen/Welcome/welcome_screen.dart';
import 'package:tr_app/api/request/response.dart';

class StudentsnController extends GetxController {
  var isloding = false.obs;
  var studentlist = <MarkModel>[].obs;
  RxInt index = 0.obs;
  TextEditingController textcontroller = TextEditingController();

  @override
  void onInit() {
    getstudents();
    super.onInit();
  }

  getstudents() async {
    print("sensavdbfnghj,k.klsdhfghjklsdgfhjksdfght");
    Req response = Req();
    if (index.value != 0) {
      var data = {"full_name": textcontroller.text};
      var datajson = jsonEncode(data);
      try {
        isloding(true);
        var data =
            await response.postdata(datajson, "master/get_Student_By_name");
        var body = jsonDecode(data.body);
        var se = body["data"];
        var bd = jsonEncode(se);
        if (data.statusCode == 200) {
          studentlist.value = markmodelFromJson(bd);
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
