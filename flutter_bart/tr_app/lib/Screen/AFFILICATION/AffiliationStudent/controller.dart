import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Screen/AFFILICATION/AffilationEmploy/model.dart';
import 'package:tr_app/Screen/AFFILICATION/AffiliationStudent/model.dart';
import 'package:tr_app/api/request/response.dart';

class AffilationStudentController extends GetxController {
  var chick = false.obs;
  final GlobalKey<FormState> affikey = GlobalKey<FormState>();
  TextEditingController namecolntroller = TextEditingController();
  TextEditingController phonecolntroller = TextEditingController();
  TextEditingController lastlevelcontroller = TextEditingController();
  TextEditingController lastleveldegrecontroller = TextEditingController();
  TextEditingController targetlevelctcontroller = TextEditingController();

  send() async {
    chick.value = true;
    AffiliationStudentModel model = AffiliationStudentModel(
        name: namecolntroller.text,
        phone: phonecolntroller.text,
        lastLevel: lastlevelcontroller.text,
        lastLevelDegree: lastleveldegrecontroller.text,
        targetLevel: targetlevelctcontroller.text);
    Req request = Req();

    var response = await request.postlogindata(
        affiliationStudentModelToJson(model), "affiliation_request_student");
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

  String? validatelastlevel(String value) {
    if (value.isEmpty) {
      return "the last level is requierd";
    }
    return null;
  }

  String? validatelastleveldegree(String value) {
    if (value.isEmpty) {
      return "the last level degre is requierd";
    }
    return null;
  }

  String? validatetargetlevel(String value) {
    if (value.isEmpty) {
      return "the target level is requierd";
    }
    return null;
  }
}
