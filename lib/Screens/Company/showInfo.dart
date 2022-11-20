// This page to show the applicants to certin job or courses
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jobology/Screens/Users/peronalPage/personalpage.dart';
import 'package:jobology/constants.dart';

class Show_info extends StatefulWidget {
  Show_info({this.doc_id, this.type});
  String? doc_id;
  String? type;
  @override
  State<Show_info> createState() => _Show_infoState();
}

class _Show_infoState extends State<Show_info> {
  List Applied = [];
  String comp_name = "";
  String img_url = "";
  Stream s = FirebaseFirestore.instance.collection('Users').snapshots();
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      setState(() {
        comp_name = event['Fullname'];
        img_url = event['img'];
      });
    });
    if (widget.type == "Training") {
      FirebaseFirestore.instance
          .collection('Training')
          .doc(widget.doc_id)
          .snapshots()
          .listen((event) {
        setState(() {
          Applied = event['Applied'];
        });
      });
    } else if (widget.type == "Jobs") {
      FirebaseFirestore.instance
          .collection('Jobs')
          .doc(widget.doc_id)
          .snapshots()
          .listen((event) {
        setState(() {
          Applied = event['Applied'];
        });
      });
    }
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
              onPressed: () {
                Navigator.pushNamed(context, "companyHome");
              }),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Welcome",
                  style: TextStyle(
                    color: Color.fromARGB(255, 153, 152, 152),
                    fontSize: subTitleSize,
                  ),
                ),
                Text(
                  "$comp_name ,",
                  style: const TextStyle(color: Colors.black),
                )
              ],
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(img_url),
          ),
          const SizedBox(
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
                  for (int i = 0; i < Applied.length; i++) {
                    if (docs[index].id == Applied[i]) {
                      return ListTile(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return personalInfo(
                                user_id: Applied[i],
                              );
                            },
                          ));
                        },
                        title: Text(
                          docs[index]['Fullname'],
                          style: const TextStyle(
                            fontSize: subTitleSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          docs[index]['major'],
                          style: const TextStyle(
                            fontSize: ParagraphSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(
                            docs[index]['img'],
                          ),
                        ),
                      );
                    }
                  }
                  return Container();
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
          spaceBetweenChildren: 15,
          buttonSize: const Size(70, 70),
          backgroundColor: buttonColor,
          children: [
            SpeedDialChild(
              child: const Icon(
                Ionicons.log_out,
              ),
              label: 'Logout',
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, "Login");
              },
            ),
            SpeedDialChild(
              child: const Icon(
                Ionicons.person,
              ),
              label: 'profile',
              onTap: () {},
            ),
            SpeedDialChild(
              child: const Icon(
                Icons.home,
              ),
              label: 'Home',
              onTap: () {
                Navigator.pushNamed(context, "companyHome");
              },
            ),
          ],
          child: const Icon(Icons.menu)),
    );
  }
}
