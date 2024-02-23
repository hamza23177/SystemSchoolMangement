
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:tr_app/Master/Files/file_list.dart';
import 'package:tr_app/Master/HomeMaster.dart';
import 'package:tr_app/constant.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String fileType = 'All';
  var fileTypeList = ['All', 'Image', 'Video', 'Audio', 'MultipleFile'];

  FilePickerResult? result;
  PlatformFile? file;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Files",
          style: TextStyle(
            color: primarylightColorS,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.cyan[900],
        automaticallyImplyLeading: false, // حذف سهم الرجوع
        leading: IconButton(
          onPressed: () {
            Get.offAll(() => const HomeMaster());
          },
          icon: const Icon(Icons.home),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 5,
            left: 50,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(150),
                  color: Colors.cyan[50]),
              child: Image.asset(
                "assets/images/books1.png",
                width: size.width * 0.7,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.085,
                ),
                Divider(
                  color: Colors.cyan[50],
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Selected File Type:  ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    DropdownButton(
                      value: fileType,
                      items: fileTypeList.map((String type) {
                        return DropdownMenuItem(
                            value: type,
                            child: Text(
                              type,
                              style: const TextStyle(fontSize: 20),
                            ));
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          fileType = value!;
                          file = null;
                        });
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    pickFiles(fileType);
                  },
                  child: const Text('Pick file'),
                ),
                if (file != null) fileDetails(file!),
                if (file != null)
                  ElevatedButton(
                    onPressed: () {
                      viewFile(file!);
                    },
                    child: const Text('View Selected File'),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget fileDetails(PlatformFile file) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final size = (mb >= 1)
        ? '${mb.toStringAsFixed(2)} MB'
        : '${kb.toStringAsFixed(2)} KB';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('File Name: ${file.name}'),
          Text('File Size: $size'),
          Text('File Extension: ${file.extension}'),
          Text('File Path: ${file.path}'),
        ],
      ),
    );
  }

  void pickFiles(String? filetype) async {
    switch (filetype) {
      case 'Image':
        result = await FilePicker.platform.pickFiles(
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
            ]);
        if (result == null) return;
        file = result!.files.first;
        setState(() {});
        break;
      case 'Video':
        result = await FilePicker.platform.pickFiles(type: FileType.video);
        if (result == null) return;
        file = result!.files.first;
        setState(() {});
        break;

      case 'Audio':
        result = await FilePicker.platform.pickFiles(type: FileType.audio);
        if (result == null) return;
        file = result!.files.first;
        setState(() {});
        break;
      case 'All':
        result = await FilePicker.platform.pickFiles();
        if (result == null) return;
        file = result!.files.first;
        setState(() {});
        break;
      case 'MultipleFile':
        result = await FilePicker.platform.pickFiles(allowMultiple: true);
        if (result == null) return;
        loadSelectedFiles(result!.files);
        break;
    }
  }

  // multiple file selected
  // navigate user to 2nd screen to show selected files
  void loadSelectedFiles(List<PlatformFile> files) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FileList(files: files, onOpenedFile: viewFile)));
  }

  // open the picked file
  void viewFile(PlatformFile file) {
    OpenFile.open(file.path);
  }
}
