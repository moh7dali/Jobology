// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jobology/Screens/Users/cv.dart';
import 'package:jobology/Widgets/sectionscard.dart';
import 'package:jobology/Screens/Authentication/Login.dart';
import 'package:jobology/Screens/Users/interview_preview.dart';
import 'package:jobology/Screens/Users/course.dart';
import 'package:jobology/Screens/Users/jobs.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

final Home _Home = Home();
bool status8 = false;
int _page = 0;
Widget _showPage = new Home();
String username = "";
String img_url = "";

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      setState(() {
        username = event['Fullname'];
        img_url = event['img'];
      });
    });
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Image.asset(
              "images/back.png",
              width: 26,
            ),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.popAndPushNamed(context, "Login");
            },
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ignore: prefer_const_constructors
                Text(
                  "Welcome",
                  style: TextStyle(
                    color: Color.fromARGB(255, 153, 152, 152),
                    fontSize: 15,
                  ),
                ),
                Text(
                  username,
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "personalPage");
            },
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(img_url),
            ),
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text(
                      "Start your\njourney,",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SectionsCard(
                      OnTapping: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Course();
                            },
                          ),
                        );
                      },
                      CardTitle: "Courses",
                      CardSubTitle: "Your way to your job",
                      ImageName: "images/Courses.png",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SectionsCard(
                      OnTapping: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Cv();
                            },
                          ),
                        );
                      },
                      CardTitle: "CV",
                      CardSubTitle: "Create your CV",
                      ImageName: "images/cv.png",
                    ),
                  ],
                ),
                const SizedBox(
                  width: 30,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    SectionsCard(
                      OnTapping: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return jobs();
                            },
                          ),
                        );
                      },
                      CardTitle: "Jobs",
                      CardSubTitle: "Find your job easly",
                      ImageName: "images/job.png",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SectionsCard(
                      OnTapping: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Interviwe_Preview();
                            },
                          ),
                        );
                      },
                      CardTitle: "Interview Questions",
                      CardSubTitle: "",
                      ImageName: "images/interview.png",
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
          buttonSize: Size(70, 70),
          spaceBetweenChildren: 15,
          child: Icon(
            Ionicons.menu,
            size: 30,
          ),
          backgroundColor: Color.fromARGB(255, 61, 14, 70),
          children: [
            SpeedDialChild(
              child: Icon(Icons.logout),
              label: 'Logout',
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Login();
                    },
                  ),
                );
              },
            ),
            SpeedDialChild(
              child: Icon(Ionicons.person),
              label: 'Profile',
              onTap: () {
                Navigator.pushNamed(context, "personalPage");
              },
            ),
            SpeedDialChild(
              child: Icon(Ionicons.home),
              label: 'Home',
              onTap: () {
                Navigator.pushNamed(context, "Home");
              },
            ),
          ]),
    );
  }
}
