// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Teacher/valuation/controller.dart';
import 'package:tr_app/Teacher/valuation/model.dart';

import 'package:tr_app/constant.dart';

class Valuation_tile extends StatelessWidget {
  var valuationcontroller = Get.put(ValuationController());
  final ValuationModel valuationlist;
  final TextEditingController textcontroller;
  Valuation_tile(this.valuationlist, this.textcontroller);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right : 10.0),
            child: Text(
              valuationlist.fullName,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 40,
            width: 80,
            decoration: BoxDecoration(
              color:primarylightColorS,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: textcontroller,
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.number,
              cursorColor: primaryColorS,
              decoration: InputDecoration(border: InputBorder.none),
              // validator: (val) {
              //   return valuationcontroller.validateMark(val!);
              // },
            ),
          ),
          Icon(
            Icons.person,
            size: 25,
            color: primaryColorS,
          )
        ],
      ),
    ));
  }
}
