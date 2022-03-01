// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mesbaha/app/azkar/dark.dart';
import 'package:mesbaha/app/azkar/light.dart';
import 'package:mesbaha/app/azkar/notifecation/notifecation.dart';
import 'package:mesbaha/app/themes/color.dart';

import '../../custom_transition/up_to_down.dart';
import '../azkar/azkar_sleep.dart';

class SliderBuilder extends StatefulWidget {
  SliderBuilder({Key key}) : super(key: key);

  @override
  State<SliderBuilder> createState() => _SliderBuilderState();
}

class _SliderBuilderState extends State<SliderBuilder> {
  bool isScheduleDark = true;
  bool isScheduleLight = true;
  bool isScheduleSleep = true;
  @override
  void initState() {
    super.initState();
    isScheduleDark = GetStorage().read('isScheduleDark') ?? true;
    isScheduleDark = GetStorage().read('isScheduleLight') ?? true;
    isScheduleSleep = GetStorage().read('isScheduleSleep') ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        color: slideColor[index],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTileBuilder('أذكــار الصبـــاح', Icons.light_mode, 0, context),
            ListTileBuilder(
                'أذكــار المســـاء', Icons.dark_mode_outlined, 1, context),
            ListTileBuilder(
                'أذكــار النــوم', Icons.night_shelter_outlined, 2, context),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget ListTileBuilder(String text, IconData icon, index, context) =>
      ListTile(
          onTap: () {
            if (index == 0) {
              if (DateTime.now().hour > 3 &&
                  DateTime.now().hour < 12 &&
                  isScheduleLight) {
                NotificationApi.notify(
                  title: text,
                  body: 'حان وقت اذكار الصباح',
                  channelKey: 'lightAzkar',
                  id: 0,
                  notificationInterval: 84000,
                );
                NotificationApi.goToAzkarScreen(
                    context,
                    LightAzkar(
                      azkar: text,
                    ));
                isScheduleLight = false;
                GetStorage().write('isScheduleLight', isScheduleLight);
              }
              Navigator.push(
                  context,
                  UpToDown(LightAzkar(
                    azkar: text,
                  )));
            } else if (index == 1) {
              if (DateTime.now().hour > 15 &&
                  DateTime.now().hour < 19 &&
                  isScheduleDark) {
                NotificationApi.notify(
                  title: text,
                  body: 'حان وقت $text',
                  channelKey: 'darkAzkar',
                  id: 1,
                  notificationInterval: 84000,
                );
                NotificationApi.goToAzkarScreen(
                  context,
                  DarkAzkar(
                    azkar: text,
                  ),
                );
                isScheduleDark = false;
                GetStorage().write('isScheduleDark', isScheduleDark);
              }
              Navigator.push(
                  context,
                  UpToDown(
                      DarkAzkar(
                        azkar: text,
                      ),
                      alignment: Alignment.center));
            } else {
              if (DateTime.now().hour > 19 &&
                  DateTime.now().hour < 23 &&
                  isScheduleSleep) {
                NotificationApi.notify(
                  title: text,
                  body: 'حان وقت $text',
                  channelKey: 'sleepAzkar',
                  id: 2,
                  notificationInterval: 84000,
                );
                NotificationApi.goToAzkarScreen(
                  context,
                  AzkarSleep(
                    azkar: text,
                  ),
                );
                isScheduleSleep = false;
                GetStorage().write('isScheduleDark', isScheduleSleep);
              }
              Navigator.push(
                  context,
                  UpToDown(
                      AzkarSleep(
                        azkar: text,
                      ),
                      alignment: Alignment.bottomCenter));
            }
          },
          title: Text(
            text,
            style: const TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
          leading: Icon(
            icon,
            color: Colors.white,
            size: 25,
          ));
}
