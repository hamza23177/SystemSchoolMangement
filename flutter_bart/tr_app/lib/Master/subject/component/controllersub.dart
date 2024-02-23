import 'dart:convert';

import 'package:get/get.dart';
import 'package:tr_app/Master/subject/component/model_subject.dart';
import 'package:tr_app/Screen/Welcome/welcome_screen.dart';
import 'package:tr_app/api/request/response.dart';

class SubController extends GetxController {
  var isloding = true.obs;
  var subjects = <Subject>[].obs;
  var classid = Get.arguments;
  
  void addSubject(String newSubject) {
    subjects.add(Subject(subject: newSubject));
  }

   @override
  void onInit() {
    getsubject();
    super.onInit();
  }

  getsubject() async {
    Req response = Req();

    try {
      isloding(true);
      var data = await response.getdata("master/get_subjects");
      var body = jsonDecode(data.body);
      var se = body["data"];
      var bd = jsonEncode(se);
      if (data.statusCode == 200) {
        subjects.value = subjectFromJson(bd);
      }
      if (data.statusCode == 401) {
        Get.offAll(() => WelcomeScreen());
      }
    } finally {
      isloding(false);
    }
  }


}
