// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jobology/Screens/Users/peronalPage/personalpage.dart';
import 'package:jobology/Widgets/cvpreview.dart';
import 'package:jobology/Widgets/texts.dart';
import 'package:jobology/constants.dart';

class Cv extends StatefulWidget {
  Cv({Key? key}) : super(key: key);

  @override
  State<Cv> createState() => _CvState();
}

String username = "";
String img_url = "";

class _CvState extends State<Cv> {
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
    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
        backgroundColor: backgroud,
        appBar: AppBar(
          toolbarHeight: 75,
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          elevation: 0,
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Ionicons.arrow_back,
                color: Colors.black,
                size: 35,
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
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
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return personalInfo(
                      user_id: FirebaseAuth.instance.currentUser!.uid,
                    );
                  },
                ));
                ;
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
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Text(
                "Discover More\nAbout CV,",
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  "We offer a guide to writing a powerful CV that will help you stand out to employers, along with easy-to-follow examples.",
                  style: TextStyle(
                    fontSize: subTitleSize,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Material(
                      elevation: 20,
                      borderRadius: BorderRadius.circular(20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return cv_previwe(
                                imageName: "images/cv1.jpg",
                                title: "What is CV?",
                                TextNumber: Cvt1(),
                                url:
                                    "https://www.indeed.com/career-advice/resumes-cover-letters/what-to-include-in-your-cv",
                                urlTitle: "What To Include in Your CV",
                              );
                            },
                          ));
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: 330,
                              height: 350,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("images/cv1.jpg"),
                                    fit: BoxFit.fill),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            Positioned(
                              top: 240,
                              left: 10,
                              child: Container(
                                width: 310,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromARGB(238, 255, 255, 255),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: ListView(
                                    children: [
                                      Text(
                                        "What is the CV ?",
                                        style: TextStyle(
                                            fontSize: titleSize,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Read more about CV...",
                                        style: TextStyle(
                                          fontSize: subTitleSize,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Material(
                      elevation: 20,
                      borderRadius: BorderRadius.circular(20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return cv_previwe(
                                imageName: "images/cv2.jpg",
                                title: "What is a Resume?",
                                TextNumber: Cvt2(),
                                url:
                                    "https://www.indeed.com/career-advice/resumes-cover-letters/10-resume-writing-tips",
                                urlTitle:
                                    "10 Resume Writing Tips To Help You Land a Position",
                              );
                            },
                          ));
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: 330,
                              height: 350,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("images/cv2.jpg"),
                                    fit: BoxFit.fill),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            Positioned(
                              top: 240,
                              left: 10,
                              child: Container(
                                width: 310,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromARGB(238, 255, 255, 255),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: ListView(
                                    children: [
                                      Text(
                                        "What is the Resume ?",
                                        style: TextStyle(
                                            fontSize: titleSize,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "know more about Resume...",
                                        style: TextStyle(
                                          fontSize: subTitleSize,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Material(
                      elevation: 20,
                      borderRadius: BorderRadius.circular(20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return cv_previwe(
                                imageName: "images/cv3.jpg",
                                title: "What is CV?",
                                TextNumber: Cvt3(),
                                url:
                                    "https://www.indeed.com/career-advice/resumes-cover-letters/difference-between-resume-and-cv",
                                urlTitle:
                                    "What’s the Difference Between a Resume and a CV?",
                              );
                            },
                          ));
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: 330,
                              height: 350,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("images/cv3.jpg"),
                                    fit: BoxFit.fill),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            Positioned(
                              top: 240,
                              left: 10,
                              child: Container(
                                width: 310,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromARGB(238, 255, 255, 255),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: ListView(
                                    children: [
                                      Text(
                                        "CV vs RESUME",
                                        style: TextStyle(
                                            fontSize: titleSize,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "CV and Resume diffrences",
                                        style: TextStyle(
                                          fontSize: subTitleSize,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Material(
                      elevation: 20,
                      borderRadius: BorderRadius.circular(20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return cv_previwe(
                                imageName: "images/cv6.jpg",
                                title: "What is CV?",
                                TextNumber: Cvt4(),
                                url:
                                    "https://www.indeed.com/career-advice/resumes-cover-letters/cv-template",
                                urlTitle:
                                    "Curriculum Vitae (CV) Templates for a Successful Application",
                              );
                            },
                          ));
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: 330,
                              height: 350,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("images/cv6.jpg"),
                                    fit: BoxFit.fill),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            Positioned(
                              top: 240,
                              left: 10,
                              child: Container(
                                width: 310,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromARGB(238, 255, 255, 255),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: ListView(
                                    children: [
                                      Text(
                                        "CV template",
                                        style: TextStyle(
                                            fontSize: titleSize,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Show CV template",
                                        style: TextStyle(
                                          fontSize: subTitleSize,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 70,
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
            backgroundColor: buttonColor,
            children: [
              SpeedDialChild(
                child: Icon(Icons.logout),
                label: 'Logout',
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.popAndPushNamed(context, "Login");
                },
              ),
              SpeedDialChild(
                child: Icon(Ionicons.person),
                label: 'Profile',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return personalInfo(
                        user_id: FirebaseAuth.instance.currentUser!.uid,
                      );
                    },
                  ));
                },
              ),
              SpeedDialChild(
                child: Icon(Ionicons.home),
                label: 'Home',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ]),
      ),
    );
  }
}
