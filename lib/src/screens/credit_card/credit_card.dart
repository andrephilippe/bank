import 'package:bank_card/src/widgets/bank_card/bank_card_services_slider.dart';
import 'package:bank_card/src/widgets/bank_card/bank_card_slider.dart';
import 'package:flutter/material.dart';

class CreditCardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 0, 0, 0),
          elevation: 0,
          title: Text('Credit Card'),
        ),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(height: constraints.biggest.height * 0.25, child: BankCardServicesSlider()),
            Container(height: constraints.biggest.height * 0.75, child: BankCardSliderWidget())
          ]);
        }));
  }
}
