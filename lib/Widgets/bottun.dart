// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:jobology/Screens/course.dart';

class Bottun_Navigater extends StatefulWidget {
  Bottun_Navigater({super.key});

  @override
  State<Bottun_Navigater> createState() => _Bottun_NavigaterState();
}

class _Bottun_NavigaterState extends State<Bottun_Navigater> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 60,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      color: Colors.purple,
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Course()));
      },
      child: const Text(
        "Get Started",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
      ),
    );
  }
}
