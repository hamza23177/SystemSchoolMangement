// ignore_for_file: prefer_const_constructors

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Student/profile/controller.dart';
import 'package:tr_app/api/request/response.dart';
import 'package:tr_app/constant.dart';

class ProfileStudent extends StatefulWidget {
  const ProfileStudent({Key? key}) : super(key: key);
  @override
  State<ProfileStudent> createState() => _ProfileStudentState();
}

class _ProfileStudentState extends State<ProfileStudent> {
  var controller = Get.put(ProfileSController());
  Req tok = Req();

  pickFiles() async {
    controller.result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        // allowedExtensions: ['jpg', 'jpeg', 'png'],
        allowMultiple: false);
    if (controller.result == null) return;
    controller.file = controller.result!.files.first;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColorS,
        title: const Center(
          child: Text(
            "Profile",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.03),
              Stack(children: [
                Obx(() {
                  if (controller.chickimage.value) {
                    return CircleAvatar(
                      foregroundImage: NetworkImage(
                          "http://192.168.43.220:8000/api/student/get_Image_Profile",
                          headers: tok.setHeaders(tok.token)),
                      radius: 80.0,
                    );
                  }
                  return CircleAvatar(
                    backgroundImage: AssetImage("assets/images/profile.png"),
                    radius: 80.0,
                  );
                }),
                Positioned(
                    left: size.width * 0.33,
                    top: size.height * 0.19,
                    child: IconButton(
                      onPressed: () async {
                        // ignore: await_only_futures
                        await pickFiles();
                        if (controller.file != null) {
                          await controller.sendimage();
                          await controller.send();
                          setState(() {});
                        }
                      },
                      icon: Icon(Icons.camera),
                      color: primaryColorS,
                    ))
              ]),
              SizedBox(height: size.height * 0.03),
              TextField(
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple[900]),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                controller: controller.name,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  color: primarylightColorS,
                  borderRadius: BorderRadius.circular(29),
                ),
                child: TextFormField(
                  textAlign: TextAlign.right,
                  readOnly: true,
                  controller: controller.level,
                  decoration: const InputDecoration(
                      icon: Icon(
                        Icons.date_range_outlined,
                        color: primaryColorS,
                      ),
                      prefix: Text("level :"),
                      hintText: "level",
                      border: InputBorder.none),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  color: primarylightColorS,
                  borderRadius: BorderRadius.circular(29),
                ),
                child: TextFormField(
                  textAlign: TextAlign.right,
                  readOnly: true,
                  controller: controller.roomname,
                  decoration: const InputDecoration(
                      icon: Icon(
                        Icons.date_range_outlined,
                        color: primaryColorS,
                      ),
                      prefix: Text("class :"),
                      hintText: "class",
                      border: InputBorder.none),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  color: primarylightColorS,
                  borderRadius: BorderRadius.circular(29),
                ),
                child: TextFormField(
                  textAlign: TextAlign.right,
                  readOnly: true,
                  controller: controller.birthday,
                  decoration: const InputDecoration(
                      icon: Icon(
                        Icons.date_range_outlined,
                        color: primaryColorS,
                      ),
                      prefix: Text("birth day :"),
                      hintText: "birth day",
                      border: InputBorder.none),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  color: primarylightColorS,
                  borderRadius: BorderRadius.circular(29),
                ),
                child: TextFormField(
                  textAlign: TextAlign.right,
                  controller: controller.phone,
                  readOnly: true,
                  decoration: const InputDecoration(
                      icon: Icon(
                        Icons.phone,
                        color: primaryColorS,
                      ),
                      prefix: Text("phone :"),
                      hintText: "phone",
                      border: InputBorder.none),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  color: primarylightColorS,
                  borderRadius: BorderRadius.circular(29),
                ),
                child: TextFormField(
                  textAlign: TextAlign.right,
                  controller: controller.parentphone,
                  readOnly: true,
                  decoration: const InputDecoration(
                      icon: Icon(
                        Icons.phone,
                        color: primaryColorS,
                      ),
                      prefix: Text("parent phone :"),
                      hintText: "parent phone",
                      border: InputBorder.none),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width * 0.4,
                decoration: BoxDecoration(
                  color: primarylightColorS,
                  borderRadius: BorderRadius.circular(29),
                ),
                child: TextFormField(
                  initialValue: "address",
                  readOnly: true,
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                      icon: Icon(
                        Icons.account_balance_outlined,
                        color: primaryColorS,
                      ),
                      hintText: "address",
                      border: InputBorder.none),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  color: primarylightColorS,
                  borderRadius: BorderRadius.circular(29),
                ),
                child: TextFormField(
                  // initialValue: "dsvaav",
                  textAlign: TextAlign.right,
                  controller: controller.city,
                  readOnly: true,
                  decoration: const InputDecoration(
                      icon: Icon(
                        Icons.safety_check,
                        color: primaryColorS,
                      ),
                      prefix: Text("city :"),
                      hintText: "city",
                      border: InputBorder.none),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  color: primarylightColorS,
                  borderRadius: BorderRadius.circular(29),
                ),
                child: TextFormField(
                  controller: controller.region,
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.text,
                  readOnly: true,
                  decoration: const InputDecoration(
                      icon: Icon(
                        Icons.safety_check,
                        color: primaryColorS,
                      ),
                      prefix: Text("region :"),
                      border: InputBorder.none),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  color: primarylightColorS,
                  borderRadius: BorderRadius.circular(29),
                ),
                child: TextFormField(
                  controller: controller.street,
                  textAlign: TextAlign.right,
                  readOnly: true,
                  decoration: const InputDecoration(
                      icon: Icon(
                        Icons.safety_check,
                        color: primaryColorS,
                      ),
                      prefix: Text("street :"),
                      border: InputBorder.none),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  color: primarylightColorS,
                  borderRadius: BorderRadius.circular(29),
                ),
                child: TextFormField(
                  controller: controller.buldnumber,
                  readOnly: true,
                  textAlign: TextAlign.right,
                  decoration: const InputDecoration(
                      icon: Icon(
                        Icons.bungalow_outlined,
                        color: primaryColorS,
                      ),
                      prefix: Text("bulid number :"),
                      border: InputBorder.none),
                ),
              ),
              SizedBox(height: size.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
