// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mesbaha/app/azkar/data/light_azkar.dart';
import 'package:mesbaha/app/themes/color.dart';
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
  bool isExpand = true;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
        reverseDuration: const Duration(milliseconds: 400));
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
          )),
    );
  }
}
