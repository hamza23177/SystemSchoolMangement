import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:tr_app/api/request/response.dart';

class Filecontorller extends GetxController {
  FilePickerResult? result;
  List<PlatformFile>? file;
  Req request = Req();
  String classid = Get.arguments[0];
  String level = Get.arguments[1];
  String classname = Get.arguments[2];
  var chick = false.obs;

  send() async {
    chick.value = true;
    for (var item in file!) {
      chick.value = !await request.uploadfile("master/add_File_To_Class",
          item.path.toString(), classid, item.name.toString());
      print("uploaded");
    }
  }
}
