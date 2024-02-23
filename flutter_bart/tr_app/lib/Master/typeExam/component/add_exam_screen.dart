import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Master/typeExam/component/typcontroller.dart';
import 'package:tr_app/constant.dart';

class AddExamScreen extends StatelessWidget {
  final Function addExamCallback;

  AddExamScreen(this.addExamCallback);

  var exa = Get.put(TypeController());
  TextEditingController newExamTitle = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Exam',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: primaryColorS,
                fontWeight: FontWeight.bold,
              )),
          TextField(
            autofocus: true,
            textAlign: TextAlign.center,
            controller: newExamTitle,
          ),
          const SizedBox(height: 30),
          TextButton(
            onPressed: () {
              if (newExamTitle.text.isEmpty) {
                Get.back();
              }
              exa.addExam(newExamTitle.text);
              Get.back();
            },
            style: TextButton.styleFrom(
              backgroundColor: primaryColorS,
              primary: Colors.white,
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
