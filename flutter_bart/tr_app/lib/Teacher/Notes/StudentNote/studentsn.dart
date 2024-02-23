// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Teacher/Notes/StudentNote/component/controller.dart';
import 'package:tr_app/Teacher/Notes/StudentNote/component/student_tile.dart';
import 'package:tr_app/Teacher/my_drower_taecher.dart';
import 'package:tr_app/constant.dart';

// var studentcontroller = Get.put(StudentsnController());
class StudentnsClass extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  String type;
  StudentnsClass(this.type);
  var studentcontroller = Get.put(StudentsnController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Students",
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
                  color: primarylightColorS,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextFormField(
                  // textDirection: TextDirection.rtl,
                  textAlign: TextAlign.start,
                  controller: studentcontroller.textcontroller,
                  style: TextStyle(fontSize: 20),
                  keyboardType: TextInputType.name,
                  onChanged: (val) {
                    studentcontroller.index.value = val.length;
                    studentcontroller.getstudents();
                  },
                  cursorColor: primaryColorS,
                  autofocus: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search here...",
                    hintStyle: TextStyle(color: primaryColorS),
                    // hintTextDirection: TextDirection.rtl,
                    icon: Icon(
                      Icons.search,
                      size: 50,
                      color: primaryColorS,
                      // textDirection: TextDirection.rtl,
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
            if (studentcontroller.isloding.value) {
              return const Center(
                  child: CircularProgressIndicator(
                color: primaryColorS,
              ));
            }
            return Expanded(
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    if (studentcontroller.index.value != 0) {
                      return Studentn_tile(
                          studentcontroller.studentlist[i], type);
                    }
                    return Container();
                  },
                  separatorBuilder: (context, i) {
                    if (studentcontroller.index.value != 0) {
                      return Divider(
                        color: primaryColorS,
                      );
                    }
                    return Container();
                  },
                  itemCount: studentcontroller.studentlist.length),
            );
          }),
        ],
      ),
    );
  }
}
