// ignore_for_file: prefer_const_constructors, file_names, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Master/Absent&Late/Teacher/component/controller.dart';
import 'package:tr_app/Master/Absent&Late/Teacher/component/teacher_tile.dart';
import 'package:tr_app/Master/HomeMaster.dart';
import 'package:tr_app/constant.dart';

class TeachersAbsent extends StatelessWidget {
  var teachercontroller = Get.put(TeachersController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Teachers",
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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 60,
                width: 300,
                padding: EdgeInsets.only(left: 5.0, top: 4.0, right: 14.0),
                decoration: BoxDecoration(
                  color: Colors.cyan[50],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextFormField(
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.start,
                  controller: teachercontroller.textcontroller,
                  style: TextStyle(fontSize: 20),
                  keyboardType: TextInputType.name,
                  onChanged: (val) {
                    teachercontroller.index.value = val.length;
                    teachercontroller.getteachers();
                  },
                  cursorColor: primaryColorS,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "ابحث هنا .........",
                    hintStyle: TextStyle(color: Colors.blueGrey),
                    hintTextDirection: TextDirection.rtl,
                    icon: Icon(
                      Icons.search,
                      size: 50,
                      color: primaryColorS,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: primaryColorS,
            thickness: 1.0,
          ),
          Obx(() {
            if (teachercontroller.isloding.value) {
              return const Center(
                  child: CircularProgressIndicator(
                color: primaryColorS,
              ));
            }
            return Expanded(
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    if (teachercontroller.index.value != 0) {
                      return Teacher_tile(teachercontroller.teacherlist[i]);
                    }
                    return Container();
                  },
                  separatorBuilder: (context, i) {
                    if (teachercontroller.index.value != 0) {
                      return Divider(
                        color: primaryColorS,
                      );
                    }
                    return Container();
                  },
                  itemCount: teachercontroller.teacherlist.length),
            );
          }),
        ],
      ),
    );
  }
}
