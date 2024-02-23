// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Master/Absent&Late/Student/abstudent.dart';
import 'package:tr_app/Master/marks/component/model.dart';
import 'package:tr_app/Master/Notes/StudentNote/component/controller.dart';
import 'package:tr_app/Master/Notes/StudentNote/notestudent.dart';

import 'package:tr_app/constant.dart';

class Studentn_tile extends StatelessWidget {
  String type;
  var markcontroller = Get.put(StudentsnController());
  final MarkModel liststudent;

  Studentn_tile(this.liststudent, this.type);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: MaterialButton(
      onPressed: () {
        if (type == "note") {
          Get.off(() => NoteStudent(),
              arguments: [liststudent.id, liststudent.fullName]);
        }
        if (type == "absent") {
          Get.off(() => AbsentStudent(),
              arguments: [liststudent.id, liststudent.fullName]);
        }
      },
      child: Container(
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        child: Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              liststudent.fullName,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.person,
              size: 35,
              color: primaryColorS,
            )
          ],
        ),
      ),
    ));
  }
}
