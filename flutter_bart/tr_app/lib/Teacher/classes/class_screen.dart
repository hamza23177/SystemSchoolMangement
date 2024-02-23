import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Teacher/classes/component/class_tile.dart';
import 'package:tr_app/Teacher/classes/component/classcontroller.dart';
import 'package:tr_app/Teacher/my_drower_taecher.dart';
import 'package:tr_app/constant.dart';

class ClassScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  String type;
  ClassScreen(this.type);
  var classController = Get.put(ClassController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Classes",
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
        // initi: Get.arguments,
        initi: Get.arguments,
        onMenueTap: (page) {
          Get.off;
        },
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
                return ClaatileT(classController.classlist[i], type);
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


class ClassScreenValuation extends StatefulWidget {
  const ClassScreenValuation({Key? key}) : super(key: key);

  @override
  State<ClassScreenValuation> createState() => _ClassScreenValuationState();
}

class _ClassScreenValuationState extends State<ClassScreenValuation> {
  @override
  Widget build(BuildContext context) {
    return ClassScreen('Valuation');
  }
}   
