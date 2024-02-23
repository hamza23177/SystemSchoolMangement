import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Student/Absent&Late/absent_tile.dart';
import 'package:tr_app/Student/Absent&Late/absentcontroller.dart';
import 'package:tr_app/api/request/response.dart';
import 'package:tr_app/constant.dart';

class GetAbsent extends StatefulWidget {
  const GetAbsent({Key? key}) : super(key: key);

  @override
  _GetAbsentState createState() => _GetAbsentState();
}

class _GetAbsentState extends State<GetAbsent> {
  var controller = Get.put(AbsentController());
  Req head = Req();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "My Valuations",
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
            "assets/images/student23.png",
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
                    return Absent_tile(controller.absentlist[i]);
                  },
                  separatorBuilder: (context, i) {
                    return Divider(
                      color: Colors.deepPurple[100],
                    );
                  },
                  itemCount: controller.absentlist.length),
            );
          })
        ]),
      ),
    );
  }
}
