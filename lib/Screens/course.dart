// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobology/Screens/coursepreviwe.dart';
import '../Widgets/JobsWidget.dart';
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
        body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('Training').snapshots(),
            builder: (context, snapshot) {
              final docs = snapshot.data!.docs;
              return Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return Course_previwe(
                                    imageUrl: "",
                                    company_name: docs[index]['Company name'],
                                    title: docs[index]['job_title'],
                                    breif: docs[index]['breif'],
                                    req: docs[index]['requirements'],
                                    url: docs[index]['url'],
                                  );
                                },
                              ));
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 15, right: 10, left: 10, bottom: 10),
                                width: double.maxFinite,
                                height: 300,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    image: DecorationImage(
                                        image: AssetImage("images/flutter.png"),
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              ListTile(
                                title: Text(docs[index]['job_title']),
                                subtitle: Text(docs[index]['Company name']),
                                leading: Icon(Icons.school),
                              )
                            ],
                          ),
                        );
                      }));
            }));
  }
}
