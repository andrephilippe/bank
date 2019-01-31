import 'package:bank_card/src/models/bank_card_service_model.dart';
import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class BankCardServicesSlider extends StatefulWidget {
  @override
  _BankCardServicesSliderState createState() => _BankCardServicesSliderState();
}

class _BankCardServicesSliderState extends State<BankCardServicesSlider>
    with SingleTickerProviderStateMixin {
  TransformerPageController _pageController;
// animations
  AnimationController _controller;
  Animation<double> _sliderIndex;

  @override
  void initState() {
    super.initState();
    this._controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    this._sliderIndex = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    this._pageController = TransformerPageController(
      viewportFraction: 0.5,
      itemCount: services.length,
    );
    this._controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    this._controller.dispose();
    this._pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: this._controller,
        builder: (BuildContext context, Widget widget) {
          return TransformerPageView(
              index: this._sliderIndex.value.round(),
              itemCount: services.length,
              physics: BouncingScrollPhysics(),
              pageController: this._pageController,
              itemBuilder: (BuildContext context, int index) {
                final service = services[index];
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      service.icon,
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(service.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 19.0))),
                      Text(service.desc,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Color.fromRGBO(255, 255, 255, 0.5)))
                    ]);
              });
        });
  }

  final services = [
    BankCardService(
        title: 'Rewards',
        desc: 'Invest in your future',
        icon: Icon(Icons.turned_in_not, size: 50.0, color: Colors.grey)),
    BankCardService(
        title: 'OnePay',
        desc: 'Invest in your future',
        icon: Icon(Icons.transform, size: 50.0, color: Colors.purple)),
    BankCardService(
        title: 'SecurePay',
        desc: 'Invest in your future',
        icon: Icon(Icons.thumb_up, size: 50.0, color: Colors.blue))
  ];
}
