// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:mesbaha/app/azkar/azkar_builder.dart';
import 'package:mesbaha/app/themes/color.dart';
import 'data/sleep_azkar.dart';

class AzkarSleep extends StatefulWidget {
  final azkar;

  const AzkarSleep({Key key, this.azkar}) : super(key: key);

  @override
  State<AzkarSleep> createState() => _AzkarSleepState();
}

class _AzkarSleepState extends State<AzkarSleep>
    with SingleTickerProviderStateMixin {
  // AnimationController zoomController;

  // Animation<Matrix4> zoomAnimation;
  AnimationController animationController;
  Animation<Matrix4> animation;
  TransformationController transformationController;
  TapDownDetails tapDownDetails;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300))
      ..addListener(() {
        transformationController.value = animation.value;
      });

    ///
    transformationController = TransformationController();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
    transformationController.dispose();
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
          body: GestureDetector(
            onDoubleTapDown: (details) => tapDownDetails = details,
            onDoubleTap: () {
              const double scale = 2; // 3x zoom
              final position = tapDownDetails.localPosition;
              final x = -position.dx * (scale - 1);
              final y = -position.dy * (scale - 1);

              ///
              final zoomed = Matrix4.identity()
                ..translate(x, y)
                ..scale(scale);
              final end = transformationController.value.isIdentity()
                  ? zoomed
                  : Matrix4.identity();

              animation =
                  Matrix4Tween(begin: transformationController.value, end: end)
                      .animate(CurveTween(curve: Curves.easeOut)
                          .animate(animationController));
              animationController.forward(from: 0);
            },
            child: InteractiveViewer(
              transformationController: transformationController,
              // clipBehavior: Clip.none,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              // scaleEnabled: false,

              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
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
          )),
    );
  }
}
