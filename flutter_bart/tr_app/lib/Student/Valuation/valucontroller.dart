import 'dart:convert';
import 'package:get/state_manager.dart';
import 'package:tr_app/Student/Valuation/model.dart';
import 'package:tr_app/api/request/response.dart';

class VluController extends GetxController {
  var valuationlist = <ModelValyation>[].obs;
  var chick = false.obs;

  send() async {
    Req request = Req();
    chick.value = true;
    var response = await request.getdata("student/get_Valuation");

    var body = jsonDecode(response.body);
    var data = body['data'];
    print(data);
    var marks = jsonEncode(data);
    if (response.statusCode == 200) {
      chick.value = false;
      valuationlist.value = modelValyationFromJson(marks);
    }
  }

  @override
  void onInit() {
    send();
    super.onInit();
  }
}
