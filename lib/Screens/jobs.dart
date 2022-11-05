import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobology/Screens/buttonnav.dart';

import 'package:jobology/Widgets/JobsWidget.dart';

class jobs extends StatefulWidget {
  const jobs({super.key});

  @override
  State<jobs> createState() => _jobsState();
}

class _jobsState extends State<jobs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: const Icon(Icons.lightbulb),
              onPressed: () {
                Get.isDarkMode
                    ? Get.changeTheme(ThemeData.light())
                    : Get.changeTheme(ThemeData.dark());
              })
        ],
      ),
      body: SafeArea(
          child: ListView.builder(
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              ListTaleW(
                  imageUrl: "images/aspaire.png",
                  subTitle: "1-3 years experanse",
                  name: "aspaire"),
              ListTaleW(
                  imageUrl: "images/ltuc.png",
                  subTitle: "this job for frash graduate student",
                  name: "ltuc"),
            ],
          );
        },
      )),
    );
  }
}
