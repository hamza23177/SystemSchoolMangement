// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:tr_app/Master/Files/controller.dart';
import 'package:tr_app/Master/HomeMaster.dart';
import 'package:tr_app/constant.dart';

class SendFile extends StatefulWidget {
  const SendFile({Key? key}) : super(key: key);

  @override
  _SendFileState createState() => _SendFileState();
}

class _SendFileState extends State<SendFile> {
  var controller = Get.put(Filecontorller());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Upload Files",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.cyan[900],
        automaticallyImplyLeading: false, // حذف سهم الرجوع
        leading: IconButton(
          onPressed: () {
            Get.offAll(() => HomeMaster());
          },
          icon: const Icon(Icons.home),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: size.height * 0.01,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(150),
                color: Colors.cyan[50]),
            child: Image.asset(
              "assets/images/books1.png",
              width: size.width * 0.7,
            ),
          ),

          Divider(
            color: Colors.cyan[50],
            thickness: 2,
          ),
          // SizedBox(
          //   height: size.height * 0.015,
          // ),
          MaterialButton(
            color: Colors.cyan[600],
            elevation: 6,
            // height: 50,
            onPressed: () async {
              pickFiles();
            },
            child: Text(
              'Pick File',
              style: TextStyle(color: primarylightColorS),
            ),
          ),
          if (controller.file != null) buildf(controller.file!),
          if (controller.file != null)
            Obx(() {
              if (controller.chick.value) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Color(0xFF00ACC1),
                ));
              }
              return MaterialButton(
                color: Colors.cyan[600],
                onPressed: () async {
                  await controller.send();
                  if (!controller.chick.value) {
                    Get.snackbar("", "تم اضافة الملفات بنجاح",
                        duration: Duration(seconds: 10),
                        snackStyle: SnackStyle.FLOATING,
                        barBlur: 30,
                        dismissDirection: DismissDirection.horizontal,
                        messageText: Text(
                          "تم اضافة الملفات بنجاح",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Colors.cyan[800],
                            fontSize: 20,
                          ),
                        ),
                        padding: EdgeInsets.only(left: 30, right: 10),
                        icon: Icon(
                          Icons.cloud_upload_outlined,
                          size: 60,
                          color: Colors.cyan[100],
                        ),
                        titleText: Text(
                          "${controller.level}  ${controller.classname}",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Colors.cyan[100],
                            fontSize: 25,
                          ),
                        ));
                  }
                  Get.close(1);
                },
                elevation: 6,
                child: Text(
                  'Upload File',
                  style: TextStyle(color: primarylightColorS),
                ),
              );
            })
        ],
      ),
    );
  }

  Widget buildf(List<PlatformFile> files) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: files.length,
          itemBuilder: (context, index) {
            final file = files[index];

            return buildFile(file);
          }),
    );
  }

  Widget buildFile(PlatformFile file) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final size = (mb >= 1)
        ? '${mb.toStringAsFixed(2)} MB'
        : '${kb.toStringAsFixed(2)} KB';
    return InkWell(
      onTap: () => viewFile(file),
      child: ListTile(
        leading: (file.extension == 'jpg' || file.extension == 'png')
            ? Image.file(
                File(file.path.toString()),
                width: 80,
                height: 80,
              )
            : SizedBox(
                width: 80,
                height: 80,
              ),
        title: Text(file.name),
        subtitle: Text('${file.extension}'),
        trailing: Text(
          size,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  void pickFiles() async {
    controller.result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'jpg',
          'jpeg',
          'png',
          'pdf',
          'docx',
          'pptx',
          'zip',
          'rar'
        ],
        allowMultiple: true);
    if (controller.result == null) return;
    controller.file = controller.result!.files;
    setState(() {});
  }

  // open the picked file
  void viewFile(PlatformFile file) {
    OpenFile.open(file.path);
  }
}
