import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Screen/AFFILICATION/AffiliationStudent/affiliation_student.dart';
import 'package:tr_app/Screen/AFFILICATION/TypeAffiliation/tybe_affiliation.dart';
import 'package:tr_app/Screen/login/controller/studentlogincontroller.dart';
import 'package:tr_app/constant.dart';

class LoginStudent extends StatefulWidget {
  @override
  State<LoginStudent> createState() => _LoginStudentState();
}

class _LoginStudentState extends State<LoginStudent> {
  var loginController = Get.put(StudentLoginController());
  bool a = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool suc = false;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          shadowColor: const Color(0X00FFFFFF),
          backgroundColor: const Color(0X00FFFFFF),
          title: const Center(
            child: Text(
              "Hello Student",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: loginController.loginkey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: size.height * 0.03),
                  Image.asset(
                    "assets/images/6.png",
                    height: size.height * 0.35,
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
                      keyboardType: TextInputType.text,
                      controller: loginController.fullnamecontroller,
                      validator: (value) {
                        return loginController.validateFullname(value!);
                      },
                      decoration: const InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: primaryColorS,
                          ),
                          hintText: "full name",
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
                      obscureText: a,
                      keyboardType: TextInputType.text,
                      controller: loginController.passwordcontroller,
                      validator: (value) {
                        return loginController.validatepassword(value!);
                      },
                      decoration: InputDecoration(
                        icon: const Icon(
                          Icons.lock,
                          color: primaryColorS,
                        ),
                        hintText: "password",
                        border: InputBorder.none,
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              a = !a;
                            });
                          },
                          child: Icon(
                              color: a ? primaryColorS : Colors.grey,
                              a ? Icons.visibility : Icons.visibility_off),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: MaterialButton(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 40),
                      color: primaryColorS,
                      onPressed: () async {
                        if (loginController.chicklog()) {
                          var ch = await loginController.login();
                          if (ch) {
                            loginController.sendToken();
                          }
                        }
                      },
                      minWidth: size.width * 0.8,
                      child: const Text("Login",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Do not have an Account ? ",
                          style: TextStyle(color: primaryColorS),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.until((route) => Get.currentRoute == '/');
                            Get.to(TypeAffiliation());
                            Get.to(AffiliationStudent());
                          },
                          child: const Text(
                            "Affilition",
                            style: TextStyle(
                              color: primaryColorS,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ]),
                  SizedBox(height: size.height * 0.07),
                ],
              ),
            ),
          ),
        ));
  }
}