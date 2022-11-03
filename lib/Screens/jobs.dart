import 'package:flutter/material.dart';
import 'package:jobology/Widgets/JobsWidget.dart';

class jobs extends StatefulWidget {
  const jobs({super.key});

  @override
  State<jobs> createState() => _jobsState();
}

class _jobsState extends State<jobs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color.fromARGB(255, 168, 104, 104),
      body: SafeArea(
          child: ListView.builder(
            itemCount: 6,
            itemBuilder: (BuildContext context, int index) {
              return  Column(
                children: [
                  ListTaleW(imageUrl: "images/aspaire.png", subTitle:"1-3 years experanse" , name:"aspaire" ),ListTaleW(
           
                  imageUrl: "images/ltuc.png",
                  subTitle: "this job for frash graduate student",
                  name: "ltuc"),
                ],
              );
            },
          )));
  }
}
