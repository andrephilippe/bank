import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Color.fromRGBO(31, 61, 127, 1),
              Color.fromRGBO(4, 21, 72, 1)
            ])),
        child: this.child);
  }
}
