import 'package:dio/dio.dart';

import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tr_app/api/request/response.dart';

class OpenController extends GetxController {
  Dio dio = Dio();

  Future<String> getFilePath(String filname) async {
    final dir = await getApplicationDocumentsDirectory();
    print(dir.toString());
    return "${dir.path}/$filname";
  }

  void startdownloading(String filename) async {
    String url = "http://192.168.43.220:8000/api/student/$filename";
    String path = await getFilePath(filename);
    Req hed = Req();

    dio.options.headers = hed.setHeaders(hed.token);
    await dio.download(url, path, deleteOnError: true);

    OpenFile.open(path);
  }
}
