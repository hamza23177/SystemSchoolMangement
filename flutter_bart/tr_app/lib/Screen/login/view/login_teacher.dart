import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Screen/AFFILICATION/AffilationEmploy/affiliation_employe.dart';
import 'package:tr_app/Screen/AFFILICATION/TypeAffiliation/tybe_affiliation.dart';
import 'package:tr_app/Screen/login/controller/employeelogincontroller.dart';
import 'package:tr_app/constant.dart';

class LoginTeacher extends StatefulWidget {
  @override
  State<LoginTeacher> createState() => _LoginTeacherState();
}

class _LoginTeacherState extends State<LoginTeacher> {
  var loginController = Get.put(EmployeeLoginController());
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
              "Hello Teacher",
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
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Image.asset(
                      "assets/images/7.png",
                      height: size.height * 0.4,
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
                      onPressed: () {
                        if (loginController.chicklog()) {
                          loginController.login();
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
                            Get.to(AffiliationEmploye());
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
