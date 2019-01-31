import 'package:flutter/material.dart';

class BankCardAnimationWidget extends StatelessWidget {
  final String cardImage;
  final double height;
  final double width;

  const BankCardAnimationWidget({Key key, this.cardImage, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Container(
          height: this.height,
          width: this.width,
          decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.5),
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                  image: AssetImage(this.cardImage + '.png'), fit: BoxFit.cover)),
        ));
  }
}
