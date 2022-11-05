import 'package:flutter/material.dart';

class PersonalInfo extends StatefulWidget {
  PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Text("Personal info")],
      ),
    );
  }
}
