import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

import 'app/home/home.dart';
import 'app/themes/color.dart';

Future<void> main() async {
  await GetStorage.init();
  index = GetStorage().read('themeIndex') ?? 0;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Electronic Rosary',
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
