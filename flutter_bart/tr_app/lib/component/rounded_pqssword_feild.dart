import 'package:flutter/material.dart';
import 'package:tr_app/component/text_field_conatiner.dart';
import 'package:tr_app/constant.dart';

class RoundedPasswordFeild extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordFeild({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<RoundedPasswordFeild> createState() => _RoundedPasswordFeildState();
}

class _RoundedPasswordFeildState extends State<RoundedPasswordFeild> {
  bool a = true;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextField(
      obscureText: a,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: "Password",
        icon: const Icon(
          Icons.lock,
          color: primaryColorS,
        ),
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
        border: InputBorder.none,
      ),
    ));
  }
}
