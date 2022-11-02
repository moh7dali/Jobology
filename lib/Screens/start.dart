import 'package:flutter/material.dart';

class Start_page extends StatefulWidget {
  const Start_page({super.key});

  @override
  State<Start_page> createState() => _Start_pageState();
}

class _Start_pageState extends State<Start_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ElevatedButton.icon(
          onPressed: () {
            Navigator.pushNamed(context, "Login");
          },
          icon: Icon(Icons.start),
          label: Text("Get Started")),
    );
  }
}
