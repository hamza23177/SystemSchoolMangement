import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:tr_app/api/request/response.dart';

class NoteController extends GetxController {
  TextEditingController textnotcontroller = TextEditingController();
  var chick = false.obs;
  final GlobalKey<FormState> notekey = GlobalKey<FormState>();

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

  send(id) async {
    print("send.................");
    Req request = Req();
    chick.value = true;
    var data = {"note": textnotcontroller.text, "student_id": id};
    var datajson = jsonEncode(data);
    var response = await request.postdata(datajson, "teacher/set_Note_Student");
    print(response.body.toString());
    if (response.statusCode == 200) {
      chick.value = false;
      print(response.body.toString());
    }
  }
}
