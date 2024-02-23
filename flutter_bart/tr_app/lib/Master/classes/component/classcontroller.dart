// ignore_for_file: deprecated_member_use, prefer_collection_literals

import 'dart:convert';
import 'package:get/get.dart';
import 'package:tr_app/Master/classes/component/modelclass.dart';
import 'package:tr_app/Screen/Welcome/welcome_screen.dart';
import 'package:tr_app/api/request/response.dart';

class ClassController extends GetxController {
  var isloding = true.obs;
  var classlist = <ModelClass>[].obs;

  @override
  void onInit() {
    getclasses();
    super.onInit();
  }

  getclasses() async {
    Req response = Req();

    try {
      isloding(true);
      var data = await response.getdata("master/get_My_Classes");
      var body = jsonDecode(data.body);
      var se = body["data"];
      var bd = jsonEncode(se);
      if (data.statusCode == 200) {
        classlist.value = modelClassFromJson(bd);
      }
      if (data.statusCode == 401) {
        Get.offAll(() => WelcomeScreen());
      }
    } finally {
      isloding(false);
    }
  }
}
