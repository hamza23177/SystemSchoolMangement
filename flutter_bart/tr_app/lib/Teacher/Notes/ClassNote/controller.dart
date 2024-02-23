import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:tr_app/api/request/response.dart';

class ClassNoteController extends GetxController {
  String level = Get.arguments[1];
  String name = Get.arguments[2];
  String id = Get.arguments[0];
  final GlobalKey<FormState> notekey = GlobalKey<FormState>();
  TextEditingController textcontroller = TextEditingController();
  var chick = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  String? validateNote(String value) {
    if (value.isEmpty) {
      return "______________________________________________";
    }
    return null;
  }

  bool chickNote() {
    final isvalid = notekey.currentState!.validate();
    if (!isvalid) {
      return false;
    }
    return true;
  }

  send() async {
    Req request = Req();
    chick.value = true;
    var data = {"note": textcontroller.text, "class_room_id": id};
    var datajson = jsonEncode(data);
    var response = await request.postdata(datajson, "teacher/set_Note_Class");
    print(response.body.toString());
    if (response.statusCode == 200) {
      chick.value = false;
      print(response.body.toString());
    }
  }
}
