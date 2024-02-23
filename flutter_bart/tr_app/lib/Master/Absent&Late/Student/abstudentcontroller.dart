import 'dart:convert';
import 'package:get/state_manager.dart';
import 'package:tr_app/api/request/response.dart';

class AbsentStudentController extends GetxController {
  var chick = false.obs;
  var val = "غياب".obs;
  var iteam = ["تأخر", "غياب"];

  send(id) async {
    print("send..................");
    Req request = Req();
    chick.value = true;
    var data = {"type": val.value, "student_id": id};
    var datajson = jsonEncode(data);
    var response =
        await request.postdata(datajson, "master/set_Absence_Or_Late_St");
    print(response.body.toString());
    if (response.statusCode == 200) {
      chick.value = false;
    }
  }
}
