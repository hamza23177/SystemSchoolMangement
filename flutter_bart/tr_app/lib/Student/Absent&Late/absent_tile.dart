// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tr_app/Student/Absent&Late/model.dart';

class Absent_tile extends StatelessWidget {
  final ModelAbsent absentlist;
  Absent_tile(this.absentlist);
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
          Text(absentlist.type,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple[900])),
          SizedBox(
            width: 30,
          ),
          SizedBox(
            width: 20,
          ),
          Row(
            children: [
              Text(absentlist.createdAt.toString().substring(0, 10),
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
