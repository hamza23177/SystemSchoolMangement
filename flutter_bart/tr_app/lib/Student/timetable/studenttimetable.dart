import 'package:flutter/material.dart';
import 'package:tr_app/api/request/openimage.dart';
import 'package:tr_app/api/request/response.dart';
import 'package:tr_app/constant.dart';


class GetTimeTable extends StatefulWidget {
  const GetTimeTable({Key? key}) : super(key: key);

  @override
  State<GetTimeTable> createState() => _GetTimeTableState();
}

class _GetTimeTableState extends State<GetTimeTable> {
  var image = ImageCache();

  Req head = Req();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Time Table",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: primaryColorS,
          automaticallyImplyLeading: false, // حذف سهم الرجوع
          leading: IconButton(
            onPressed: () {
              // Get.offAll(() => HomeStudent());
            },
            icon: const Icon(Icons.home),
          ),
        ),
        body: Column(
          children: [
            Container(
              // height: 300,
              child: Image(
                  alignment: Alignment.center,
                  isAntiAlias: true,
                  image: NetworkImage(
                      "http://192.168.43.220:8000/api/student/get_Time_Table",
                      headers: head.setHeaders(head.token))),
            ),
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                color: Colors.deepPurple[300],
                onPressed: () {
                  OpenController().startdownloading('get_Time_Table');
                },
                child: const Text(
                  "Open",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
