// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Teacher/Notes/ClassNote/controller.dart';
import 'package:tr_app/Teacher/my_drower_taecher.dart';
import '../../../constant.dart';

class ClassNote extends StatelessWidget {
  ClassNote({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  var controller = Get.put(ClassNoteController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Class Note",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: primaryColorS,
        automaticallyImplyLeading: false, // حذف سهم الرجوع
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
      ),
      drawer: MyDrowerTeacher(
        initi: 2,
        onMenueTap: (page) {
          Get.off;
        },
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
                  "assets/images/18.png",
                  height: 50,
                ),
                Text(
                  controller.name,
                  style: const TextStyle(
                    fontSize: 30,
                    color: primaryColorS,
                  ),
                ),
                Text(
                  controller.level,
                  style: const TextStyle(
                      fontSize: 30,
                      color: primaryColorS,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              color: primaryColorS,
            ),
            SizedBox(
              height: 10,
            ),
            Form(
              key: controller.notekey,
              autovalidateMode: AutovalidateMode.always,
              child: Container(
                height: 60,
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                  color: primarylightColorS,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextFormField(
                  autofocus: true,
                  // textDirection: TextDirection.rtl,
                  keyboardType: TextInputType.text,
                  controller: controller.textcontroller,
                  validator: (value) {
                    return controller.validateNote(value!);
                  },
                  // maxLength: 50,
                  maxLines: 3,
                  decoration: const InputDecoration(
                      hintText: "Write your note her...",
                      hintStyle: TextStyle(color: Colors.black),
                      icon: Icon(
                        Icons.edit,
                        color: primaryColorS,
                        // textDirection: TextDirection.rtl,
                        size: 25,
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
                  color: primaryColorS,
                ));
              }
              return MaterialButton(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                color: primarylightColorS,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 10,
                onPressed: () async {
                  if (controller.chickNote()) {
                    await controller.send();
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
                            "${controller.level}  ${controller.name}",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              color: Colors.cyan[100],
                              fontSize: 25,
                            ),
                          ));
                    }
                    Get.close(1);
                  }
                },
                child: Text("Submit", style: TextStyle(color: Colors.black)),
              );
            }),
          ],
        ),
      ),
    );
  }
}
