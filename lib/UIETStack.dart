import 'package:flutter/material.dart';

class UIETdetailstack extends StatefulWidget {
  @override
  _UIETdetailstackState createState() => _UIETdetailstackState();
}

class _UIETdetailstackState extends State<UIETdetailstack> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        new Opacity(
          opacity: 0.8,
          child: new Image(
            image: AssetImage("assets/uiet_pic.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}