import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Color.fromRGBO(0, 0, 0, 0),
      title: Text('Bank')
    );
  }
}
