import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:jobology/HomeComponents/sectionscard.dart';
import 'package:jobology/Screens/EditUserInfo.dart';
import 'package:jobology/Screens/course.dart';
import 'package:jobology/Screens/jobs.dart';
import 'package:jobology/HomeComponents/Navigationbar.dart';
import 'package:jobology/Screens/settings.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

final PersonalInfo _personalInfo = PersonalInfo();
final Home _Home = Home();
final Settings _settings = Settings();
bool status8 = false;
int _page = 0;
Widget _showPage = new Home();

class _HomeState extends State<Home> {
//OnTapping on NavBar
  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return _personalInfo;
        break;

      case 1:
        return _Home;
        break;

      case 2:
        return _settings;
        break;

      default:
        return _Home;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 234, 234),
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: Color.fromARGB(255, 235, 234, 234),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/user.png",
              width: 50,
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Welcome",
                  style: TextStyle(
                    color: Color.fromARGB(255, 153, 152, 152),
                    fontSize: 15,
                  ),
                ),
                Text(
                  "Username,",
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
          ],
        ),
        // centerTitle: true,
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
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
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
                    OnTapping: () {},
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
    );
  }
}
