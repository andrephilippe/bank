import 'package:bank_card/src/models/bank_card_model.dart';
import 'package:bank_card/src/widgets/bank_card/bank_card.dart';
import 'package:flutter/material.dart';

class CreditCardDetailScreen extends StatelessWidget {
  final BankCard card;
  final Image eagerAsset;

  const CreditCardDetailScreen({Key key, this.card, this.eagerAsset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 0, 0, 0),
          elevation: 0,
          title: Text('Credit Card'),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                  height: 400, child: BankCardWidget(card: this.card, asset: this.eagerAsset)))
        ]));
  }
}
