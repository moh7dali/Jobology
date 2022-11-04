import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  MyText(
      {super.key,
      required this.text,
      required this.size,
      required this.mycolor});
  String? text;
  double? size;
  Color? mycolor;
  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: TextStyle(
          fontSize: size,
          // fontWeight: FontWeight.bold,
          color: mycolor),
    );
  }
}
