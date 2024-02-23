import 'dart:convert';
import 'package:get/state_manager.dart';
import 'package:tr_app/Student/Files/model.dart';
import 'package:tr_app/api/request/response.dart';

class FileController extends GetxController {
  var filelist = <ModelFile>[].obs;
  var chick = false.obs;

  send() async {
    Req request = Req();
    chick.value = true;
    var response = await request.getdata("student/get_My_File");

    var body = jsonDecode(response.body);
    var data = body['data'];
    print(data);
    var marks = jsonEncode(data);
    if (response.statusCode == 200) {
      chick.value = false;
      filelist.value = modelFileFromJson(marks);
    }
  }

  @override
  void onInit() {
    send();
    super.onInit();
  }
}
