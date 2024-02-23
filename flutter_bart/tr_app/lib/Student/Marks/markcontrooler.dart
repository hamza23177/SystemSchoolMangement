import 'dart:convert';
import 'package:get/state_manager.dart';
import 'package:tr_app/Student/Marks/modelmark.dart';
import 'package:tr_app/api/request/response.dart';

class MarkController extends GetxController {
  var marklist = <ModelMark>[].obs;
  var chick = false.obs;

  send() async {
    Req request = Req();
    chick.value = true;
    var response = await request.getdata("student/get_Mark");

    var body = jsonDecode(response.body);
    var data = body['data'];
    print(data);
    var marks = jsonEncode(data);
    if (response.statusCode == 200) {
      chick.value = false;
      marklist.value = modelMarkFromJson(marks);
    }
  }

  @override
  void onInit() {
    send();
    super.onInit();
  }
}
