// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Student/Marks/modelmark.dart';

import '../../constant.dart';

class Mark_tile extends StatelessWidget {
  final ModelMark listmark;
  Mark_tile(this.listmark);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(listmark.subject,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple[900])),
          SizedBox(
            width: 30,
          ),
          Text(listmark.mark,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple[800])),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(listmark.type,
                  style: TextStyle(fontSize: 20, color: Colors.deepPurple)),
              Row(
                children: [
                  Text(listmark.createdAt.toString().substring(0, 10),
                      style: TextStyle(
                          fontSize: 11, color: Colors.deepPurple[400])),
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
        ],
      ),
    ));
  }
}
