import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:tr_app/Student/Notes/model.dart';
import 'package:tr_app/api/request/response.dart';

class NotestController extends GetxController {
  var notelist = <ModelNote>[].obs;

  var chick = false.obs;

  send() async {
    Req request = Req();
    chick.value = true;
    var response = await request.getdata("student/get_Note_Student");

    var body = jsonDecode(response.body);
    var data = body['data'];
    print(data);
    var notes = jsonEncode(data);
    if (response.statusCode == 200) {
      chick.value = false;
      notelist.value = modelNoteFromJson(notes);
    }
  }

  @override
  void onInit() {
    send();
    super.onInit();
  }
}
