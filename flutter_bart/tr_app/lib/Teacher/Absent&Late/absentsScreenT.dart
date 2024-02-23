// ignore_for_file: prefer_const_constructors, file_names, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Teacher/Absent&Late/controller.dart';
import 'package:tr_app/Teacher/my_drower_taecher.dart';
import 'package:tr_app/component/convertToDate.dart';
import 'package:tr_app/constant.dart';

class AbsentsScreenT extends StatefulWidget {
  const AbsentsScreenT({Key? key}) : super(key: key);

  @override
  State<AbsentsScreenT> createState() => _AbsentsScreenTState();
}

class _AbsentsScreenTState extends State<AbsentsScreenT> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  var absentcontroller = Get.put(AbsentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Absent&Late",
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
        initi: 1,
        onMenueTap: (page) {
          Get.off;
        },
      ),
      body: Obx(() {
        if (absentcontroller.isloding.value) {
          return const Center(
              child: CircularProgressIndicator(
            color: primaryColorS,
          ));
        }
        return Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(
            height: 10,
          ),
          Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return Center(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.dnd_forwardslash_outlined,
                                  size: 20.0,
                                ),
                                Text(
                                  absentcontroller.absentlist[i].type,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  ConvertToDate.formattedDate(
                                      absentcontroller.absentlist[i].createdAt),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, i) {
                        if (absentcontroller.isloding.value) {
                          return Divider(
                            color: primaryColorS,
                          );
                        }
                        return Center(
                          child: Text('empty'),
                        );
                      },
                      itemCount: absentcontroller.absentlist.length),
                )
              ])
        ]);
      }),
    );
  }
}
