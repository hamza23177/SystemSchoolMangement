// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Teacher/my_drower_taecher.dart';
import 'package:tr_app/Teacher/typeLecture/component/add_lecture_screen.dart';
import 'package:tr_app/Teacher/typeLecture/component/typcontroller.dart';
import 'package:tr_app/Teacher/valuation/valuation_screen.dart';
import 'package:tr_app/constant.dart';

class TypeLecture extends StatefulWidget {
  @override
  State<TypeLecture> createState() => _TypeLectureState();
}

class _TypeLectureState extends State<TypeLecture> {
  var controller = Get.put(TypeLectureController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    ScrollController focus = ScrollController();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: AddLectureScreen((newLectureTitle) {}
                  ),
                ),
              ),
            );
          },
          backgroundColor: primaryColorS,
          child: const Icon(Icons.add),
        ),
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "lectures",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: primaryColorS,
        automaticallyImplyLeading: false, // حذف سهم الرجوع
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
      body:Obx((){
        if (controller.isloding.value) {
            return const Center(
                child: CircularProgressIndicator(
              color: primaryColorS,
            ));
          }
        return Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
          child: ListView.builder(
            itemBuilder: (context, i) {
              return Center(
                  child: Container(
                    height: 80,
                padding: EdgeInsets.all(10),
                child: TextButton(
                    onPressed: () {
                      Get.to(() => ValuationClass(), arguments: [
                        controller.classid.toString(),
                        controller.lectures[i].lecture.toString(),
                      ]);
                    },
                    style: TextButton.styleFrom(
                      side: BorderSide(color: primaryColorS, width: 2.0),
                      primary: primaryColorS,
                       backgroundColor: primarylightColorS,
                    ),
                    child: Row(
                      // textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left : 20.0),
                          child: Icon(Icons.menu_book_rounded, size: 25),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child: Text(
                            controller.lectures[i].lecture!,
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  ),
                )
              );
            },
            itemCount: controller.lectures.length,
            // reverse: true,
          ),
        );
        }
      ),
    );
  }
}


 
          