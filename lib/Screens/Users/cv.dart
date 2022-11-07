// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:jobology/Screens/Users/Home.dart';
import 'package:jobology/Widgets/mytext.dart';
import 'package:jobology/Widgets/open_url.dart';
import 'package:jobology/Widgets/texts.dart';
import 'package:jobology/Widgets/vedio.dart';
import 'package:video_player/video_player.dart';

class Cv extends StatelessWidget {
  const Cv({super.key});

  @override
  Widget build(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Welcome lits learn how to creat your CV",
                  style: TextStyle(
                    color: Color.fromARGB(255, 14, 11, 11),
                    fontSize: 15,
                  ),
                ),
                Text(
                  username,
                  style: const TextStyle(color: Colors.black),
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
            child: Image.asset(
              "images/user.png",
              width: 50,
            ),
          ),
          const SizedBox(
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
                padding: EdgeInsets.only(left: 100, top: 30),
                child: Text(
                  "In this article, we offer a guide to writing a powerful CV that will help you stand out to employers, along with easy-to-follow examples.",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.maxFinite,
                height: 500,
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(30),
                    image: DecorationImage(
                        image: AssetImage("images/cv1.jpg"), fit: BoxFit.fill)),
              ),
              const SizedBox(
                height: 5,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 100, top: 30),
                child: Text(
                  "what is the Cv ?",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Cvt1(),
              Padding(
                padding: EdgeInsets.only(left: 100, top: 30),
                child: Row(
                  children: [
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
                  ],
                ),
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
              Padding(
                padding: EdgeInsets.only(left: 100, top: 30),
                child: Row(
                  children: [
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
                          "https://www.indeed.com/career-advice/resumes-cover-letters/10-resume-writing-tips",
                      text:
                          "10 Resume Writing Tips To Help You Land a Position",
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 100, top: 30),
                child: Text(
                  "CV vs. resume differences",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
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
              Padding(
                padding: EdgeInsets.only(left: 100, top: 30),
                child: Row(
                  children: [
                    Text(
                      "Read more:",
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
                          "https://www.indeed.com/career-advice/resumes-cover-letters/difference-between-resume-and-cv",
                      text: "What’s the Difference Between a Resume and a CV?",
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 100, top: 30),
                child: Text(
                  "CV template",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
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
              Padding(
                padding: EdgeInsets.only(left: 100, top: 30),
                child: Row(
                  children: [
                    Text(
                      "Related: ",
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
                          "https://www.indeed.com/career-advice/resumes-cover-letters/cv-template",
                      text:
                          "Curriculum Vitae (CV) Templates for a Successful\n Application",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
