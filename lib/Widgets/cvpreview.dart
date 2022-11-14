// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jobology/Screens/Users/peronalPage/personalpage.dart';
import 'package:jobology/constants.dart';
import 'open_url.dart';

class cv_previwe extends StatefulWidget {
  cv_previwe({
    this.imageName,
    this.TextNumber,
    this.title,
    this.urlTitle,
    this.url,
  });
  Widget? TextNumber;
  String? title;
  String? imageName;
  String? urlTitle;
  String? url;

  @override
  State<cv_previwe> createState() => _cv_previweState();
}

class _cv_previweState extends State<cv_previwe> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroud,
        body: SizedBox(
          width: double.maxFinite,
          height: double.infinity,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: double.maxFinite,
                  height: 320,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.imageName!),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 30,
                left: 15,
                child: Container(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Ionicons.arrow_back,
                      color: Colors.black,
                      size: 35,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 290,
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  width: MediaQuery.of(context).size.width,
                  height: height * 0.7,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35))),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title!,
                              style: TextStyle(
                                  fontSize: titleSize,
                                  fontWeight: FontWeight.bold),
                            ),
                            Divider(
                              height: 20,
                            ),
                            widget.TextNumber!,
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Related:",
                              style: TextStyle(
                                  fontSize: subTitleSize,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Open_url(
                              url: widget.url,
                              text: widget.urlTitle,
                            ),
                            SizedBox(
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
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
            ]),
      ),
    );
  }
}
