import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Student/Files/file_tile.dart';
import 'package:tr_app/Student/Files/filecontroller.dart';
import 'package:tr_app/api/request/response.dart';
import 'package:tr_app/constant.dart';

class FilesTudent extends StatefulWidget {
  const FilesTudent({Key? key}) : super(key: key);

  @override
  _FilesTudentState createState() => _FilesTudentState();
}

class _FilesTudentState extends State<FilesTudent> {
  var controller = Get.put(FileController());
  Req head = Req();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "My Files",
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
      body: SingleChildScrollView(
        child: Column(children: [
          Image.asset(
            "assets/images/student.png",
            width: size.width * 0.8,
          ),

          Divider(
            color: Colors.deepPurple[100],
            thickness: 2,
          ),
          // SizedBox(
          //   height: size.height * 0.015,
          // ),
          Obx(() {
            if (controller.chick.value) {
              return const Center(
                  child: CircularProgressIndicator(
                color: primaryColorS,
              ));
            }
            return Container(
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, i) {
                    return File_tile(controller.filelist[i]);
                  },
                  separatorBuilder: (context, i) {
                    return Divider(
                      color: Colors.deepPurple[100],
                    );
                  },
                  itemCount: controller.filelist.length),
            );
          })
        ]),
      ),
    );
  }
}
