import 'package:flutter/material.dart';

class UpToDown extends PageRouteBuilder {
  final Widget page;
  Alignment alignment;
  UpToDown(this.page, {this.alignment = Alignment.topCenter})
      : super(
            pageBuilder: (context, animation, anotherAnimation) => page,
            transitionDuration: const Duration(milliseconds: 1200),
            reverseTransitionDuration: const Duration(milliseconds: 200),
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                  parent: animation,
                  curve: Curves.fastLinearToSlowEaseIn,
                  reverseCurve: Curves.fastOutSlowIn);
              return Align(
                alignment: alignment,
                child: SizeTransition(
                  sizeFactor: animation,
                  child: page,
                  axisAlignment: 0,
                ),
              );
            });
}
