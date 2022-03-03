import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'app/home/home.dart';
import 'app/themes/color.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await GetStorage.init();
  index = GetStorage().read('themeIndex') ?? 0;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  AwesomeNotifications().initialize(
    'resource://drawable/islam',
    [
      NotificationChannel(
        channelKey: 'lightAzkar',
        channelName: 'Light',
        channelDescription: 'Notification channel for Light Azkar',
        defaultColor: mainColor[index],
        ledColor: Colors.white,
        playSound: true,
        enableLights: true,
        enableVibration: true,
      ),
      NotificationChannel(
        channelKey: 'darkAzkar',
        channelName: 'dark',
        channelDescription: 'Notification channel for Dark Azkar',
        defaultColor: mainColor[index],
        ledColor: Colors.white,
        playSound: true,
        enableLights: true,
        enableVibration: true,
      ),
      NotificationChannel(
        channelKey: 'sleepAzkar',
        channelName: 'sleep',
        channelDescription: 'Notification channel for Sleep Azkar',
        defaultColor: mainColor[index],
        ledColor: Colors.white,
        playSound: true,
        enableLights: true,
        enableVibration: true,
      ),
      NotificationChannel(
        channelKey: 'Azkar',
        channelName: 'azkar',
        channelDescription: 'Notification channel for  Azkar',
        defaultColor: mainColor[index],
        ledColor: Colors.white,
        playSound: true,
        enableLights: true,
        enableVibration: true,
        importance: NotificationImportance.Max,
      ),
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مسبحة الكترونية',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: mainColor[index],
          ))),
      home: const Home(),
    );
  }
}
