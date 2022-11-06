import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobology/Screens/buttonnav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jobology/Widgets/JobsWidget.dart';

class jobs extends StatefulWidget {
  const jobs({super.key});

  @override
  State<jobs> createState() => _jobsState();
}

String username = "";

class _jobsState extends State<jobs> {
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
              child: Image.asset(
                "images/user.png",
                width: 50,
              ),
            ),
            SizedBox(
              width: 15,
            ),
          ],
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Jobs').snapshots(),
            builder: (context, snapshot) {
              final docs = snapshot.data!.docs;
              return Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        return ListTaleW(
                          imageUrl: "images/aspaire.png",
                          company_name: docs[index]['Company name'],
                          title: docs[index]['job_title'],
                          breif: docs[index]['breif'],
                          req: docs[index]['requirements'],
                          years: docs[index]['years'],
                          url: docs[index]['url'],
                        );
                      }));
            }));
  }
}
