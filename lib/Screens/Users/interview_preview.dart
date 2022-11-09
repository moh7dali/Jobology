import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jobology/Screens/Authentication/Login.dart';
import 'package:jobology/Screens/Users/peronalPage/personalpage.dart';
// import 'package:jobology/Widgets/JobsWidget.dart';
import 'package:jobology/Widgets/interview_wedget.dart';

class Interviwe_Preview extends StatefulWidget {
  const Interviwe_Preview({super.key});

  @override
  State<Interviwe_Preview> createState() => _Interviwe_PreviewState();
}

String username = "";
String img_url = "";

class _Interviwe_PreviewState extends State<Interviwe_Preview> {
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
               Navigator.push(context, MaterialPageRoute(builder: (context) {
                return personalInfo(user_id: FirebaseAuth.instance.currentUser!.uid,);
              },));
              
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('interview').snapshots(),
        builder: (context, snapshot) {
          final docs = snapshot.data!.docs;
          return Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: docs.length,
              itemBuilder: (context, index) {
                return ListTaleW(
                  imageUrl: "images/aspaire.png",
                  title: docs[index]['title'],
                  breif: docs[index]['breif'],
                );
              },
            ),
          );
        },
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
                Navigator.popAndPushNamed(
                  context,
               "Login"
                );
              },
            ),
            SpeedDialChild(
              child: Icon(Ionicons.person),
              label: 'Profile',
              onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) {
                return personalInfo(user_id: FirebaseAuth.instance.currentUser!.uid,);
              },));
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
