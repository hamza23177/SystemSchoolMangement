// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Master/HomeMaster.dart';
import 'package:tr_app/Master/subject/component/add_subject_screen.dart';
import 'package:tr_app/Master/subject/component/controllersub.dart';
import 'package:tr_app/Master/typeExam/typeExam.dart';
import 'package:tr_app/constant.dart';

class SubjectScreen extends StatefulWidget {
  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  var controller = Get.put(SubController());
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
                  child: AddSubjectScreen((newSubjectTitle) {}),
                ),
              ),
            );
          },
          backgroundColor: primaryColorS,
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text(
            "Subject",
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
                  height: 80,
                  padding: EdgeInsets.all(10),
                  child: TextButton(
                      onPressed: () {
                        Get.to(() => TypeExam(), arguments: [
                          controller.classid.toString(),
                          controller.subjects[i].subject.toString()
                        ]);
                      },
                      style: TextButton.styleFrom(
                        side: BorderSide(color: primaryColorS, width: 2.0),
                        primary: primaryColorS,
                        backgroundColor: primarylightColorS,
                      ),
                      child: Row(
                        // textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.subjects[i].subject!,
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                ));
              },
              itemCount: controller.subjects.length,
              // reverse: true,
            ),
          );
        }));
  }
}
