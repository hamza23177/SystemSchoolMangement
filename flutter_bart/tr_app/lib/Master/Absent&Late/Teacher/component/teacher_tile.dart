// ignore_for_file: prefer_const_constructors, must_be_immutable, camel_case_types, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Master/Absent&Late/Teacher/absenteacher.dart';
import 'package:tr_app/Master/Absent&Late/Teacher/component/modelteacher.dart';

import 'package:tr_app/constant.dart';

class Teacher_tile extends StatelessWidget {
  final ModelTeacher liststudent;

  Teacher_tile(this.liststudent);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: MaterialButton(
      onPressed: () {
        Get.off(() => Absenteacher(),
            arguments: [liststudent.id, liststudent.fullName]);
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
