import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:tr_app/Teacher/Files/controller.dart';
import 'package:tr_app/Teacher/my_drower_taecher.dart';

import 'package:tr_app/constant.dart';

class SendFile extends StatefulWidget {
  const SendFile({Key? key}) : super(key: key);

  @override
  _SendFileState createState() => _SendFileState();
}

class _SendFileState extends State<SendFile> {
  var controller = Get.put(Filecontorller());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Upload Files",
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
        initi: 3,
        onMenueTap: (page) {
          Get.off;
        },
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
                color: primarylightColorS),
            child: Image.asset(
              "assets/images/books1.png",
              width: size.width * 0.7,
            ),
          ),
          const Divider(
            color: primarylightColorS,
            thickness: 2,
          ),
          MaterialButton(
            color: primaryColorS,
            elevation: 6,
            onPressed: () async {
              pickFiles();
            },
            child: const Text(
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
                  color: primaryColorS,
                ));
              }
              return Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: MaterialButton(
                  color: primaryColorS,
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
                  child: const Text(
                    'Upload File',
                    style: TextStyle(color: primarylightColorS),
                  ),
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
            : const SizedBox(
                width: 80,
                height: 80,
              ),
        title: Text(file.name),
        subtitle: Text('${file.extension}'),
        trailing: Text(
          size,
          style: const TextStyle(fontWeight: FontWeight.w700),
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
