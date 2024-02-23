// ignore_for_file: unused_local_variable, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Master/HomeMaster.dart';
import 'package:tr_app/Screen/login/Models/modellogin.dart';
import 'package:tr_app/Teacher/HomeTeacher.dart';
import 'package:tr_app/api/request/response.dart';
import '../../../main.dart';

class EmployeeLoginController extends GetxController {
  TextEditingController fullnamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final GlobalKey<FormState> loginkey = GlobalKey<FormState>();

  String? validateFullname(String value) {
    if (value.isEmpty) {
      return "the full name is requierd";
    }
    return null;
  }

  String? validatepassword(String value) {
    if (value.isEmpty) {
      return "the password is requierd";
    }
    if (value.length < 8) {
      return "password must be of 8 char";
    }
    return null;
  }

  bool chicklog() {
    final isvalid = loginkey.currentState!.validate();
    if (!isvalid) {
      return false;
    }
    return true;
  }

  void logout() async {
    Req request = Req();
    var response = await request.getdata("employee/logout");
    prefs!.clear();
    Get.offAllNamed('/');
  }

  void login() async {
    ModelLogin loginmodel = ModelLogin(
        fullName: fullnamecontroller.text, password: passwordcontroller.text);
    Req request = Req();
    var response = await request.postlogindata(
        modelLoginToJson(loginmodel), "employee/login");
    if (response.statusCode == 200) {
      prefs!.clear();
      var respobody = jsonDecode(response.body);
      var data = respobody["data"];
      bool isteacher = data["job_type"].toString() == "teacher" ? true : false;
      prefs!.setInt('type', isteacher ? 2 : 3);
      prefs!.setString('token', respobody["message"].toString());
      isteacher
          ? Get.offAll(() => const HomeTeacher())
          : Get.offAll(() => const HomeMaster());
    } else {
      var respobody = jsonDecode(response.body);
      print(respobody["message"].toString());
      Get.snackbar("invalid Login", "full name or password invalid",
          duration: const Duration(seconds: 10),
          barBlur: 30,
          colorText: Colors.red,
          titleText: const Text(
            "invalid Login",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ));
    }
  }
}
