// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Master/HomeMaster.dart';
import 'package:tr_app/Master/marks/component/controller.dart';
import 'package:tr_app/Master/marks/component/mark_tile.dart';
import 'package:tr_app/constant.dart';

class MarksClass extends StatefulWidget {
  @override
  State<MarksClass> createState() => _MarksClassState();
}

class _MarksClassState extends State<MarksClass> {
  var studentcontroller = Get.put(MarkController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Marks",
            style: TextStyle(
              color: primarylightColorS,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            Obx(() {
              if (studentcontroller.chick.value) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                ));
              }
              return IconButton(
                onPressed: () async {
                  if (studentcontroller.chickMark()) {
                    await studentcontroller.send();
                    Get.close(3);
                    if (!studentcontroller.chick.value) {
                      Get.snackbar("علامات", "تم اضافة العلامات بنجاح",
                          duration: Duration(seconds: 10),
                          backgroundColor: Colors.white,
                          snackStyle: SnackStyle.FLOATING,
                          barBlur: 30,
                          dismissDirection: DismissDirection.horizontal,
                          messageText: Text(
                            "تم اضافة العلامات بنجاح",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              color: primaryColorS,
                              fontSize: 20,
                            ),
                          ),
                          padding: EdgeInsets.only(left: 30, right: 10),
                          icon: Icon(
                            Icons.done_all,
                            size: 30,
                            color: primaryColorS,
                          ),
                          titleText: Text(
                            "${studentcontroller.subject}  ${studentcontroller.typeexam}",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              color: primaryColorS,
                              fontSize: 16,
                            ),
                          ));
                    }
                  }
                },
                icon: const Icon(Icons.send_outlined, size: 30),
              );
            })
          ],
          backgroundColor: primaryColorS,
          automaticallyImplyLeading: false, // حذف سهم الرجوع
          leading: IconButton(
            onPressed: () {
              Get.offAll(() => HomeMaster());
            },
            icon: const Icon(Icons.home),
          ),
        ),
        body: Obx(() {
          if (studentcontroller.isloding.value) {
            return const Center(
                child: CircularProgressIndicator(
              color: primaryColorS,
            ));
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    studentcontroller.subject,
                    style: const TextStyle(
                        fontSize: 16,
                        color: primaryColorS,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    studentcontroller.typeexam,
                    style: const TextStyle(
                        fontSize: 16,
                        color: primaryColorS,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Divider(
                color: primaryColorS,
                thickness: 3,
              ),
              Form(
                key: studentcontroller.markkey,
                autovalidateMode: AutovalidateMode.always,
                child: Expanded(
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return Student_tile(studentcontroller.studentlist[i],
                            studentcontroller.markcontroller[i]);
                      },
                      separatorBuilder: (context, i) {
                        return Divider(
                          color: primaryColorS,
                        );
                      },
                      itemCount: studentcontroller.studentlist.length),
                ),
              ),
            ],
          );
        }));
  }
}
