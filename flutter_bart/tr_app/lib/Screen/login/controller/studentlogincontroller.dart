// ignore_for_file: unused_local_variable, non_constant_identifier_names

import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Screen/login/Models/modellogin.dart';
import 'package:tr_app/Student/HomeStudent.dart';
import 'package:tr_app/api/request/response.dart';

import '../../../main.dart';

class StudentLoginController extends GetxController {
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
    var response = await request.getdata("student/logout");
    await prefs!.clear();
    Get.offAllNamed('/');
  }

  login() async {
    ModelLogin loginmodel = ModelLogin(
        fullName: fullnamecontroller.text, password: passwordcontroller.text);
    Req request = Req();
    var response = await request.postlogindata(
        modelLoginToJson(loginmodel), "student/login");
    if (response.statusCode == 200) {
      var respobody = jsonDecode(response.body);
      var data = respobody["data"];
      print(respobody.toString());
      await prefs!.setString('token', respobody["message"].toString());
      prefs!.setInt('type', 1);
      return true;
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
      return false;
    }
  }

  sendToken() async {
    Req request = Req();
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String? token = await firebaseMessaging.getToken();
    print({'token : $token'});
    var datas = {'fcm_token': token};
    var datajeson = jsonEncode(datas);
    var responsetok = await request.postdata(datajeson, "student/store_Token");
    print(responsetok.body.toString());
    if (responsetok.statusCode == 200) {
      print('send fcm token seccess !');
    }
    Get.offAll(() => const HomeStudent());
  }
}
