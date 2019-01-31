import 'package:bank_card/src/models/bank_card_model.dart';
import 'package:bank_card/src/screens/credit_card/credit_card_detail.dart';
import 'package:bank_card/src/widgets/common/navigation/route_transition.dart';
import 'package:bank_card/src/widgets/for_animations/bank_card_animation.dart';
import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:after_layout/after_layout.dart';

class BankCardSliderWidget extends StatefulWidget {
  @override
  _BankCardSliderState createState() => _BankCardSliderState();
}

class _BankCardSliderState extends State<BankCardSliderWidget>
    with
        SingleTickerProviderStateMixin,
        AfterLayoutMixin<BankCardSliderWidget> {
  // animations
  AnimationController _controller;
  Animation<double> _sliderOpacity;
  TransformerPageController _pageController;

  // states
  int _cardIndex = 0;

  @override
  initState() {
    super.initState();
    this._buildAnimations();
    this._pageController = TransformerPageController(
      viewportFraction: 0.75,
      itemCount: creditCards.length,
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    this._controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _buildAnimations() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _sliderOpacity = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  Widget _buildCardFlag(BankCard card) {
    return Align(
        alignment: Alignment.center,
        child: Hero(
            tag: 'hero-card-flag-${card.number}',
            child: Image.asset(card.flag, width: 150)));
  }

  Widget _buildBankCard(BankCard card) {
    return Align(
        alignment: Alignment.center,
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Hero(
              tag: 'hero-card-${card.number}',
              flightShuttleBuilder: (
                BuildContext flightContext,
                Animation<double> animation,
                HeroFlightDirection flightDirection,
                BuildContext fromHeroContext,
                BuildContext toHeroContext,
              ) {
                animation.addListener(() {
                  if (this._sliderOpacity.value == 0.0) {
                    this._controller.forward();
                  }
                });
                return RotationTransition(
                  turns: Tween(begin: 0.0, end: 0.25).animate(animation),
                  child: BankCardAnimationWidget(
                      cardImage: card.cardImage,
                      height: MediaQuery.of(context).size.width - 20,
                      width: constraints.biggest.width * 0.8),
                );
              },
              child: Container(
                height: 350,
                width: constraints.biggest.width * 0.8,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                        image: AssetImage(card.cardImage + '.png'),
                        fit: BoxFit.cover)),
              ));
        }));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget widget) {
          return Opacity(
              opacity: this._sliderOpacity.value,
              child: TransformerPageView(
                  physics: PageScrollPhysics(),
                  itemCount: creditCards.length,
                  transformer: CirclePageViewTransformer(),
                  pageController: _pageController,
                  index: this._cardIndex,
                  itemBuilder: (BuildContext context, int index) {
                    final card = creditCards[index];
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            this._cardIndex = this._pageController.page.round();
                          });
                          this._controller.reverse();
                          Navigator.of(context).push(RouteTransition(
                              CreditCardDetailScreen(
                                  card: card,
                                  eagerAsset: Image.asset(
                                      card.cardImage + '_down.png',
                                      fit: BoxFit.cover))));
                        },
                        child: Stack(
                          children: <Widget>[
                            this._buildBankCard(card),
                            this._buildCardFlag(card)
                          ],
                        ));
                  }));
        });
  }
}

class CirclePageViewTransformer extends PageTransformer {
  @override
  Widget transform(Widget item, TransformInfo info) {
    double angle = info.position / 3;
    double pos = info.position.abs() * 50;
    double xpos = info.position;

    Matrix4 matrix = Matrix4.identity()
      ..translate(xpos, pos)
      ..rotateZ(angle);
    return Transform(
      alignment: FractionalOffset.center,
      transform: matrix,
      child: item,
    );
  }
}

final creditCards = [
  BankCard(
      number: 1234567812345671,
      secureNumber: 992,
      name: 'André Menegon',
      flag: 'lib/src/assets/imgs/mastercardlogo.png',
      cardImage: 'lib/src/assets/imgs/card3',
      expiryDate: '02/30'),
  BankCard(
      number: 1234567812345672,
      secureNumber: 992,
      name: 'André Menegon',
      flag: 'lib/src/assets/imgs/elologo.png',
      cardImage: 'lib/src/assets/imgs/card1',
      expiryDate: '02/30'),
  BankCard(
      number: 1234567812345673,
      secureNumber: 992,
      name: 'André Menegon',
      flag: 'lib/src/assets/imgs/visalogo.png',
      cardImage: 'lib/src/assets/imgs/card2',
      expiryDate: '02/30'),
];
