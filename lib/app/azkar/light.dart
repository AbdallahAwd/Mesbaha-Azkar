// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mesbaha/app/additions/public_folder.dart';
import 'package:mesbaha/app/azkar/data/light_azkar.dart';
import 'package:mesbaha/app/themes/color.dart';
import '../bannerAd/banner_ad.dart';
import 'azkar_builder.dart';

class LightAzkar extends StatefulWidget {
  final azkar;
  const LightAzkar({Key key, @required this.azkar}) : super(key: key);

  @override
  State<LightAzkar> createState() => _LightAzkarState();
}

class _LightAzkarState extends State<LightAzkar> with TickerProviderStateMixin {
  AudioPlayer player;
  AnimationController controller;
  AnimationController animationController;
  Animation<Matrix4> animation;
  TransformationController transformationController;
  TapDownDetails tapDownDetails;
  bool isExpand = true;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
        reverseDuration: const Duration(milliseconds: 400));
    controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
        reverseDuration: const Duration(milliseconds: 400));
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
          child: GestureDetector(
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

              /// it will help to view over the full screen
              // clipBehavior: Clip.none,
              clipBehavior: Clip.none,
              // panEnabled: false, // it will disable moving image
              scaleEnabled: false,
              child: Column(
                children: [
                  SizedBox(
                    height: PublicVariables.isReady
                        ? MediaQuery.of(context).size.height - 130
                        : MediaQuery.of(context).size.height - 90,
                    child: ListView.builder(
                        itemBuilder: (context, index) => AzkarBuilder(
                              azkarText: lightAzkar['azkar'][index],
                              count: lightAzkar['count'][index],
                              profet: lightAzkar['profit'][index],
                              countIndex: lightAzkar['countIndex'][index],
                            ),
                        itemCount: lightAzkar['azkar'].length),
                  ),
                  const BoxAd(),
                ],
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
            )),
      ),
    );
  }
}
