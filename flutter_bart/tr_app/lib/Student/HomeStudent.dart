// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Student/Absent&Late/absentstudent.dart';
import 'package:tr_app/Student/Files/filestudent.dart';
import 'package:tr_app/Student/Marks/markstudent.dart';
import 'package:tr_app/Student/Notes/typenote.dart';
import 'package:tr_app/Student/Valuation/valuationstudent.dart';
import 'package:tr_app/Student/my_drower_student.dart';
import 'package:tr_app/Student/profile/profile.dart';
import 'package:tr_app/Student/timetable/studenttimetable.dart';

import 'package:tr_app/component/BouncingButton.dart';
import 'package:tr_app/component/DashboardCards.dart';

import 'package:tr_app/constant.dart';

class HomeStudent extends StatefulWidget {
  const HomeStudent({Key? key}) : super(key: key);

  @override
  State<HomeStudent> createState() => _HomeStudentState();
}

class _HomeStudentState extends State<HomeStudent>
    with SingleTickerProviderStateMixin {
  final List fragments = const [
    GetAbsent(),
    TypeNoteStudent(),
    GetMark(),
    GetValuation(),
    FilesTudent(),
    GetTimeTable(),
    ProfileStudent(),
  ];

  // ignore: non_constant_identifier_names
  late Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
        duration: Duration(milliseconds: 1200), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    delayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn)));

    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.8, 1.0, curve: Curves.fastOutSlowIn)));

    LeftCurve = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1.0, curve: Curves.easeInOut)));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  int indexPage = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    animationController.forward();
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: const Text(
                "Home",
                style: TextStyle(
                  color: primarylightColorS,
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
            drawer: MyDrowerStudent(
              // indexPage: indexPage,
              onMenueTap: (page) {
                Get.off;
                setState(() {
                  indexPage = page;
                });
              },
            ),
            body: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                child: ListView(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                    child: Container(
                      alignment: const Alignment(1.0, 0.0),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Transform(
                              transform: Matrix4.translationValues(
                                  muchDelayedAnimation.value * width, 0, 0),
                              child: Bouncing(
                                onPress: () {
                                  Get.to(fragments[0]);
                                },
                                child: const DashboardCard(
                                  name: "Absent&Late",
                                  imgpath: "notification.png",
                                ),
                              ),
                            ),
                            Transform(
                              transform: Matrix4.translationValues(
                                  delayedAnimation.value * width, 0, 0),
                              child: Bouncing(
                                onPress: () {
                                  Get.to(fragments[1]);
                                },
                                child: const DashboardCard(
                                  name: "Notes",
                                  imgpath: "activity.png",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                    child: Container(
                      alignment: const Alignment(1.0, 0),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Transform(
                              transform: Matrix4.translationValues(
                                  delayedAnimation.value * width, 0, 0),
                              child: Bouncing(
                                onPress: () {
                                  Get.to(fragments[2]);
                                },
                                child: const DashboardCard(
                                  name: "Marks",
                                  imgpath: "exam.png",
                                ),
                              ),
                            ),
                            Transform(
                              transform: Matrix4.translationValues(
                                  delayedAnimation.value * width, 0, 0),
                              child: Bouncing(
                                onPress: () {
                                  Get.to(fragments[3]);
                                },
                                child: const DashboardCard(
                                  name: "Valuation",
                                  imgpath: "exam.png",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                    child: Container(
                      alignment: const Alignment(1.0, 0),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Transform(
                              transform: Matrix4.translationValues(
                                  muchDelayedAnimation.value * width, 0, 0),
                              child: Bouncing(
                                onPress: () {
                                  Get.to(fragments[4]);
                                },
                                child: const DashboardCard(
                                  name: "Files",
                                  imgpath: "library.png",
                                ),
                              ),
                            ),
                            Transform(
                              transform: Matrix4.translationValues(
                                  muchDelayedAnimation.value * width, 0, 0),
                              child: Bouncing(
                                onPress: () {
                                  Get.to(fragments[5]);
                                },
                                child: const DashboardCard(
                                  name: "Time Table",
                                  imgpath: "calendar.png",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                    child: Container(
                      alignment: const Alignment(1.0, 0),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, right: 20.0, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Transform(
                              transform: Matrix4.translationValues(
                                  delayedAnimation.value * width, 0, 0),
                              child: Bouncing(
                                onPress: () {
                                  Get.to(fragments[6]);
                                },
                                child: const DashboardCard(
                                  name: "Profile",
                                  imgpath: "profile.png",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ])));
      },
    );
  }
}
