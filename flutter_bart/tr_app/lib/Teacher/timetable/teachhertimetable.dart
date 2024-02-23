import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/Teacher/my_drower_taecher.dart';
import 'package:tr_app/api/request/response.dart';
import 'package:tr_app/constant.dart';

class GetTimeTable extends StatefulWidget {
  const GetTimeTable({Key? key}) : super(key: key);

  @override
  State<GetTimeTable> createState() => _GetTimeTableState();
}

class _GetTimeTableState extends State<GetTimeTable> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  Req head = Req();
  late TransformationController controller;
  TapDownDetails? tapDownDetails;

  @override
  void initState() {
    super.initState();
    controller = TransformationController();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Time Table",
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
          initi: Get.arguments,
          onMenueTap: (page) {
            Get.off;
          },
        ),
        body: Center(
          child: GestureDetector(
            onDoubleTapDown: (details) => tapDownDetails = details,
            onDoubleTap: () {
              final position = tapDownDetails!.localPosition;
              const double scale = 2;
              final x = -position.dx * (scale - 1);
              final y = -position.dy * (scale - 1);
              final zoom = Matrix4.identity()
                ..translate(x, y)
                ..scale(scale);
              final value =
                  controller.value.isIdentity() ? zoom : Matrix4.identity();
              controller.value = value;
            },
            child: InteractiveViewer(
              transformationController: controller,
              clipBehavior: Clip.none,
              minScale: 1,
              maxScale: 10,
              panEnabled: false,
              child: AspectRatio(
                  aspectRatio: 1,
                  child: CachedNetworkImage(
                    imageUrl: "${Req.baseUrl}teacher/get_Time_Table",
                    httpHeaders: head.setHeaders(head.token),
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(
                          child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(color: primaryColorS,),),
                        ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
