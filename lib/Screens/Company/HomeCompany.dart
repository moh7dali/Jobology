import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CompanyHome extends StatefulWidget {
  CompanyHome({Key? key}) : super(key: key);

  @override
  State<CompanyHome> createState() => _CompanyHomeState();
}

class _CompanyHomeState extends State<CompanyHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [Text("com mphome")],
        ),
        floatingActionButton: SpeedDial(
            spaceBetweenChildren: 15,
            child: Icon(Icons.add),
            backgroundColor: Color.fromARGB(255, 61, 14, 70),
            children: [
              SpeedDialChild(
                child: Icon(Icons.shopping_bag),
                label: 'Add new job',
                onTap: () {
                  Navigator.pushNamed(context, "addNewPage");
                },
              ),
              SpeedDialChild(
                child: Icon(Ionicons.document_outline),
                label: 'Add new training',
                onTap: () {
                  Navigator.pushNamed(context, "addNewTraining");
                },
              ),
            ]),
      ),
    );
  }
}
