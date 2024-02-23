import 'package:file_picker/file_picker.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:tr_app/api/request/response.dart';

class TimeTableController extends GetxController {
  FilePickerResult? result;
  PlatformFile? file;
  Req request = Req();
  String classid = Get.arguments[0];
  String level = Get.arguments[1];
  String classname = Get.arguments[2];
  var chick = false.obs;

  send() async {
    chick.value = true;

    chick.value = !await request.uploadtimetable(
        "master/add_Image_Program_Class", file!.path.toString(), classid);
    print("uploaded");
  }
}
