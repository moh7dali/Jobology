import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:jobology/HomeComponents/sectionscard.dart';
import 'package:jobology/Screens/EditUserInfo.dart';
import 'package:jobology/Screens/Users/interview_preview.dart';
import 'package:jobology/Screens/buttonnav.dart';
import 'package:jobology/Screens/course.dart';
import 'package:jobology/Screens/interview.dart';
import 'package:jobology/Screens/jobs.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

final PersonalInfo _personalInfo = PersonalInfo();
final Home _Home = Home();

bool status8 = false;
int _page = 0;
Widget _showPage = new Home();
String username = "";

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
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(onTap: () {
              Navigator.pushNamed(context, "personalPage");
            },
              child: Image.asset(
                "images/user.png",
                width: 50,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
          Row(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  FlutterSwitch(
                    value: status8,
                    activeColor: Color.fromARGB(135, 16, 153, 130),
                    activeIcon: const Icon(
                      Icons.dark_mode,
                      color: Color.fromARGB(255, 118, 122, 121),
                    ),
                    inactiveIcon: const Icon(
                      Icons.light_mode,
                      color: Color.fromARGB(255, 223, 239, 3),
                    ),
                    onToggle: (val) {
                      setState(() {
                        status8 = val;
                        if (Get.isDarkMode) {
                          Get.changeTheme(ThemeData.light());
                        } else {
                          Get.changeTheme(
                            ThemeData.dark(),
                          );
                        }
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Text(
                    "Start your\ntrip,",
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
                    OnTapping: () {},
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
      bottomNavigationBar: Button(),
    );
  }
}
