import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Master/HomeMaster.dart';
import 'package:tr_app/Master/classes/component/classcontroller.dart';
import 'package:tr_app/Master/classes/component/class_tile.dart';
import 'package:tr_app/constant.dart';

class ClassScreen extends StatelessWidget {
  String type;
  ClassScreen(this.type);
  var classController = Get.put(ClassController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "My classes",
            style: TextStyle(
              color: primarylightColorS,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: primaryColorS,
          automaticallyImplyLeading: false, // حذف سهم الرجوع
          leading: IconButton(
            onPressed: () {
              Get.offAll(() => const HomeMaster());
            },
            icon: const Icon(Icons.home),
          ),
        ),
        body: Obx(() {
          if (classController.isloding.value) {
            return const Center(
                child: CircularProgressIndicator(
              color: primaryColorS,
            ));
          }
          return ListView.builder(
              itemBuilder: (context, i) {
                return Claatile(classController.classlist[i], type);
              },
              itemCount: classController.classlist.length);
        }));
  }
}
class ClassScreenFile extends StatefulWidget {
  const ClassScreenFile({Key? key}) : super(key: key);

  @override
  State<ClassScreenFile> createState() => _ClassScreenFileState();
}

class _ClassScreenFileState extends State<ClassScreenFile> {
  @override
  Widget build(BuildContext context) {
    return ClassScreen('file');
  }
}    


class ClassScreenTimeTable extends StatefulWidget {
  const ClassScreenTimeTable({Key? key}) : super(key: key);

  @override
  State<ClassScreenTimeTable> createState() => _ClassScreenTimeTableState();
}

class _ClassScreenTimeTableState extends State<ClassScreenTimeTable> {
  @override
  Widget build(BuildContext context) {
    return ClassScreen('timetable');
  }
}   

class ClassScreenMark extends StatefulWidget {
  const ClassScreenMark({Key? key}) : super(key: key);

  @override
  State<ClassScreenMark> createState() => _ClassScreenMarkState();
}

class _ClassScreenMarkState extends State<ClassScreenMark> {
  @override
  Widget build(BuildContext context) {
    return ClassScreen("mark");
  }
}   
