// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:tr_app/Master/marks/component/model.dart';
import 'package:tr_app/Screen/Welcome/welcome_screen.dart';
import 'package:tr_app/api/request/response.dart';

class MarkController extends GetxController {
  var isloding = true.obs;
  var studentlist = <MarkModel>[].obs;
  var markcontroller = <TextEditingController>[];
  final GlobalKey<FormState> markkey = GlobalKey<FormState>();
  String classid = Get.arguments[0];
  String subject = Get.arguments[1];
  String typeexam = Get.arguments[2];
  var chick = false.obs;
  String? validateMark(String value) {
    if (value.isEmpty) {
      return "______________";
    }
    return null;
  }

  send() async {
    chick.value = true;
    Req request = Req();
    var response;
    for (var i = 0; i < studentlist.length; i++) {
      var data = {
        "subject": subject,
        "type": typeexam,
        "student_id": studentlist[i].id,
        "mark": markcontroller[i].text
      };
      var datajson = jsonEncode(data);
      response = await request.postdata(datajson, "master/set_Mark_For_Class");
      print(jsonDecode(response.body).toString());
    }
    if (response.statusCode == 200) {
      chick.value = false;
    }
  }

  bool chickMark() {
    final isvalid = markkey.currentState!.validate();
    if (!isvalid) {
      return false;
    }
    return true;
  }

  @override
  void onInit() {
    getstudents();
    super.onInit();
  }

  getstudents() async {
    Req response = Req();
    String ide = Get.arguments[0];
    Class_id id = Class_id(classroomid: ide);
    var dataa = classidToJson(id);
    try {
      isloding(true);
      var data = await response.postdata(dataa, "master/get_Class_By_Id");
      var body = jsonDecode(data.body);
      var se = body["data"];
      var re = se["student"]!;
      var bd = jsonEncode(re);
      if (data.statusCode == 200) {
        studentlist.value = markmodelFromJson(bd);
        for (var i = 0; i < studentlist.length; i++) {
          markcontroller.insert(i, TextEditingController());
        }
      }
      if (data.statusCode == 401) {
        Get.offAll(() => WelcomeScreen());
      }
    } finally {
      isloding(false);
    }
  }
}
