import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:jobology/Widgets/JobsWidget.dart';
import 'package:jobology/Widgets/interview_wedget.dart';

class Interviwe_Preview extends StatefulWidget {
  const Interviwe_Preview({super.key});

  @override
  State<Interviwe_Preview> createState() => _Interviwe_PreviewState();
}

class _Interviwe_PreviewState extends State<Interviwe_Preview> {
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
                FirebaseFirestore.instance.collection('interview').snapshots(),
            builder: (context, snapshot) {
              final docs = snapshot.data!.docs;
              return Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        return ListTaleW(
                          imageUrl: "images/aspaire.png",
                          title: docs[index]['title'],
                          breif: docs[index]['breif'],
                        );
                      }));
            }));
  }
}
