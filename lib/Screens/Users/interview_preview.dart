import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jobology/Screens/Authentication/Login.dart';
import 'package:jobology/Screens/Users/Home.dart';
import 'package:jobology/Screens/Users/peronalPage/personalpage.dart';
// import 'package:jobology/Widgets/JobsWidget.dart';
import 'package:jobology/Widgets/interview_wedget.dart';
import 'package:jobology/constants.dart';

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ignore: prefer_const_constructors
                Text(
                  "Welcome",
                  style: const TextStyle(
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('interview').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  return ListTaleW(
                    imageUrl: docs[index]['img'],
                    title: docs[index]['title'],
                    breif: docs[index]['breif'],
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            const Text('No data avaible right now');
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: SpeedDial(
          buttonSize: const Size(70, 70),
          spaceBetweenChildren: 15,
          child: const Icon(
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
              child: const Icon(Ionicons.person),
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
              child: const Icon(Ionicons.home),
              label: 'Home',
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ]),
    );
  }
}
