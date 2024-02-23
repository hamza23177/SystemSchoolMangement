// ignore_for_file: prefer_const_constructors, prefer_adjacent_string_concatenation, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Master/HomeMaster.dart';
import 'package:tr_app/Master/Notes/StudentNote/component/notecontroller.dart';
import 'package:tr_app/Master/Notes/StudentNote/studentsn.dart';
import '../../../constant.dart';

class NoteStudent extends StatelessWidget {
  NoteStudent({Key? key}) : super(key: key);
  var controller = Get.put(NoteController());
  String fullname = Get.arguments[1];
  int id = Get.arguments[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Student Note",
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
            Form(
              key: controller.notekey,
              autovalidateMode: AutovalidateMode.always,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.cyan[50],
                  borderRadius: BorderRadius.circular(29),
                ),
                child: TextFormField(
                  textDirection: TextDirection.rtl,
                  keyboardType: TextInputType.text,
                  controller: controller.textnotcontroller,
                  validator: (value) {
                    return controller.validateNote(value!);
                  },
                  // maxLength: 50,
                  maxLines: 3,
                  decoration: const InputDecoration(
                      hintText: "اكتب ملاحظتك هنا .........",
                      hintStyle: TextStyle(color: Colors.blueGrey),
                      hintTextDirection: TextDirection.rtl,
                      icon: Icon(
                        Icons.edit,
                        color: Color(0xFF00ACC1),
                        textDirection: TextDirection.rtl,
                        size: 40,
                      ),
                      border: InputBorder.none),
                ),
              ),
            ),
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
                  if (controller.chickNote()) {
                    await controller.send(id);
                    if (!controller.chick.value) {
                      Get.snackbar("ملاحظات", "تم اضافة الملاحظة بنجاح",
                          duration: Duration(seconds: 10),
                          snackStyle: SnackStyle.FLOATING,
                          barBlur: 30,
                          dismissDirection: DismissDirection.horizontal,
                          messageText: Text(
                            "تم اضافة الملاحظة بنجاح",
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
                    Get.off(() => StudentnsClass("note"));
                  }
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
