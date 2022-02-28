// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:mesbaha/app/azkar/azkar_builder.dart';
import 'package:mesbaha/app/themes/color.dart';

import 'data/sleep_azkar.dart';

class AzkarSleep extends StatelessWidget {
  final azkar;

  const AzkarSleep({Key key, this.azkar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: mainColor[2],
          appBar: AppBar(
            title: Text(azkar),
            backgroundColor: mainColor[index],
          ),
          body: InteractiveViewer(
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
          )),
    );
  }
}
