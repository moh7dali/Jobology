import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobology/Screens/buttonnav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Jobs').snapshots(),
            builder: (context, snapshot) {
              final docs = snapshot.data!.docs;
              return Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        return ListTaleW(
                          imageUrl: "images/aspaire.png",
                          title: docs[index]['job_title'],
                          breif: docs[index]['breif'],
                          req: docs[index]['requirements'],
                          years: docs[index]['years'],
                          url: docs[index]['url'],
                        );
                      }));
            }));
  }
}
