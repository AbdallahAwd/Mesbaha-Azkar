// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mesbaha/app/azkar/data/light_azkar.dart';
import 'package:mesbaha/app/themes/color.dart';
import 'azkar_builder.dart';
import 'package:vector_math/vector_math_64.dart';

class LightAzkar extends StatefulWidget {
  final azkar;
  const LightAzkar({Key key, @required this.azkar}) : super(key: key);

  @override
  State<LightAzkar> createState() => _LightAzkarState();
}

class _LightAzkarState extends State<LightAzkar> with TickerProviderStateMixin {
  AudioPlayer player;
  AnimationController controller;
  AnimationController zoomController;
  Animation zoomAnimation;
  bool isExpand = true;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
        reverseDuration: const Duration(milliseconds: 400));
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
  void dispose() {
    super.dispose();
    controller.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.azkar),
          actions: [
            IconButton(
                onPressed: () async {},
                icon: AnimatedIcon(
                  icon: AnimatedIcons.play_pause,
                  progress: controller,
                )),
          ],
          backgroundColor: mainColor[index],
        ),
        body: Scrollbar(
          interactive: true,
          radius: const Radius.circular(15),
          thickness: 8,
          child: InkWell(
            onDoubleTap: () {
              if (zoomController.isCompleted) {
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
                    itemBuilder: (context, index) => AzkarBuilder(
                          azkarText: lightAzkar['azkar'][index],
                          count: lightAzkar['count'][index],
                          profet: lightAzkar['profit'][index],
                          countIndex: lightAzkar['countIndex'][index],
                        ),
                    itemCount: lightAzkar['azkar'].length),
              ),
            ),
          ),
        ),
        floatingActionButton: Container(
          decoration: BoxDecoration(
              border: Border.all(color: floatingColor, width: 2),
              shape: BoxShape.circle),
          child: FloatingActionButton(
            backgroundColor: mainColor[index],
            onPressed: () async {
              await player.setAsset('assets/azkar.mp3');
              setState(() {
                if (isExpand) {
                  player.play();
                  controller.forward();
                  isExpand = !isExpand;
                } else {
                  player.stop();
                  controller.reverse();
                  isExpand = !isExpand;
                }
              });
            },
            child: AnimatedIcon(
              icon: AnimatedIcons.play_pause,
              progress: controller,
            ),
          ),
        ),
      ),
    );
  }
}
