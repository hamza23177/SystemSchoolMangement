import 'dart:convert';

import 'package:get/get.dart';
import 'package:tr_app/Master/typeExam/component/model_exam.dart';
import 'package:tr_app/Screen/Welcome/welcome_screen.dart';
import 'package:tr_app/api/request/response.dart';

class TypeController extends GetxController {
  var isloding = true.obs;
  var exams = <Exam>[].obs;
  var classid = Get.arguments[0];
  var subject = Get.arguments[1];
  
  void addExam(String newExam) {
    exams.add(Exam(exam: newExam));
  }

   @override
  void onInit() {
    getexam();
    super.onInit();
  }

  getexam() async {
    Req response = Req();

    try {
      isloding(true);
      var data = await response.getdata("master/get_Type_Exam");
      var body = jsonDecode(data.body);
      var se = body["data"];
      var bd = jsonEncode(se);
      if (data.statusCode == 200) {
        exams.value = examFromJson(bd);
      }
      if (data.statusCode == 401) {
        Get.offAll(() => WelcomeScreen());
      }
    } finally {
      isloding(false);
    }
  }


}
