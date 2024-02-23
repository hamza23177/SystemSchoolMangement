// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tr_app/Student/Notes/model.dart';

class NoteclTile extends StatelessWidget {
  final ModelNote listnote;

  NoteclTile(this.listnote);
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    controller.text = listnote.note;
    return Center(
        child: Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Row(
        textDirection: TextDirection.rtl,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 100,
            width: 200,
            // color: Colors.cyan[50],
            child: TextField(
              // enabled: false,
              cursorColor: Colors.deepPurple,
              style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
              strutStyle: StrutStyle.fromTextStyle(TextStyle(
                color: Colors.white,
              )),
              controller: controller,
              textDirection: TextDirection.rtl,
              decoration: const InputDecoration(border: InputBorder.none),
              // maxLength: 20,
              maxLines: 3,
              // minLines: null,
              readOnly: true,
              // expands: true,
              // decoration: InputDecoration(
              //     // border: OutlineInputBorder(),
              //     // labelText: listnote.note,
              //     ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(listnote.createdAt.toString().substring(0, 10),
                  style:
                      TextStyle(fontSize: 11, color: Colors.deepPurple[400])),
              SizedBox(
                width: 2.0,
              ),
              Icon(
                Icons.date_range_sharp,
                size: 15,
                color: Colors.deepPurple[300],
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
