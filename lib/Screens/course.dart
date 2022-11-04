// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../Widgets/courseWidget.dart';
import '../Widgets/mytext.dart';

class Course extends StatefulWidget {
  const Course({super.key});

  @override
  State<Course> createState() => _CourseState();
}

class _CourseState extends State<Course> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.only(top: 20, left: 10),
                child:
                    MyText(text: "courses", size: 35, mycolor: Colors.black)),
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: TabBar(
                  labelPadding: const EdgeInsets.only(left: 20, right: 20),
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  controller: _tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(
                      text: "Programming",
                    ),
                    Tab(
                      text: "Network",
                    ),
                    Tab(
                      text: "QA",
                    ),
                  ]),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              width: double.maxFinite,
              height: 300,
              child: TabBarView(controller: _tabController, children: const [
                Programming_list(),
                Network_list(),
                QA_list(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
