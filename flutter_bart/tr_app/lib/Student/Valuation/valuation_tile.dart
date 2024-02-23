// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tr_app/Student/Valuation/model.dart';

class Valuation_tile extends StatelessWidget {
  final ModelValyation valuationlist;
  Valuation_tile(this.valuationlist);
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
          Text(valuationlist.subject,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple[900])),
          SizedBox(
            width: 30,
          ),
          Text(valuationlist.description,
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
              Text(valuationlist.lecture,
                  style: TextStyle(fontSize: 20, color: Colors.deepPurple)),
              Row(
                children: [
                  Text(valuationlist.createdAt.toString().substring(0, 10),
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
