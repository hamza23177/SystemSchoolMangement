// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Teacher/Absent&Late/absentsScreenT.dart';
import 'package:tr_app/Teacher/Notes/typenote.dart';
import 'package:tr_app/Teacher/classes/class_screen.dart';
import 'package:tr_app/Teacher/my_drower_taecher.dart';
import 'package:tr_app/Teacher/profile.dart';
import 'package:tr_app/Teacher/timetable/teachhertimetable.dart';
import 'package:tr_app/component/BouncingButton.dart';
import 'package:tr_app/component/DashboardCards.dart';
import 'package:tr_app/component/exit_app.dart';
import 'package:tr_app/constant.dart';

class HomeTeacher extends StatefulWidget {
  const HomeTeacher({Key? key}) : super(key: key);

  @override
  State<HomeTeacher> createState() => _HomeTeacherState();
}

class _HomeTeacherState extends State<HomeTeacher> with SingleTickerProviderStateMixin {

  final List fragments = const [
    AbsentsScreenT(),
    TypeNote(),
    ClassScreenFile(),
    ClassScreenValuation(),
    GetTimeTable(),
    ProfileT(),
  ];



  // ignore: non_constant_identifier_names
  late Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(duration: Duration(milliseconds: 1200), vsync: this);
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
    return ExitApp(
      child: AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget? child) {
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              centerTitle: true,
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
            drawer: MyDrowerTeacher(
              initi: 0,
              onMenueTap: (page) {
                Get.off;
              },
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
              child: ListView(
                children: [
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
                                onPress: (){
                                  Get.to(fragments[0],arguments: 1);
                                },
                                child: const DashboardCard(
                                  name: "Absent&Late",
                                  imgpath: "17.jpg",
                                ),
                              ),
                            ),
                            Transform(
                              transform: Matrix4.translationValues(
                                  delayedAnimation.value * width, 0, 0),
                              child: Bouncing(
                                onPress: (){
                                  Get.to(fragments[1],arguments: 2);
                                },
                                child: const DashboardCard(
                                  name: "Notes",
                                  imgpath: "18.png",
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
                                onPress: (){
                                  Get.to(fragments[2],arguments: 3);
                                },
                                child: const DashboardCard(
                                  name: "Files",
                                  imgpath: "library.png",
                                ),
                              ),
                            ),
                            Transform(
                              transform: Matrix4.translationValues(
                                  delayedAnimation.value * width, 0, 0),
                              child: Bouncing(
                                onPress: (){
                                  Get.to(fragments[3],arguments: 4);
                                },
                                child: const DashboardCard(
                                  name: "Valuation",
                                  imgpath: "19.png",
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
                                onPress: (){
                                  Get.to(fragments[4],arguments: 5);
                                },
                                child: const DashboardCard(
                                  name: "Time Table",
                                  imgpath: "calendar.png",
                                ),
                              ),
                            ),
                            Transform(
                              transform: Matrix4.translationValues(
                                  delayedAnimation.value * width, 0, 0),
                              child: Bouncing(
                                onPress: (){
                                  Get.to(fragments[5],arguments: 6);
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
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
