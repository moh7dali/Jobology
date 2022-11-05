import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNewTraining extends StatefulWidget {
  AddNewTraining({Key? key}) : super(key: key);

  @override
  State<AddNewTraining> createState() => _AddNewTrainingState();
}

class _AddNewTrainingState extends State<AddNewTraining> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
              child: ListView(
            children: [],
          )),
        ),
      ),
    );
  }
}
