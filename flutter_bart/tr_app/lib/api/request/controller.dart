import 'package:dio/dio.dart';

import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tr_app/api/request/response.dart';

class DownloadController extends GetxController {
  var progress = 0.0.obs;
  var name = Get.arguments;
  Dio dio = Dio();
  @override
  void onInit() {
    name = Get.arguments;
    startdownloading(name);
    super.onInit();
  }

  Future<String> getFilePath(String filname) async {
    final dir = await getExternalStorageDirectory();

    dir!.create();

    print(dir.path.toString());
    return "${dir.path}/$filname";
  }

  void startdownloading(String filename) async {
    String url =
        "http://192.168.43.220:8000/api/student/get_File?name=$filename";
    String path = await getFilePath(filename);
    Req hed = Req();
    // var data = {'file': filename};
    // var datajes = jsonEncode(data);
    dio.options.headers = hed.setHeaders(hed.token);
    var re = await dio.download(url, path,
        onReceiveProgress: (recivedBytes, totalBytes) {
      progress.value = recivedBytes / totalBytes;

      print(progress.value);
    }, deleteOnError: true).then((value) {
      Get.back();
      print(getFilePath(filename));
    });
    print(getFilePath(filename));
    OpenFile.open(path);
  }
}
