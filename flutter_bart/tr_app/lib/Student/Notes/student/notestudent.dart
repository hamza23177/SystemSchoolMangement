import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Student/Notes/student/note_tile.dart';
import 'package:tr_app/Student/Notes/student/notecontroller.dart';

import '../../../constant.dart';

class GetNoteStudent extends StatefulWidget {
  const GetNoteStudent({Key? key}) : super(key: key);

  @override
  _GetNoteStudentState createState() => _GetNoteStudentState();
}

class _GetNoteStudentState extends State<GetNoteStudent> {
  var controller = Get.put(NotestController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "My Notes",
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
            "assets/images/student21.png",
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
                    return NoteStTile(controller.notelist[i]);
                  },
                  separatorBuilder: (context, i) {
                    return Divider(
                      color: Colors.deepPurple[100],
                    );
                  },
                  itemCount: controller.notelist.length),
            );
          })
        ]),
      ),
    );
  }
}
