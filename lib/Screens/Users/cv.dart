// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jobology/Screens/Authentication/Login.dart';
import 'package:jobology/Screens/Users/Home.dart';
import 'package:jobology/Screens/Users/peronalPage/personalpage.dart';
import 'package:jobology/Widgets/mytext.dart';
import 'package:jobology/Widgets/open_url.dart';
import 'package:jobology/Widgets/texts.dart';
import 'package:jobology/Widgets/vedio.dart';
import 'package:jobology/constants.dart';
import 'package:video_player/video_player.dart';

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
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 236, 236),
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
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "In this article, we offer a guide to writing a powerful CV that will help you stand out to employers, along with easy-to-follow examples.",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.maxFinite,
                height: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(30),
                    image: DecorationImage(
                        image: AssetImage("images/cv1.jpg"), fit: BoxFit.fill)),
              ),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "What is the CV ?",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Cvt1(),
              Text(
                "Related:",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                width: 5,
              ),
              Open_url(
                url:
                    "https://www.indeed.com/career-advice/resumes-cover-letters/what-to-include-in-your-cv",
                text: "What To Include in Your CV",
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.maxFinite,
                height: 500,
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(30),
                    image: DecorationImage(
                        image: AssetImage("images/cv2.jpg"), fit: BoxFit.fill)),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 100, top: 30),
                child: Text(
                  "What is a resume?",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Cvt2(),
              Row(
                children: [
                  Text(
                    "Related:",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Open_url(
                    url:
                        "https://www.indeed.com/career-advice/resumes-cover-letters/10-resume-writing-tips",
                    text:
                        "10 Resume Writing Tips To Help\n You Land a Position",
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "(CV vs resume differences)",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Cvt3(),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.maxFinite,
                height: 500,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/cv3.jpg"), fit: BoxFit.fill)),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Read more:",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Open_url(
                    url:
                        "https://www.indeed.com/career-advice/resumes-cover-letters/difference-between-resume-and-cv",
                    text: "What’s the Difference Between \na Resume and a CV?",
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "CV template",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              Cvt4(),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.maxFinite,
                height: 500,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/cv4.jpg"), fit: BoxFit.fill)),
              ),
              Container(
                width: double.maxFinite,
                height: 500,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/cv5.jpg"), fit: BoxFit.fill)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Related: ",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Open_url(
                    url:
                        "https://www.indeed.com/career-advice/resumes-cover-letters/cv-template",
                    text:
                        "Curriculum Vitae (CV) Templates \nfor a Successful Application",
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(left: 100, top: 30),
                    child: Video(),
                  )),
                ],
              ),
            ],
          ),
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
    );
  }
}
