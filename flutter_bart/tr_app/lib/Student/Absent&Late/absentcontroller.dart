import 'dart:convert';
import 'package:get/state_manager.dart';
import 'package:tr_app/Student/Absent&Late/model.dart';
import 'package:tr_app/api/request/response.dart';

class AbsentController extends GetxController {
  var absentlist = <ModelAbsent>[].obs;
  var chick = false.obs;

  send() async {
    Req request = Req();
    chick.value = true;
    var response = await request.getdata("student/get_Absence_Or_Late");

    var body = jsonDecode(response.body);
    var data = body['data'];
    print(data);
    var marks = jsonEncode(data);
    if (response.statusCode == 200) {
      chick.value = false;
      absentlist.value = modelAbsentFromJson(marks);
    }
  }

  @override
  void onInit() {
    send();
    super.onInit();
  }
}
