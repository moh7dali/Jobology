// Home page for companies
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jobology/Screens/Company/company_info.dart';
import 'package:jobology/constants.dart';
import 'package:jobology/Screens/Company/showInfo.dart';
import 'package:jobology/Screens/Company/update.dart';
import 'package:jobology/Screens/Company/updateTraining.dart';

class CompanyHome extends StatefulWidget {
  CompanyHome({Key? key}) : super(key: key);

  @override
  State<CompanyHome> createState() => _CompanyHomeState();
}

class _CompanyHomeState extends State<CompanyHome> {
  String comp_name = "";
  String img_url = "";
  Stream t = FirebaseFirestore.instance
      .collection('Training')
      .orderBy('date', descending: true)
      .snapshots();

  Stream s = FirebaseFirestore.instance
      .collection('Jobs')
      .orderBy('date', descending: true)
      .snapshots();
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
    return DefaultTabController(
      // length of TabBar = 2
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        backgroundColor: backgroud,
        //App bar
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
                  await FirebaseAuth.instance.signOut();
                  Navigator.popAndPushNamed(context, "Login");
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
          // TabBar we use preferedSize to wrap it with container
          bottom: PreferredSize(
            preferredSize: const Size(200, 70),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: containerBackgroun,
                  borderRadius: BorderRadius.circular(
                    20.0,
                  ),
                ),
                child: const TabBar(
                  indicatorColor: iconColor,
                  tabs: [
                    Center(
                      child: Text(
                        "jobs",
                        style: TextStyle(
                          fontSize: subTitleSize,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Training",
                        style: TextStyle(
                          fontSize: subTitleSize,
                        ),
                      ),
                    ),
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
              // stream builder to read data from firestore
              StreamBuilder(
                stream: s,
                builder: (context, snapshot) {
                  // if statement for loading page
                  if (snapshot.hasData) {
                    final docs = snapshot.data!.docs;
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          if (comp_name == docs[index]['Company name']) {
                            return ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image(
                                  fit: BoxFit.contain,
                                  image: NetworkImage(docs[index]['img_url']),
                                ),
                              ),
                              title: Text(
                                docs[index]['Company name']
                                    .toString()
                                    .toUpperCase(),
                                style: const TextStyle(
                                  fontSize: subTitleSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                docs[index]['job_title'],
                                style: const TextStyle(
                                  fontSize: ParagraphSize,
                                ),
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => CupertinoAlertDialog(
                                    title: Text(
                                      docs[index]['job_title']
                                          .toString()
                                          .toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: titleSize,
                                      ),
                                    ),
                                    content: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: containerBackgroun,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "About training:",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: subTitleSize,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            docs[index]['breif'],
                                            style: const TextStyle(
                                              fontSize: ParagraphSize,
                                            ),
                                            textAlign: TextAlign.justify,
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: containerBackgroun,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "Requirements:",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: subTitleSize,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            docs[index]['requirements'],
                                            style: const TextStyle(
                                              fontSize: ParagraphSize,
                                            ),
                                            textAlign: TextAlign.justify,
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: containerBackgroun,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "Years of experience:",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: subTitleSize,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            docs[index]['years'],
                                            style: const TextStyle(
                                              fontSize: ParagraphSize,
                                            ),
                                            textAlign: TextAlign.justify,
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: containerBackgroun,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "Link:",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: subTitleSize,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            docs[index]['url'],
                                            style: const TextStyle(
                                              fontSize: ParagraphSize,
                                            ),
                                            textAlign: TextAlign.justify,
                                          ),
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: buttonColor,
                                            ),
                                            onPressed: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return Show_info(
                                                      doc_id: docs[index].id,
                                                      type: "Jobs");
                                                },
                                              ));
                                            },
                                            child: const Text(
                                              "Show applicants",
                                              style: TextStyle(
                                                fontSize: subTitleSize,
                                                color: Colors.white,
                                              ),
                                            )),
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
                                                  imageUrl: docs[index]
                                                      ['img_url'],
                                                  docnid: docs[index].id,
                                                );
                                              },
                                            ));
                                          },
                                          child: const Text(
                                            'Edit',
                                            style: TextStyle(
                                              fontSize: subTitleSize,
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
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(
                                            fontSize: subTitleSize,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    const Text('No data avaible right now');
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
              StreamBuilder(
                stream: t,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final docs = snapshot.data!.docs;
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          if (comp_name == docs[index]['Company_name']) {
                            return ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image(
                                  fit: BoxFit.contain,
                                  image: NetworkImage(docs[index]['img_url']),
                                ),
                              ),
                              title: Text(
                                docs[index]['Company_name']
                                    .toString()
                                    .toUpperCase(),
                                style: const TextStyle(
                                  fontSize: subTitleSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                docs[index]['course_title'],
                                style: const TextStyle(
                                  fontSize: ParagraphSize,
                                ),
                              ),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CupertinoAlertDialog(
                                        title: Text(
                                          docs[index]['course_title']
                                              .toString()
                                              .toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: titleSize,
                                          ),
                                        ),
                                        content: Column(
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: containerBackgroun,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  "About training:",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: subTitleSize,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                docs[index]['breif'],
                                                style: const TextStyle(
                                                  fontSize: ParagraphSize,
                                                ),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: containerBackgroun,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Price:",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: subTitleSize,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                docs[index]['price'],
                                                style: const TextStyle(
                                                  fontSize: ParagraphSize,
                                                ),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: containerBackgroun,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Link:",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: subTitleSize,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                docs[index]['url'],
                                                style: const TextStyle(
                                                  fontSize: ParagraphSize,
                                                ),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: buttonColor,
                                                ),
                                                onPressed: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                    builder: (context) {
                                                      return Show_info(
                                                          doc_id:
                                                              docs[index].id,
                                                          type: "Training");
                                                    },
                                                  ));
                                                },
                                                child: const Text(
                                                  "Show applicants",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: subTitleSize,
                                                  ),
                                                ))
                                          ],
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
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
                                                      imageUrl: docs[index]
                                                          ['img_url'],
                                                      docnid: docs[index].id,
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                            child: const Text(
                                              'Edit',
                                              style: TextStyle(
                                                  fontSize: subTitleSize,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              FirebaseFirestore.instance
                                                  .collection('Training')
                                                  .doc(docs[index].id)
                                                  .delete();
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              'Delete',
                                              style: TextStyle(
                                                fontSize: subTitleSize,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              },
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    const Text('No data avaible right now');
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
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
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return Company_info(
                      user_id: FirebaseAuth.instance.currentUser!.uid,
                    );
                  },
                ));
              },
            ),
            SpeedDialChild(
              child: const Icon(
                Icons.shopping_bag,
              ),
              label: 'Add new job',
              onTap: () {
                Navigator.pushNamed(context, "addNewJob");
              },
            ),
            SpeedDialChild(
              child: const Icon(
                Ionicons.document_outline,
              ),
              label: 'Add new training',
              onTap: () {
                Navigator.pushNamed(context, "addNewTraining");
              },
            ),
          ],
          child: const Icon(Icons.menu),
        ),
      ),
    );
  }
}
