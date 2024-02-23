import 'dart:convert';
import 'package:get/get.dart';
import 'package:tr_app/Screen/Welcome/welcome_screen.dart';
import 'package:tr_app/Teacher/typeLecture/component/lecture_modle.dart';
import 'package:tr_app/api/request/response.dart';



class TypeLectureController extends GetxController {
  var lectures = <Lecture>[].obs;
  var isloding = true.obs;
  var classid = Get.arguments;

  void addLecture(String newLecture) {
    lectures.add(Lecture(lecture: newLecture));
  }

  @override
  void onInit() {
    getlectures();
    super.onInit();
  }

  getlectures() async {
    Req response = Req();

    try {
      isloding(true);
      var data = await response.getdata("teacher/get_lectures");
      var body = jsonDecode(data.body);
      var se = body["data"];
      var bd = jsonEncode(se);
      if (data.statusCode == 200) {
        lectures.value = lectureFromJson(bd);
      }
      if (data.statusCode == 401) {
        Get.offAll(() => WelcomeScreen());
      }
    } finally {
      isloding(false);
    }
  }
}

