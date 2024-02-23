import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Student/Valuation/valuation_tile.dart';
import 'package:tr_app/Student/Valuation/valucontroller.dart';

import '../../constant.dart';

class GetValuation extends StatefulWidget {
  const GetValuation({Key? key}) : super(key: key);

  @override
  _GetValuationState createState() => _GetValuationState();
}

class _GetValuationState extends State<GetValuation> {
  var controller = Get.put(VluController());
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
            "assets/images/student24.png",
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
                    return Valuation_tile(controller.valuationlist[i]);
                  },
                  separatorBuilder: (context, i) {
                    return Divider(
                      color: Colors.deepPurple[100],
                    );
                  },
                  itemCount: controller.valuationlist.length),
            );
          })
        ]),
      ),
    );
  }
}
