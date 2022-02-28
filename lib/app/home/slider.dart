import 'package:flutter/material.dart';
import 'package:mesbaha/app/azkar/dark.dart';
import 'package:mesbaha/app/azkar/light.dart';
import 'package:mesbaha/app/themes/color.dart';

import '../../custom_transition/up_to_down.dart';
import '../azkar/azkar_sleep.dart';

class SliderBuilder extends StatelessWidget {
  const SliderBuilder({Key key}) : super(key: key);

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
              Navigator.push(
                  context,
                  UpToDown(LightAzkar(
                    azkar: text,
                  )));
            } else if (index == 1) {
              Navigator.push(
                  context,
                  UpToDown(
                      DarkAzkar(
                        azkar: text,
                      ),
                      alignment: Alignment.center));
            } else {
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
