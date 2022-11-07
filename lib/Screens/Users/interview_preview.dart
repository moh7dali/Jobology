import 'package:firebase_auth/firebase_auth.dart';
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
