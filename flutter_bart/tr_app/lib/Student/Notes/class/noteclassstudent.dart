import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Student/Notes/class/note_tile.dart';
import 'package:tr_app/Student/Notes/class/noteclasscontroller.dart';

import '../../../constant.dart';

class GetNoteClass extends StatefulWidget {
  const GetNoteClass({Key? key}) : super(key: key);

  @override
  _GetNoteClassState createState() => _GetNoteClassState();
}

class _GetNoteClassState extends State<GetNoteClass> {
  var controller = Get.put(NoteclassController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "My Class Notes",
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
            "assets/images/student1.jpg",
            width: size.width * 0.8,
          ),

          Divider(
            color: Colors.deepPurple[100],
            thickness: 2,
          ),
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
                    return NoteclTile(controller.notelist[i]);
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
