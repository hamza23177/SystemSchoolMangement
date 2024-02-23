import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Screen/login/view/login_master.dart';
import 'package:tr_app/Screen/login/view/login_student.dart';
import 'package:tr_app/Screen/login/view/login_teacher.dart';
import 'package:tr_app/constant.dart';

class TypeLogin extends StatefulWidget {
  @override
  State<TypeLogin> createState() => _TypeLoginState();
}

class _TypeLoginState extends State<TypeLogin> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
         automaticallyImplyLeading: false, 
         backgroundColor: primaryColorS,
          title: const Center(
            child: Text(
              "Login",
              style: TextStyle(
               color: Colors.white,
              ),
            ),
          ),
        ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: size.height * 0.04),
              Image.asset("assets/images/4.png", height: size.height * 0.45),
              SizedBox(height: size.height * 0.01),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: MaterialButton(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  color: primaryColorS,
                  onPressed: () {
                    Get.to(LoginStudent());
                  },
                  minWidth: size.width * 0.8,
                  child:
                      const Text("Student", style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: MaterialButton(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  color: primarylightColorS,
                  onPressed: () {
                    Get.to(LoginTeacher());
                  },
                  minWidth: size.width * 0.8,
                  child:
                      const Text("Teacher", style: TextStyle(color: Colors.black)),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: MaterialButton(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  color: primarylightColorS,
                  onPressed: () {
                    Get.to(LoginMaster());
                  },
                  minWidth: size.width * 0.8,
                  child:
                      const Text("Master", style: TextStyle(color: Colors.black)),
                ),
              ),
              SizedBox(height: size.height * 0.07),
            ],
          ),
        ),
      ),
    );
  }
}
