// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../themes/color.dart';

class AzkarBuilder extends StatefulWidget {
  final azkarText;
  final count;
  int countIndex;
  final profet;
  final sleepIndex;

  AzkarBuilder(
      {Key key,
      this.azkarText,
      this.count,
      this.profet,
      this.countIndex,
      this.sleepIndex})
      : super(key: key);

  @override
  State<AzkarBuilder> createState() => _AzkarBuilderState();
}

class _AzkarBuilderState extends State<AzkarBuilder> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Stack(
        children: [
          Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: mainColor[index],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  border:
                      Border.all(width: 1.0, color: const Color(0xff707070)),
                ),
                child: Text(
                  widget.azkarText,
                  style: const TextStyle(color: Colors.white, fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ),
              Stack(
                children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: widget.sleepIndex == null
                            ? Colors.white
                            : mainColor[index],
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                        border: Border.all(color: Colors.grey)),
                  ),
                  Positioned(
                    right: 10,
                    bottom: width / 50,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: mainColor[index],
                        borderRadius: const BorderRadius.all(
                            Radius.elliptical(9999.0, 9999.0)),
                        border: Border.all(
                            width: 1.0, color: const Color(0xff707070)),
                      ),
                      child: InkWell(
                        onTap: () {
                          HapticFeedback.lightImpact();

                          setState(() {
                            if (widget.countIndex > 0) {
                              widget.countIndex--;
                            }
                          });
                        },
                        child: Center(
                          child: Text(
                            widget.countIndex.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: width / 6,
                    bottom: width / 30,
                    child: Text(
                      '(${widget.count})',
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 15,
                        color: widget.sleepIndex == null
                            ? Colors.black
                            : Colors.white,
                      ),
                      textAlign: TextAlign.center,
                      softWrap: false,
                    ),
                  ),
                  Positioned(
                    right: width / 2,
                    bottom: width / 110,
                    child: Container(
                      height: 50,
                      width: 1,
                      color: mainColor[index],
                    ),
                  ),
                  Positioned(
                    right: width / 1.8,
                    bottom: 0,
                    child: SizedBox(
                        width: width / 2.9,
                        child: AutoSizeText(
                          widget.profet,
                          style: TextStyle(
                              fontSize: 15,
                              color: widget.sleepIndex == null
                                  ? Colors.black
                                  : Colors.white),
                          maxLines: 2,
                        )),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
