import 'dart:convert';
import 'package:get/state_manager.dart';
import 'package:tr_app/api/request/response.dart';

class AbsentTeacherController extends GetxController {
  var chick = false.obs;
  var val = "غياب".obs;
  var iteam = ["تأخر", "غياب"];

  send(id) async {
    Req request = Req();
    chick.value = true;
    var data = {"type": val.value, "employee_id": id};
    var datajson = jsonEncode(data);
    var response =
        await request.postdata(datajson, "master/set_Absence_Or_Late_Em");
    if (response.statusCode == 200) {
      chick.value = false;
    }
  }
}
