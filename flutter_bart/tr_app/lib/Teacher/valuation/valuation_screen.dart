// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Teacher/my_drower_taecher.dart';
import 'package:tr_app/Teacher/valuation/controller.dart';
import 'package:tr_app/Teacher/valuation/valuation_tile.dart';
import 'package:tr_app/constant.dart';

class ValuationClass extends StatefulWidget {
  @override
  State<ValuationClass> createState() => _ValuationClassState();
}

class _ValuationClassState extends State<ValuationClass> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  var valuationcontroller = Get.put(ValuationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Valuation",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: primaryColorS,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            Obx(() {
              if (valuationcontroller.chick.value) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.black,
                ));
              }
              return IconButton(
                onPressed: () async {
                  // if (!valuationcontroller.chickMark()) {
                    await valuationcontroller.send();
                    Get.close(1);
                  // }
                },
                icon: const Icon(Icons.send_outlined, size: 30),
              );
            })
          ],
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
        ),
        drawer: MyDrowerTeacher(
          initi: 4,
          onMenueTap: (page) {
            Get.off;
          },
        ),
        body: Obx(() {
          if (valuationcontroller.isloding.value) {
            return const Center(
                child: CircularProgressIndicator(
              color: primaryColorS,
            ));
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                // textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    valuationcontroller.lecture.toString(),
                    style: const TextStyle(
                        fontSize: 30,
                        color: primaryColorS,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Divider(
                color: primaryColorS,
                thickness: 2,
              ),
              Form(
                key: valuationcontroller.valuationkey,
                // autovalidateMode: AutovalidateMode.always,
                child: Expanded(
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return Valuation_tile(
                            valuationcontroller.valuationlist[i],
                            valuationcontroller.valuationcontroller[i]);
                      },
                      separatorBuilder: (context, i) {
                        return Divider(
                          color: primaryColorS,
                        );
                      },
                      itemCount: valuationcontroller.valuationlist.length),
                ),
              ),
            ],
          );
        }));
  }
}
