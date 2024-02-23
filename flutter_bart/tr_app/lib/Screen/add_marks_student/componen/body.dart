import 'package:flutter/material.dart';
import 'package:tr_app/Screen/add_marks_student/componen/background.dart';
import 'package:tr_app/component/rounded_input_field.dart';
import 'package:tr_app/constant.dart';

class Body extends StatefulWidget {
  final Widget child;

  const Body({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.05),
            const Text(
              "Add Marks",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/lunch.png",
              height: size.height * 0.25,
            ),
            RoundedInputField(
              hintText: "Name Student",
              onChanged: (value) {},
            ),
            RoundedInputField(
              hintText: "mark with precent %",
              onChanged: (value) {},
            ),
            SizedBox(height: size.height * 0.05),

            // ignore: deprecated_member_use
            FlatButton(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              color: primaryColorS,
              onPressed: () {
                print("Succsess");
              },
              minWidth: size.width * 0.8,
              child: const Text("Submit", style: TextStyle(color: Colors.white)),
            ),
            // RoundedButton(
            //   text: "AFFILITION",
            //   press: () {
            //     print("succsess");
            //   },
            // ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }
}

class SocialIcon extends StatelessWidget {
  final String iconsrc;
  final Function press;
  const SocialIcon({
    Key? key,
    required this.iconsrc,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: primarylightColorS),
            shape: BoxShape.circle),
        child: Image.asset(iconsrc, height: 20, width: 20),
      ),
    );
  }
}
