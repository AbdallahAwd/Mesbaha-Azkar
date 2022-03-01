// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mesbaha/app/azkar/azkar_builder.dart';
import 'package:mesbaha/app/azkar/data/dark_azkar.dart';
import 'package:mesbaha/app/themes/color.dart';

import '../additions/public_folder.dart';
import '../bannerAd/banner_ad.dart';

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
  AnimationController animationController;
  Animation<Matrix4> animation;
  TransformationController transformationController;
  TapDownDetails tapDownDetails;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
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
    animationController.dispose();
    transformationController.dispose();
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
                              azkarText: darkAzkar['azkar'][index],
                              count: darkAzkar['count'][index],
                              profet: darkAzkar['profit'][index],
                              countIndex: darkAzkar['countIndex'][index],
                            ),
                        itemCount: darkAzkar['azkar'].length),
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
