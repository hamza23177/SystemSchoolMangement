import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/state_manager.dart';
import 'package:tr_app/Screen/AFFILICATION/AffilationEmploy/model.dart';
import 'package:tr_app/api/request/response.dart';

class AffilationEmployeeController extends GetxController {
  var chick = false.obs;
  final GlobalKey<FormState> affikey = GlobalKey<FormState>();
  TextEditingController namecolntroller = TextEditingController();
  TextEditingController phonecolntroller = TextEditingController();
  TextEditingController namedegrecontroller = TextEditingController();
  TextEditingController targetgobcontroller = TextEditingController();
  TextEditingController targetsubjectcontroller = TextEditingController();

  send() async {
    chick.value = true;
    AffiliationEmployeeModel model = AffiliationEmployeeModel(
        name: namecolntroller.text,
        phone: phonecolntroller.text,
        nameDegree: namedegrecontroller.text,
        targetJob: targetgobcontroller.text,
        subjectTarget: targetsubjectcontroller.text);
    Req request = Req();

    var response = await request.postlogindata(
        affiliationEmployeeModelToJson(model), "affiliation_request_employee");
    print(response.body.toString());
    if (response.statusCode == 200) {
      Get.snackbar("invalid Login", "تم تسجيل الطلب بنجاح",
          duration: const Duration(seconds: 10),
          barBlur: 30,
          colorText: Colors.deepPurple,
          titleText: const Text(
            "طلب انتساب",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ));
      Get.offAllNamed('/');
      chick.value = false;
    }
    chick.value = false;
  }

  bool chickAffiliation() {
    final isvalid = affikey.currentState!.validate();
    if (!isvalid) {
      return false;
    }
    return true;
  }

  String? validatename(String value) {
    if (value.isEmpty) {
      return "the name is requierd";
    }
    return null;
  }

  String? validatephone(String value) {
    if (value.isEmpty) {
      return "the phone is requierd";
    }
    return null;
  }

  String? validatenamedegre(String value) {
    if (value.isEmpty) {
      return "the name degre is requierd";
    }
    return null;
  }

  String? validatetargetjob(String value) {
    if (value.isEmpty) {
      return "the target job is requierd";
    }
    return null;
  }

  String? validatetargetsubject(String value) {
    if (value.isEmpty) {
      return "the target subject is requierd";
    }
    return null;
  }
}
