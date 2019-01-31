import 'package:bank_card/src/models/bank_card_model.dart';
import 'package:bank_card/src/widgets/for_animations/bank_card_animation.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class BankCardWidget extends StatefulWidget {
  final BankCard card;
  final Animation<double> animation;
  final Image asset;

  const BankCardWidget({Key key, this.card, this.animation, this.asset})
      : super(key: key);

  @override
  _BankCardState createState() => _BankCardState();
}

class _BankCardState extends State<BankCardWidget>
    with SingleTickerProviderStateMixin, AfterLayoutMixin<BankCardWidget> {
  // animations
  AnimationController _controller;
  Animation<double> _animationOpacity;
  Animation<double> _animationUpDetails;

  // states
  String _cardNumber = '**** **** **** ****';

  @override
  initState() {
    super.initState();
    this._buildAnimations();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(
        const Duration(milliseconds: 1000), () => this._controller.forward());
  }

  void _buildAnimations() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    final CurvedAnimation curve =
        CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _animationOpacity = Tween(begin: 0.0, end: 1.0).animate(curve);
    _animationUpDetails = Tween(begin: 190.0, end: 140.0).animate(curve);
  }

  Widget _buildCard() {
    return Hero(
        tag: 'hero-card-${widget.card.number}',
        flightShuttleBuilder: (
          BuildContext flightContext,
          Animation<double> animation,
          HeroFlightDirection flightDirection,
          BuildContext fromHeroContext,
          BuildContext toHeroContext,
        ) {
          return RotationTransition(
            turns: Tween(begin: 0.0, end: 0.25).animate(animation),
            child: BankCardAnimationWidget(
                cardImage: widget.card.cardImage,
                height: MediaQuery.of(context).size.width - 20,
                width: 250.0),
          );
        },
        child: Container(
            height: 450,
            width: MediaQuery.of(context).size.width - 20,
            child: Align(
                alignment: Alignment.center,
                child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width - 20,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: widget.asset,
                    )))));
  }

  Widget _buildCardFlag() {
    return Positioned(
        top: 100,
        left: 20,
        child: Hero(
            tag: 'hero-card-flag-${widget.card.number}',
            child: Image.asset(widget.card.flag, height: 40)));
  }

  Widget _buildCardDetails() {
    return AnimatedBuilder(
        animation: this._controller,
        builder: (BuildContext context, Widget child) {
          return Positioned(
              top: this._animationUpDetails.value,
              child: Opacity(
                  opacity: this._animationOpacity.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Text(this._cardNumber,
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 3.0))),
                      Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Image.asset('lib/src/assets/imgs/chip.png')),
                      Row(children: <Widget>[
                        Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Card Holder name',
                                      style: TextStyle(
                                          fontSize: 14, letterSpacing: 3.0)),
                                  Text(widget.card.name,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 3.0))
                                ])),
                        Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Expiry date',
                                      style: TextStyle(
                                          fontSize: 14, letterSpacing: 3.0)),
                                  Text(widget.card.expiryDate,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 3.0))
                                ])),
                      ]),
                    ],
                  )));
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: GestureDetector(
          onTap: () {
            setState(() {
              this._cardNumber = this._cardNumber == '**** **** **** ****'
                  ? widget.card.number.toString()
                  : '**** **** **** ****';
            });
          },
          child: Stack(
            children: <Widget>[
              this._buildCard(),
              this._buildCardFlag(),
              this._buildCardDetails()
            ],
          )),
      onWillPop: () {
        this._controller.reverse().then((_) {
          this._controller.dispose();
        });
        return Future.delayed(const Duration(milliseconds: 500), () => true);
      },
    );
  }
}
