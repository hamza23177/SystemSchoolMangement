import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Screen/login/controller/employeelogincontroller.dart';
import 'package:tr_app/Teacher/Absent&Late/absentsScreenT.dart';
import 'package:tr_app/Teacher/HomeTeacher.dart';
import 'package:tr_app/Teacher/Notes/typenote.dart';
import 'package:tr_app/Teacher/classes/class_screen.dart';
import 'package:tr_app/Teacher/profile.dart';
import 'package:tr_app/Teacher/timetable/teachhertimetable.dart';
import 'package:tr_app/api/request/response.dart';
import 'package:tr_app/constant.dart';

class MyDrowerTeacher extends StatefulWidget {
  //getting selected menu to home page
  final Function(int) onMenueTap;
  int initi = 0;
  //final int indexPage;
  MyDrowerTeacher({
    Key? key,
    required this.initi,
    required this.onMenueTap,
    // required this.indexPage,
  }) : super(key: key);

  @override
  State<MyDrowerTeacher> createState() => _MyDrowerTeacherState(initi);
}

class _MyDrowerTeacherState extends State<MyDrowerTeacher> {
  var loginController = Get.put(EmployeeLoginController());
  //octive and inoctive style
  Req head = Req();

  final activeTextStyle = const TextStyle(color: Colors.white);

  final inactiveTextStyle = const TextStyle(color: Colors.black);

  final activeDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    color: primaryColorS,
  );

  final List fragments = const [
    HomeTeacher(),
    AbsentsScreenT(),
    TypeNote(),
    ClassScreenFile(),
    ClassScreenValuation(),
    GetTimeTable(),
    ProfileT(),
  ];

  List<String> menus = [
    "Home",
    "Absent&Late",
    "Notes",
    "Files",
    "Valuation",
    "Time Table",
    "Profile",
  ];

  final List<IconData> icon = [
    Icons.home_outlined,
    Icons.dnd_forwardslash_outlined,
    Icons.note_alt_outlined,
    Icons.file_upload_outlined,
    Icons.text_increase_outlined,
    Icons.calendar_month_outlined,
    Icons.person_outline_outlined,
  ];

  _MyDrowerTeacherState(initi);

  late TransformationController controller;
  TapDownDetails? tapDownDetails;

  @override
  void initState() {
    super.initState();
    controller = TransformationController();
  }

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
              alignment: Alignment.topRight,
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
                  child: GestureDetector(
                    onTap: () => _showSecondPage(context),
                    child: Hero(
                      tag: "show",
                      child: CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.white,
                          child: Obx(() {
                            return CachedNetworkImage(
                              imageUrl:
                                  "${Req.baseUrl}teacher/get_Image_Profile",
                              httpHeaders: head.setHeaders(head.token),
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(
                                color: primaryColorS,
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            );
                          })),
                    ),
                  ),
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
                        decoration: widget.initi == index
                            ? activeDecoration
                            : const BoxDecoration(),
                        child: ListTile(
                          onTap: () {
                            widget.initi = index;
                            widget.onMenueTap(index);
                            Get.until(
                                (route) => Get.currentRoute == '/homeTeacher');
                            Get.to(fragments[index], arguments: index);
                          },
                          title: Text(
                            menus[index],
                            style: widget.initi == index
                                ? activeTextStyle
                                : inactiveTextStyle,
                          ),
                          leading: Icon(
                            icon[index],
                            color: widget.initi == index
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

  void _showSecondPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => Scaffold(
              body: Center(
                child: Hero(
                  tag: 'show',
                  child: GestureDetector(
                    onDoubleTapDown: (details) => tapDownDetails = details,
                    onDoubleTap: () {
                      final position = tapDownDetails!.localPosition;
                      const double scale = 2;
                      final x = -position.dx * (scale - 1);
                      final y = -position.dy * (scale - 1);
                      final zoom = Matrix4.identity()
                        ..translate(x, y)
                        ..scale(scale);
                      final value = controller.value.isIdentity()
                          ? zoom
                          : Matrix4.identity();
                      controller.value = value;
                    },
                    child: InteractiveViewer(
                      transformationController: controller,
                      clipBehavior: Clip.none,
                      minScale: 1,
                      maxScale: 10,
                      panEnabled: false,
                      child: AspectRatio(
                        aspectRatio: 1,
                        // child: Obx(() {
                        //   // // if(loginController.image.value == true) {
                        //   // return CachedNetworkImage(
                        //   //   imageUrl: "${Req.baseUrl}teacher/get_Image_Profile",
                        //   //   httpHeaders: head.setHeaders(head.token),
                        //   //   fit: BoxFit.cover,
                        //   // );
                        //   // }else{
                        //   //         return const Icon(Icons.person) ;
                        //   //       }
                        // }),
                      ),
                    ),
                  ),
                ),
              ),
            )));
  }
}
