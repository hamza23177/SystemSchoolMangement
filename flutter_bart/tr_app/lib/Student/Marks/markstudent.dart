import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Student/Marks/mark_tile.dart';
import 'package:tr_app/Student/Marks/markcontrooler.dart';

import '../../constant.dart';

class GetMark extends StatefulWidget {
  const GetMark({Key? key}) : super(key: key);

  @override
  _GetMarkState createState() => _GetMarkState();
}

class _GetMarkState extends State<GetMark> {
  var controller = Get.put(MarkController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "My Marks",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: primaryColorS,
        automaticallyImplyLeading: false, // حذف سهم الرجوع
        leading: IconButton(
          onPressed: () {
            // Get.offAll(() => HomeStudent());
          },
          icon: const Icon(Icons.home),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Image.asset(
            "assets/images/student5.png",
            width: size.width * 0.8,
          ),

          Divider(
            color: Colors.deepPurple[100],
            thickness: 2,
          ),
          // SizedBox(
          //   height: size.height * 0.015,
          // ),
          Obx(() {
            if (controller.chick.value) {
              return const Center(
                  child: CircularProgressIndicator(
                color: primaryColorS,
              ));
            }
            return Container(
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, i) {
                    return Mark_tile(controller.marklist[i]);
                  },
                  separatorBuilder: (context, i) {
                    return Divider(
                      color: Colors.deepPurple[100],
                    );
                  },
                  itemCount: controller.marklist.length),
            );
          })
        ]),
      ),
    );
  }
}
