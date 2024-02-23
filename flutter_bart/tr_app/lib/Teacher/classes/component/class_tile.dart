// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Teacher/Files/files.dart';
import 'package:tr_app/Teacher/classes/component/modelclass.dart';
import 'package:tr_app/Teacher/Notes/ClassNote/classnote.dart';
import 'package:tr_app/Teacher/typeLecture/typeLecture.dart';
import 'package:tr_app/constant.dart';

class ClaatileT extends StatelessWidget {
  final ModelClass listclass;
  final String type;
  const ClaatileT(this.listclass, this.type);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          height: 80,
      padding: EdgeInsets.all(10),
      child: TextButton(
          onPressed: () {
            if (type == "Valuation") {
              Get.to(() => TypeLecture(), arguments: listclass.id.toString());
            }
            if (type == "note") {
              Get.to(() => ClassNote(), arguments: [
                listclass.id.toString(),
                listclass.level.toString(),
                listclass.roomName.toString(),
              ]);
            }
            if (type == "file") {
              Get.to(() => SendFile(), arguments: [
                listclass.id.toString(),
                listclass.level.toString(),
                listclass.roomName.toString(),
              ]);
            }
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
              Icon(
                Icons.groups,
                size: 25.0,
              ),
              Text(
                listclass.roomName,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                listclass.level,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )),
    ));
  }
}
