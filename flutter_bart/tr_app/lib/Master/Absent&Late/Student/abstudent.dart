// ignore_for_file: prefer_const_constructors, prefer_adjacent_string_concatenation, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Master/Absent&Late/Student/abstudentcontroller.dart';
import 'package:tr_app/Master/HomeMaster.dart';
import 'package:tr_app/Master/Notes/StudentNote/studentsn.dart';
import '../../../constant.dart';

class AbsentStudent extends StatelessWidget {
  AbsentStudent({Key? key}) : super(key: key);
  var controller = Get.put(AbsentStudentController());
  String fullname = Get.arguments[1];
  int id = Get.arguments[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Student Absent or Late",
          style: TextStyle(
            color: primarylightColorS,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.cyan[900],
        automaticallyImplyLeading: false, // حذف سهم الرجوع
        leading: IconButton(
          onPressed: () {
            Get.offAll(() => HomeMaster());
          },
          icon: const Icon(Icons.home),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "assets/images/exam.png",
                  height: 100,
                ),
                Text(
                  fullname,
                  style: const TextStyle(
                      fontSize: 30,
                      color: Color(0xFF00838F),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              color: Colors.cyan[900],
            ),
            SizedBox(
              height: 10,
            ),
            Obx(() {
              return Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.cyan[50],
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: DropdownButton(
                      value: controller.val.value,
                      items: controller.iteam.map((String type) {
                        return DropdownMenuItem(
                            value: type,
                            child: Text(
                              type,
                              style: TextStyle(fontSize: 20),
                            ));
                      }).toList(),
                      onChanged: (String? value) {
                        controller.val.value = value!;
                      }));
            }),
            SizedBox(
              height: 50,
            ),
            Obx(() {
              if (controller.chick.value) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Color(0xFF00ACC1),
                ));
              }
              return MaterialButton(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                color: Colors.cyan[900],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 10,
                onPressed: () async {
                  await controller.send(id);
                  if (!controller.chick.value) {
                    Get.snackbar("", "تم اضافة الملاحظة بنجاح",
                        duration: Duration(seconds: 10),
                        snackStyle: SnackStyle.FLOATING,
                        barBlur: 30,
                        dismissDirection: DismissDirection.horizontal,
                        messageText: Text(
                          "تم تسجيل ال${controller.val.value} بنجاح ",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Colors.cyan[800],
                            fontSize: 20,
                          ),
                        ),
                        padding: EdgeInsets.only(left: 30, right: 10),
                        icon: Icon(
                          Icons.done_all,
                          size: 60,
                          color: Colors.cyan[100],
                        ),
                        titleText: Text(
                          "الطالب" + " : " + fullname,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Colors.cyan[100],
                            fontSize: 25,
                          ),
                        ));
                  }
                  Get.off(() => StudentnsClass("absent"));
                },
                child:
                    Text("Submet", style: TextStyle(color: primarylightColorS)),
              );
            }),
          ],
        ),
      ),
    );
  }
}
