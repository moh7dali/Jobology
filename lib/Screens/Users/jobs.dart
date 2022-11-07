import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jobology/Screens/Authentication/Login.dart';
import 'package:jobology/Widgets/jobpreview.dart';

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
              child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        setState(() {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return job_previwe(
                                imageUrl: docs[index]['img_url'],
                                company_name: docs[index]['Company name'],
                                title: docs[index]['job_title'],
                                breif: docs[index]['breif'],
                                req: docs[index]['requirements'],
                                years: docs[index]['years'],
                                url: docs[index]['url'],
                              );
                            },
                          ));
                        });
                        // showDialog(
                        //   context: context,
                        //   builder: (ctx) => CupertinoAlertDialog(
                        //     title: Text(
                        //       widget.company_name!.toUpperCase(),
                        //       style: TextStyle(
                        //         fontSize: 25,
                        //       ),
                        //     ),
                        //     content: Column(
                        //       children: [
                        //         SizedBox(
                        //           height: 15,
                        //         ),
                        //         Container(
                        //           width: double.infinity,
                        //           decoration: BoxDecoration(
                        //             color: Color.fromARGB(160, 158, 158, 158),
                        //           ),
                        //           child: Text(
                        //             "Job title: ",
                        //             style: TextStyle(
                        //               fontWeight: FontWeight.bold,
                        //               fontSize: 15,
                        //             ),
                        //           ),
                        //         ),
                        //         Text(
                        //           widget.title!,
                        //           style: TextStyle(
                        //             fontSize: 15,
                        //           ),
                        //         ),
                        //         Container(
                        //           width: double.infinity,
                        //           decoration: BoxDecoration(
                        //             color: Color.fromARGB(160, 158, 158, 158),
                        //           ),
                        //           child: Text(
                        //             "About job: ",
                        //             style: TextStyle(
                        //               fontWeight: FontWeight.bold,
                        //               fontSize: 15,
                        //             ),
                        //           ),
                        //         ),
                        //         Text(
                        //           widget.breif!,
                        //           style: TextStyle(
                        //             fontSize: 15,
                        //           ),
                        //         ),
                        //         Container(
                        //           width: double.infinity,
                        //           decoration: BoxDecoration(
                        //             color: Color.fromARGB(160, 158, 158, 158),
                        //           ),
                        //           child: Text(
                        //             "Requirements: ",
                        //             style: TextStyle(
                        //               fontWeight: FontWeight.bold,
                        //               fontSize: 15,
                        //             ),
                        //           ),
                        //         ),
                        //         Text(
                        //           widget.req!,
                        //           style: TextStyle(
                        //             fontSize: 15,
                        //           ),
                        //         ),
                        //         Container(
                        //           width: double.infinity,
                        //           decoration: BoxDecoration(
                        //             color: Color.fromARGB(160, 158, 158, 158),
                        //           ),
                        //           child: Text(
                        //             "Years of experience: ",
                        //             style: TextStyle(
                        //               fontWeight: FontWeight.bold,
                        //               fontSize: 15,
                        //             ),
                        //           ),
                        //         ),
                        //         Text(
                        //           widget.years!,
                        //           style: TextStyle(
                        //             fontSize: 15,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //     actions: <Widget>[
                        //       Column(
                        //         children: [
                        //           Text(widget.title!),
                        //           Text(widget.breif!),
                        //           Text(widget.req!),
                        //           Text(widget.years!),
                        //           Open_url(
                        //             url: widget.url!,
                        //             text: "visit",
                        //           ),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // );
                      },
                      leading: Container(
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
                      // trailing: Icon(
                      //   Icons.work,
                      //   color: Colors.black,
                      // ),
                      title: Text(
                        docs[index]['Company name']!,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        docs[index]['job_title']!,
                        style: TextStyle(
                          color: Color.fromARGB(255, 163, 167, 165),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                    //  ListTaleW(
                    //   imageUrl: docs[index]['img_url'],
                    //   company_name: docs[index]['Company name'],
                    //   title: docs[index]['job_title'],
                    //   breif: docs[index]['breif'],
                    //   req: docs[index]['requirements'],
                    //   years: docs[index]['years'],
                    //   url: docs[index]['url'],
                    // );
                  }));
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
              child: Icon(Ionicons.person),
              label: 'Profile',
              onTap: () {
                Navigator.pushNamed(context, "personalPage");
              },
            ),
            SpeedDialChild(
              child: Icon(Ionicons.home),
              label: 'Home',
              onTap: () {
                Navigator.pushNamed(context, "Home");
              },
            ),
          ]),
    );
  }
}
