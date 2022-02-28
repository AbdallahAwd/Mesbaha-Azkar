// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:mesbaha/app/azkar/azkar_builder.dart';
import 'package:mesbaha/app/themes/color.dart';
import 'package:vector_math/vector_math_64.dart';
import 'data/sleep_azkar.dart';

class AzkarSleep extends StatefulWidget {
  final azkar;

  const AzkarSleep({Key key, this.azkar}) : super(key: key);

  @override
  State<AzkarSleep> createState() => _AzkarSleepState();
}

class _AzkarSleepState extends State<AzkarSleep>
    with SingleTickerProviderStateMixin {
  AnimationController zoomController;

  Animation<double> zoomAnimation;

  @override
  void initState() {
    super.initState();

    zoomController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
        reverseDuration: const Duration(milliseconds: 500));
    zoomAnimation = Tween<double>(begin: 1.0, end: 2).animate(
        CurvedAnimation(parent: zoomController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: mainColor[2],
          appBar: AppBar(
            title: Text(widget.azkar),
            backgroundColor: mainColor[index],
          ),
          body: InkWell(
            onDoubleTap: () {
              if (zoomAnimation.isCompleted) {
                zoomController.reverse();
              } else {
                zoomController.forward();
              }
            },
            child: Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.diagonal3(Vector3(zoomAnimation.value ?? 0,
                  zoomAnimation.value ?? 0, zoomAnimation.value ?? 0)),
              child: InteractiveViewer(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return AzkarBuilder(
                      azkarText: sleepAzkar['Azkar'][index],
                      count: sleepAzkar['count'][index],
                      countIndex: sleepAzkar['countIndex'][index],
                      profet: sleepAzkar['profit'][index],
                      sleepIndex: 0,
                    );
                  },
                  itemCount: sleepAzkar['profit'].length,
                ),
              ),
            ),
          )),
    );
  }
}
