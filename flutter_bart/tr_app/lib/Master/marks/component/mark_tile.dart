// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Master/marks/component/controller.dart';
import 'package:tr_app/Master/marks/component/model.dart';

import 'package:tr_app/constant.dart';

class Student_tile extends StatelessWidget {
  var markcontroller = Get.put(MarkController());
  final MarkModel liststudent;
  final TextEditingController textcontroller;
  Student_tile(this.liststudent, this.textcontroller);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      height: 80,
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
          Container(
            height: 40,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.cyan[50],
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: textcontroller,
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.number,
              cursorColor: primaryColorS,
              decoration: InputDecoration(border: InputBorder.none),
              validator: (val) {
                return markcontroller.validateMark(val!);
              },
            ),
          ),
          Icon(
            Icons.person,
            size: 35,
            color: primaryColorS,
          )
        ],
      ),
    ));
  }
}
