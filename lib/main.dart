import 'package:bank_card/src/screens/credit_card/credit_card.dart';
import 'package:bank_card/src/template/background/background.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Background(
        child: MaterialApp(
      title: 'Bank',
      theme: ThemeData.dark(),
      home: CreditCardScreen(),
    ));
  }
}
