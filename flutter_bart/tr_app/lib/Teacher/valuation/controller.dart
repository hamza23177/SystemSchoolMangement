import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/state_manager.dart';
import 'package:tr_app/Screen/Welcome/welcome_screen.dart';
import 'package:tr_app/Teacher/valuation/model.dart';
import 'package:tr_app/api/request/response.dart';
import 'package:tr_app/constant.dart';

class ValuationController extends GetxController {
  var isloding = true.obs;
  var valuationlist = <ValuationModel>[].obs;
  var valuationcontroller = <TextEditingController>[];
  final GlobalKey<FormState> valuationkey = GlobalKey<FormState>();
  String classid = Get.arguments[0];
  String lecture = Get.arguments[1];
  var chick = false.obs;
  String? validateMark(String value) {
    if (value.isEmpty) {
      return "______________";
    }
    return null;
  }

  Future<String> getMySubject() async {
    Req response = Req();
    try {
      var data = await response.getdata("teacher/get_My_subject");
      var body = jsonDecode(data.body);
      String se = body["data"];
      if (data.statusCode == 200) {
        return se;
      }
      if (data.statusCode == 401) {
        Get.offAll(() => WelcomeScreen());
      }
    } catch (e) {
      print(e);
    }
    return "";
  }

  send() async {
    Req request = Req();
    Map<String, Object> data;
    for (var i = 0; i < valuationlist.length; i++) {
      if (valuationcontroller[i].text.isNotEmpty) {
        data = {
          "subject": await getMySubject(),
          "lecture": lecture,
          "student_id": valuationlist[i].id,
          "description": valuationcontroller[i].text
        };

        var datajson = jsonEncode(data);
        var response =
            await request.postdata(datajson, "teacher/set_Valuation");
        if (response.statusCode == 200) {
          chick.value = true;
        }
      }
    }
    if (chick.value) {
      Get.snackbar("Valuations", "Done add valuations seccessfully",
          backgroundColor: Colors.white,
          duration: const Duration(seconds: 5),
          snackStyle: SnackStyle.FLOATING,
          barBlur: 30,
          dismissDirection: DismissDirection.horizontal,
          messageText: const Text(
            "Done add valuations seccessfully",
            // textDirection: TextDirection.rtl,
            style: TextStyle(
              color: primaryColorS,
              fontSize: 20,
            ),
          ),
          padding: const EdgeInsets.only(left: 30, right: 10),
          icon: const Icon(
            Icons.check_circle,
            size: 25,
            color: Color.fromARGB(255, 21, 160, 26),
          ),
          titleText: Text(
            lecture,
            // textDirection: TextDirection.rtl,
            style: const TextStyle(
              color: primaryColorS,
              fontSize: 25,
            ),
          ));
    } else if (!chick.value) {
      Get.snackbar("Error", "Please enter at least one mark",
          duration: const Duration(seconds: 4),
          barBlur: 30,
          colorText: Colors.red,
          titleText: const Text(
            "invalid submit",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ));
    }
    chick.value = false;
  }

  // bool chickMark() {
  //   final isvalid = valuationkey.currentState!.validate();
  //   if (!isvalid) {
  //     return false;
  //   }
  //   return true;
  // }

  @override
  void onInit() {
    getstudents();
    super.onInit();
  }

  getstudents() async {
    Req response = Req();
    String ide = classid;
    Class_id id = Class_id(classroomid: ide);
    var dataa = classidToJson(id);
    try {
      isloding(true);
      var data = await response.postdata(dataa, "teacher/get_Class_By_Id");
      var body = jsonDecode(data.body);
      var se = body["data"];
      var re = se["student"]!;
      var bd = jsonEncode(re);
      if (data.statusCode == 200) {
        valuationlist.value = modelStudentsFromJson(bd);
        for (var i = 0; i < valuationlist.length; i++) {
          valuationcontroller.insert(i, TextEditingController());
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
