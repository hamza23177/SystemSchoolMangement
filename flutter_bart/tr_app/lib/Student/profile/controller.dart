import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Student/profile/model.dart';
import 'package:tr_app/api/request/response.dart';

class ProfileSController extends GetxController {
  FilePickerResult? result;
  PlatformFile? file;
  var info = {};
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController birthday = TextEditingController();
  TextEditingController parentphone = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController region = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController level = TextEditingController();
  TextEditingController roomname = TextEditingController();
  TextEditingController buldnumber = TextEditingController();
  late ModelStudentProfile modele;
  var chickimage = false.obs;

  @override
  void onInit() {
    send();
    super.onInit();
  }

  sendimage() async {
    Req request = Req();

    await request.uploadimageprofile(
        "student/set_Image_Profile", file!.path.toString());
    print("uploaded");
  }

  send() async {
    Req request = Req();
    var response = await request.getdata('student/profile');
    if (response.statusCode == 200) {
      var respobody = jsonDecode(response.body);
      var data = respobody["data"];
      var addres = data['address'];
      var classinfo = data['class_room'];
      info.addAll(classinfo);
      info.addAll(addres);
      info.addAll(data);
      var ge = jsonEncode(info);
      modele = modelStudentProfileFromJson(ge);
      name.text = modele.fullName;
      birthday.text = modele.birthday;
      phone.text = modele.phone;
      buldnumber.text = modele.bulidNum;
      city.text = modele.city;
      parentphone.text = modele.parentPhone;
      street.text = modele.street;
      region.text = modele.region;
      roomname.text = modele.roomName;
      level.text = modele.level;
      if (modele.image != null) {
        chickimage.value = true;
      }
    }
  }
}
