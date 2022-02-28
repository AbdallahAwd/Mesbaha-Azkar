import 'package:digital_lcd/digital_lcd.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mesbaha/app/home/slider.dart';
import 'package:mesbaha/app/themes/color.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<SliderDrawerState> key = GlobalKey<SliderDrawerState>();

  String value = 'اختر الذكر';
  int counter = GetStorage().read('counter') ?? 0;
  @override
  void initState() {
    super.initState();
    GetStorage().read('drop');
    GetStorage().read('counter');
  }

  TextStyle style() {
    return const TextStyle(
      color: Colors.white,
      fontSize: 20.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: mainColor[index],
      body: SliderDrawer(
        slider: const SliderBuilder(),
        key: key,
        appBar: SliderAppBar(
          appBarColor: mainColor[index],
          title: const Text(''),
          drawerIconColor: Colors.white,
        ),
        slideDirection: SlideDirection.RIGHT_TO_LEFT,
        splashColor: Colors.red,
        child: SizedBox(
          width: width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height / 20,
                ),
                DropdownButtonHideUnderline(
                    child: Container(
                        width: 145,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: DropdownButton<String>(
                            // value: value ?? 'Lang',
                            hint: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(GetStorage().read('drop') ?? value,
                                  style: style()),
                            ),
                            items: const [
                              DropdownMenuItem(
                                child: Text('سبحـــان الله'),
                                value: 'سبحـــان الله',
                              ),
                              DropdownMenuItem(
                                child: Text("الحمـــد لله"),
                                value: 'الحمـــد لله',
                              ),
                              DropdownMenuItem(
                                child: Text('الله اكبـــر'),
                                value: 'الله اكبـــر',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  'استغفـــر الله',
                                ),
                                value: 'استغفـــر الله',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  'صلي علي الحبيب',
                                  overflow: TextOverflow.ellipsis,
                                ),
                                value: 'صلي علي الحبيب',
                              ),
                            ],
                            onChanged: (String val) {
                              setState(() {
                                value = val;
                              });
                              GetStorage().write('drop', value);
                            }))),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          HapticFeedback.heavyImpact();
                          setState(() {
                            counter = 0;
                          });
                          GetStorage().write('counter', counter);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.update,
                            size: 50,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          showAlertDialog(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.color_lens,
                            size: 50,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height / 30),
                Stack(
                  children: [
                    Container(
                      width: width / 1.1,
                      height: height / 2.5,
                      decoration: BoxDecoration(
                        color: mainColor[index],
                        borderRadius: const BorderRadius.all(
                            Radius.elliptical(9999.0, 9999.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white.withOpacity(0.8),
                              offset: const Offset(0, 5),
                              blurRadius: 10),
                        ],
                        border: Border.all(
                            width: 1.0, color: Colors.white.withOpacity(0.5)),
                      ),
                    ),
                    Positioned(
                      top: width / 10,
                      left: width / 2.8,
                      child: Text(
                        GetStorage().read('drop'),
                        style: style().copyWith(fontSize: 15),
                      ),
                    ),
                    Positioned(
                      bottom: width / 20, //20
                      left: width / 3, //130
                      child: InkWell(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          setState(() {
                            if (counter < 1000) {
                              counter++;
                            } else {
                              counter = 0;
                            }
                          });
                          GetStorage().write('counter', counter);
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: mainColor[index],
                            border: Border.all(
                                color: Colors.white.withOpacity(0.6), width: 1),
                            borderRadius: const BorderRadius.all(
                                Radius.elliptical(9999.0, 9999.0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.5),
                                offset: const Offset(0, 5),
                                blurRadius: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: width / 9,
                      left: width / 5.5,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Lcd(context).Number(
                          number: GetStorage().read('counter') ?? 0,
                          digitHorizontalMargin:
                              10, //Each time this value is increased, the digits are shrinks. default 8
                          digitCount:
                              3, //Each time this value is increased, the digits are shrinks for width.
                          lcdPadding: const EdgeInsets.symmetric(
                              horizontal:
                                  0), //this value only provides spaces to the left and right of the numbers. it also reduces proportionally the numbers
                          lcdMargin: const EdgeInsets.only(top: 50),
                          digitAlignment: MainAxisAlignment
                              .center, //if you have extra width, use it for better ui
                          lcdWidth: width /
                              1.8, // numbers automatically fit to width by count of digit. if you only use this value, the height of the lcd is automatically adjusted
                          lcdHeight:
                              90, // you may need to use scaleFactor if you use this value.
                          scaleFactor: MediaQuery.of(context).size.height <
                                  MediaQuery.of(context).size.width
                              ? 0.38
                              : 0.4, //if you use lcdHeight , set this value for better ui
                          segmentWidth:
                              10, // Thickness of each segment default 10 , best value range 5-12
                          lcdDecoration: const BoxDecoration(
                              //This is default decoration . not required
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                Color(0xffA2AC89),
                                Color(0xffABAE75)
                              ])),
                          activeColor: Colors.black87.withOpacity(
                              0.6), //This is default  . not required
                          inactiveColor: Colors.black26.withOpacity(
                              0.08), //This is default  . not required
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the AlertDialog

    AlertDialog alert = AlertDialog(
        backgroundColor: mainColor[index],
        title: const Center(
            child: Text(
          "السمــات",
          style: TextStyle(color: Colors.white),
        )),
        content: Row(
          children: [
            InkWell(
                onTap: () {
                  setState(() {
                    index = 0;
                    Navigator.pop(context);
                  });
                  GetStorage().write('themeIndex', index);
                },
                child: themeBuilder(mainColor[0])),
            const SizedBox(
              width: 15,
            ),
            InkWell(
                onTap: () {
                  setState(() {
                    index = 1;
                    Navigator.pop(context);
                  });
                  GetStorage().write('themeIndex', index);
                },
                child: themeBuilder(mainColor[1])),
            const SizedBox(
              width: 15,
            ),
            InkWell(
                onTap: () {
                  setState(() {
                    index = 2;
                    Navigator.pop(context);
                  });
                  GetStorage().write('themeIndex', index);
                },
                child: themeBuilder(mainColor[2])),
            const SizedBox(
              width: 15,
            ),
            InkWell(
                onTap: () {
                  setState(() {
                    index = 3;
                    Navigator.pop(context);
                  });
                  GetStorage().write('themeIndex', index);
                },
                child: themeBuilder(mainColor[3])),
          ],
        ));

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget themeBuilder(Color color) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
