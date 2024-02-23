// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Master/Files/files.dart';
import 'package:tr_app/Master/Time_table/timeTable.dart';
import 'package:tr_app/Master/classes/component/modelclass.dart';
import 'package:tr_app/Master/subject/subject_screen.dart';
import 'package:tr_app/Master/Notes/ClassNote/classnote.dart';
import 'package:tr_app/constant.dart';

class Claatile extends StatelessWidget {
  final ModelClass listclass;
  final String type;
  const Claatile(this.listclass, this.type);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      padding: EdgeInsets.all(10),
      child: TextButton(
          onPressed: () {
            if (type == "mark") {
              Get.to(() => SubjectScreen(), arguments: listclass.id.toString());
            }
            if (type == "note") {
              Get.to(() => ClassNote(), arguments: [
                listclass.id.toString(),
                listclass.level.toString(),
                listclass.roomName.toString()
              ]);
            }
            if (type == "file") {
              Get.to(() => SendFile(), arguments: [
                listclass.id.toString(),
                listclass.level.toString(),
                listclass.roomName.toString()
              ]);
            }
            if (type == "timetable") {
              Get.to(() => SendTimeTable(), arguments: [
                listclass.id.toString(),
                listclass.level.toString(),
                listclass.roomName.toString()
              ]);
            }
          },
          style: TextButton.styleFrom(
            side: BorderSide(color: primaryColorS, width: 2.0),
            primary: primaryColorS,
          ),
          child: Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.groups,
                size: 35.0,
              ),
              Text(
                listclass.roomName,
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                listclass.level,
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )),
    ));
  }
}
