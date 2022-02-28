// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mesbaha/app/azkar/azkar_builder.dart';
import 'package:mesbaha/app/azkar/data/dark_azkar.dart';
import 'package:mesbaha/app/themes/color.dart';
import 'package:vector_math/vector_math_64.dart';

class DarkAzkar extends StatefulWidget {
  final azkar;

  const DarkAzkar({Key key, @required this.azkar}) : super(key: key);

  @override
  State<DarkAzkar> createState() => _DarkAzkarState();
}

class _DarkAzkarState extends State<DarkAzkar> with TickerProviderStateMixin {
  bool isExpand = true;
  AnimationController controller;
  AudioPlayer player;

  AnimationController zoomController;

  Animation<double> zoomAnimation;
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
          backgroundColor: mainColor[index],
          title: Text(widget.azkar),
          actions: [
            IconButton(
                onPressed: () async {
                  await player.setAsset('assets/azkar2.mp3');
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
                icon: AnimatedIcon(
                  icon: AnimatedIcons.play_pause,
                  progress: controller,
                )),
          ],
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
                          azkarText: darkAzkar['azkar'][index],
                          count: darkAzkar['count'][index],
                          profet: darkAzkar['profit'][index],
                          countIndex: darkAzkar['countIndex'][index],
                        ),
                    itemCount: darkAzkar['azkar'].length),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
