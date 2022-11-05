import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:get/get.dart';

class Button extends StatefulWidget {
  Button({super.key});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
        backgroundColor: Get.theme.bottomAppBarColor,
        color: Color.fromARGB(163, 12, 117, 99),
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, "personalPage");
          }
        },
        items: [
          Icon(Icons.home),
          Icon(Icons.person),
          Icon(Icons.settings),
        ]);
  }
}
