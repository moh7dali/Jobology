import 'package:flutter/material.dart';
class jobInfo extends StatefulWidget {
  const jobInfo({super.key});

  @override
  State<jobInfo> createState() => _jobInfoState();
}

class _jobInfoState extends State<jobInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Text("welcome to job info page")),);
  }
}