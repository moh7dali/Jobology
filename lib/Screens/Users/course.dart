// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jobology/Screens/Authentication/Login.dart';
import 'package:jobology/Screens/Users/peronalPage/personalpage.dart';
import 'package:jobology/Widgets/coursepreviwe.dart';
import 'package:jobology/constants.dart';

class Course extends StatefulWidget {
  const Course({super.key});

  @override
  State<Course> createState() => _CourseState();
}

String username = "";
String img_url = "";
Stream s = FirebaseFirestore.instance
    .collection('Training')
    .orderBy('date', descending: true)
    .snapshots();

class _CourseState extends State<Course> with TickerProviderStateMixin {
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
                  "${username},",
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
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return personalInfo(
                    user_id: FirebaseAuth.instance.currentUser!.uid,
                  );
                },
              ));
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
        stream: s,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      setState(() {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Course_previwe(
                              imageUrl: docs[index]['img_url'],
                              company_name: docs[index]['Company_name'],
                              comp_id: docs[index]['comp_id'],
                              title: docs[index]['course_title'],
                              breif: docs[index]['breif'],
                              price: docs[index]['price'],
                              url: docs[index]['url'],
                              doc_id: docs[index].id,
                            );
                          },
                        ));
                      });
                    },
                    leading: SizedBox(
                      width: 80,
                      height: 80,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                          image: NetworkImage(
                            docs[index]['img_url']!,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      docs[index]['Company_name']!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: subTitleSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      docs[index]['course_title']!,
                      style: const TextStyle(
                        fontSize: ParagraphSize,
                        color: Color.fromARGB(255, 163, 167, 165),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
              child: const Icon(Icons.logout),
              label: 'Logout',
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Login();
                    },
                  ),
                );
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
                Navigator.popAndPushNamed(context, "Home");
              },
            ),
          ]),
    );
  }
}
