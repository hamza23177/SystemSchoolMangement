// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tr_app/Student/Files/model.dart';
import 'package:tr_app/api/request/download.dart';
import 'package:tr_app/constant.dart';

class File_tile extends StatelessWidget {
  final ModelFile filelist;
  const File_tile(this.filelist);
  @override
  Future<String> getFilePath(String filname) async {
    final dir = await getExternalStorageDirectory();
    dir!.create();
    return "${dir.path}/$filname";
  }

  Future<bool> chick() async {
    String path = await getFilePath(filelist.file);
    bool chick = await File(path).exists();
    return chick;
  }

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
          Text(filelist.fileName,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple[900])),
          SizedBox(
            width: 30,
          ),
          Text(filelist.size,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple[900])),
          Text(filelist.file.substring(11),
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple[900])),

          // SizedBox(
          //   width: 18,
          // ),
          IconButton(
              iconSize: 35,
              color: primaryColorS,
              icon: Icon(Icons.download),
              onPressed: () async {
                bool h = await chick();
                if (h) {
                  String path = await getFilePath(filelist.file);
                  OpenFile.open(path);
                } else {
                  Get.to(() => Downloadfile(),
                      arguments: filelist.file.toString());
                }
              }),
        ],
      ),
    ));
  }
}
