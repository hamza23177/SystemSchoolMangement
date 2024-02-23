// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Master/HomeMaster.dart';
import 'package:tr_app/Master/marks/marks_screen.dart';
import 'package:tr_app/Master/typeExam/component/add_exam_screen.dart';
import 'package:tr_app/Master/typeExam/component/typcontroller.dart';
import 'package:tr_app/constant.dart';

class TypeExam extends StatefulWidget {
  @override
  State<TypeExam> createState() => _TypeExamState();
}

class _TypeExamState extends State<TypeExam> {
  TextEditingController newExamTitle = TextEditingController();
  var controller = Get.put(TypeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text('Exam',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              color: primaryColorS,
                              fontWeight: FontWeight.bold,
                            )),
                        TextField(
                          autofocus: true,
                          textAlign: TextAlign.center,
                          controller: newExamTitle,
                        ),
                        const SizedBox(height: 30),
                        TextButton(
                          onPressed: () {
                            if (newExamTitle.text.isEmpty) {
                              Get.back();
                            }
                            controller.addExam(newExamTitle.text);
                            Get.back();
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: primaryColorS,
                            primary: Colors.white,
                          ),
                          child: const Text('Add'),
                        ),
                      ],
                    ),
                  )),
            ),
          );
        },
        backgroundColor: primaryColorS,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          "Exam",
          style: TextStyle(
            color: primarylightColorS,
            fontWeight: FontWeight.bold,
          ),
        ),
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
        return Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
          child: ListView.builder(
              itemBuilder: (context, i) {
                return Center(
                    child: Container(
                  padding: EdgeInsets.all(10),
                  child: TextButton(
                      onPressed: () {
                        Get.to(() => MarksClass(), arguments: [
                          controller.classid.toString(),
                          controller.subject.toString(),
                          controller.exams[i].exam.toString()
                        ]);
                      },
                      style: TextButton.styleFrom(
                        side: BorderSide(color: primaryColorS, width: 2.0),
                        primary: primaryColorS,
                        backgroundColor: primarylightColorS,
                      ),
                      child: Row(
                        // textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Icon(Icons.menu_book_rounded, size: 25),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30.0),
                            child: Text(
                              controller.exams[i].exam!,
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )),
                ));
              },
              itemCount: controller.exams.length),
        );
      }),
    );
  }
}
