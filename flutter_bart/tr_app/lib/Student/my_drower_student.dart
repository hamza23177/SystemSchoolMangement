import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Screen/login/controller/studentlogincontroller.dart';
import 'package:tr_app/Student/Absent&Late/absentstudent.dart';
import 'package:tr_app/Student/Files/filestudent.dart';
import 'package:tr_app/Student/HomeStudent.dart';
import 'package:tr_app/Student/Marks/markstudent.dart';
import 'package:tr_app/Student/Notes/typenote.dart';
import 'package:tr_app/Student/Valuation/valuationstudent.dart';
import 'package:tr_app/Student/profile.dart';
import 'package:tr_app/Student/timetable/studenttimetable.dart';


import 'package:tr_app/constant.dart';

class MyDrowerStudent extends StatefulWidget {
  //getting selected menu to home page
  final Function(int) onMenueTap;
  //final int indexPage;
  const MyDrowerStudent({
    Key? key,
    required this.onMenueTap,
    // required this.indexPage,
  }) : super(key: key);

  @override
  State<MyDrowerStudent> createState() => _MyDrowerStudentState();
}

class _MyDrowerStudentState extends State<MyDrowerStudent> {
  int initialIndex = 0;
  var loginController = Get.put(StudentLoginController());
  //octive and inoctive style

  final activeTextStyle = const TextStyle(color: Colors.white);

  final inactiveTextStyle = const TextStyle(color: Colors.black);

  final activeDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    color: primaryColorS,
  );

  final List fragments = const [
    HomeStudent(),
    GetAbsent(),
    TypeNoteStudent(),
    GetMark(),
    GetValuation(),
    FilesTudent(),
    GetTimeTable(),
    ProfileS(),
  ];

  List<String> menus = [
    "Home",
    "Absent&Late",
    "Notes",
    "Marks",
    "valutaion",
    "Files",
    "Time Table",
    "Profile",
  ];

  final List<IconData> icon = [
    Icons.home_outlined,
    Icons.dnd_forwardslash_outlined,
    Icons.note_alt_outlined,
    Icons.task,
    Icons.text_increase_outlined,
    Icons.file_upload_outlined,
    Icons.calendar_month_outlined,
    Icons.person_outline_outlined,
  ];


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(
        top: 50,
        right: 10,
        left: 10,
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                Container(
                  alignment : Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                    iconSize: 25,
                    color: Colors.black54,
                  ),
                ),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset("assets/images/whatsApp.png",
                      height: 70, width: 70, fit: BoxFit.cover),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "name",
                    style: TextStyle(color: Colors.black54, fontSize: 20),
                  ),
                ),
               
              ],
            ),
            const SizedBox(
              height: 20,
            ),

            // generate menus

            SingleChildScrollView(
              child: Column(
                children: List.generate(
                  menus.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.decelerate,
                        decoration: initialIndex == index
                            ? activeDecoration
                            : const BoxDecoration(),
                        child: ListTile(
                          onTap: () {
                            setState(
                              () {
                                initialIndex = index;
                                Get.offAllNamed('/homeStudent');
                                Get.to(fragments[index]);
                              },
                            );
                            widget.onMenueTap(index);
                          },
                          title: Text(
                            menus[index],
                            style: initialIndex == index
                                ? activeTextStyle
                                : inactiveTextStyle,
                          ),
                          leading: Icon(
                            icon[index],
                            color: initialIndex == index
                                ? Colors.white
                                : Colors.black54,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Divider(
              color: Colors.black54,
              thickness: 0.5,
            ),
            ListTile(
              onTap: () {
                Get.defaultDialog(
                    title: "Logout",
                    middleText: "are you sure you want to Logout !!",
                    titleStyle: TextStyle(color: Colors.red[400]),
                    buttonColor: primaryColorS,
                    cancelTextColor: Colors.black,
                    onConfirm: () {
                      loginController.logout();
                    },
                    confirmTextColor: Colors.white,
                    textCancel: "cancel",
                    textConfirm: "Ok");
              },
              title: const Text(
                "Logout",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              leading: const Icon(Icons.logout, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}