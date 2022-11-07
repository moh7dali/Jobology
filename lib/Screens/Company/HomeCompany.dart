import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jobology/Screens/Company/update.dart';
import 'package:jobology/Screens/Company/updateTraining.dart';

import '../Authentication/Login.dart';

class CompanyHome extends StatefulWidget {
  CompanyHome({Key? key}) : super(key: key);

  @override
  State<CompanyHome> createState() => _CompanyHomeState();
}

String username = "";

class _CompanyHomeState extends State<CompanyHome> {
  String comp_name = "";

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      setState(() {
        comp_name = event['Fullname'];
      });
    });
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
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
                    comp_name,
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
            ],
          ),
          centerTitle: true,
          actions: [
            Image.asset(
              "images/user.png",
              width: 50,
            ),
            SizedBox(
              width: 15,
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size(200, 70),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                ),
                child: TabBar(
                  indicatorColor: Color.fromARGB(255, 59, 4, 87),
                  tabs: [
                    Center(
                      child: Text(
                        "jobs",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Training",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: TabBarView(
            children: [
              StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('Jobs').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  final docs = snapshot.data!.docs;
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 7,
                      ),
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        if (comp_name == docs[index]['Company name']) {
                          return Container(
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(docs[index]['img_url']),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: ListTile(
                              title: Text(
                                docs[index]['Company name'],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                docs[index]['job_title'],
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => CupertinoAlertDialog(
                                    title: Text(
                                      docs[index]['job_title'],
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                    content: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          decoration:
                                              BoxDecoration(color: Colors.grey),
                                          child: Text(
                                            "About training:",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          docs[index]['breif'],
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          decoration:
                                              BoxDecoration(color: Colors.grey),
                                          child: Text(
                                            "Requirements:",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          docs[index]['requirements'],
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          decoration:
                                              BoxDecoration(color: Colors.grey),
                                          child: Text(
                                            "Years of experience:",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          docs[index]['years'],
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          decoration:
                                              BoxDecoration(color: Colors.grey),
                                          child: Text(
                                            "Link:",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          docs[index]['url'],
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return Update_job(
                                                  title: docs[index]
                                                      ['job_title'],
                                                  breif: docs[index]['breif'],
                                                  req: docs[index]
                                                      ['requirements'],
                                                  years: docs[index]['years'],
                                                  url: docs[index]['url'],
                                                  docnid: docs[index].id,
                                                );
                                              },
                                            ));
                                          },
                                          child: Text(
                                            'Edit',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          )),
                                      TextButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection('Jobs')
                                              .doc(docs[index].id)
                                              .delete();
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Delete',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        } else
                          return Container();
                      },
                    ),
                  );
                },
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Training')
                    .snapshots(),
                builder: (context, snapshot) {
                  final docs = snapshot.data!.docs;
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 7,
                      ),
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        if (comp_name == docs[index]['Company_name']) {
                          return Container(
                            height: 200,
                            decoration: BoxDecoration(
                              //color: Color.fromARGB(255, 223, 210, 230),
                              image: DecorationImage(
                                  image: NetworkImage(docs[index]['img_url']),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: ListTile(
                              title: Text(
                                docs[index]['Company_name'],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                docs[index]['course_title'],
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CupertinoAlertDialog(
                                        title: Text(
                                          docs[index]['course_title'],
                                          style: TextStyle(fontSize: 25),
                                        ),
                                        content: Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey),
                                              child: Text(
                                                "About training:",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              docs[index]['breif'],
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey),
                                              child: Text(
                                                "Price:",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              docs[index]['price'],
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey),
                                              child: Text(
                                                "Link:",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              docs[index]['url'],
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                              onPressed: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                  builder: (context) {
                                                    return Update_training(
                                                      title: docs[index]
                                                          ['course_title'],
                                                      breif: docs[index]
                                                          ['breif'],
                                                      price: docs[index]
                                                          ['price'],
                                                      url: docs[index]['url'],
                                                      docnid: docs[index].id,
                                                    );
                                                  },
                                                ));
                                              },
                                              child: Text(
                                                'Edit',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              )),
                                          TextButton(
                                            onPressed: () {
                                              FirebaseFirestore.instance
                                                  .collection('Training')
                                                  .doc(docs[index].id)
                                                  .delete();
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Delete',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    });
                              },
                            ),
                          );
                        } else
                          return Container();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: SpeedDial(
            spaceBetweenChildren: 15,
            buttonSize: Size(70, 70),
            child: Icon(Icons.menu),
            backgroundColor: Color.fromARGB(255, 61, 14, 70),
            children: [
              SpeedDialChild(
                child: Icon(Ionicons.log_out),
                label: 'Logout',
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamed(context, "Login");
                },
              ),
              SpeedDialChild(
                child: Icon(Ionicons.person),
                label: 'profile',
                onTap: () {},
              ),
              SpeedDialChild(
                child: Icon(Icons.shopping_bag),
                label: 'Add new job',
                onTap: () {
                  Navigator.pushNamed(context, "addNewPage");
                },
              ),
              SpeedDialChild(
                child: Icon(Ionicons.document_outline),
                label: 'Add new training',
                onTap: () {
                  Navigator.pushNamed(context, "addNewTraining");
                },
              ),
            ]),
      ),
    );
  }
}
