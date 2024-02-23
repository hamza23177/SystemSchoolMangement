import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/api/request/controller.dart';

// Downloadfile
class Downloadfile extends StatelessWidget {
  //  Downloadfile({Key? key}) : super(key: key);
  var controller = Get.put(DownloadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return AlertDialog(
            backgroundColor: Colors.white,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.cyan,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Downloading: ${(controller.progress.value * 100).toInt().toString()}%",
                  style: const TextStyle(color: Colors.black, fontSize: 17),
                )
              ],
            ));
      }),
    );
  }
}
