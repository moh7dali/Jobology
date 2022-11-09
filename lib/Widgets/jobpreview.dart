// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jobology/Widgets/open_url.dart';

import 'mytext.dart';
import '../Screens/Users/course.dart';

class job_previwe extends StatefulWidget {
  job_previwe(
      {this.imageUrl,
      this.company_name,
      this.title,
      this.breif,
      this.url,
      this.years,
      this.req,
      this.doc_id});
  String? company_name;
  String? title;
  String? imageUrl;
  String? breif;
  String? req;
  String? years;
  String? url;
  dynamic doc_id;

  @override
  State<job_previwe> createState() => _job_previweState();
}

class _job_previweState extends State<job_previwe> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.infinity,
        child: Stack(children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: 320,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.imageUrl!), fit: BoxFit.cover),
                ),
              )),
          Positioned(
            top: 30,
            left: 15,
            child: Container(
                child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Ionicons.chevron_back_outline,
                size: 35,
                color: Colors.white,
              ),
            )),
          ),
          Positioned(
              top: 300,
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
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      MyText(
                        text: widget.company_name!,
                        size: 40,
                        mycolor: Colors.black54.withOpacity(0.9),
                      ),
                      const Divider(
                        height: 15,
                        thickness: 2,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(160, 158, 158, 158),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "Job title: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          widget.title!,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(160, 158, 158, 158),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "About job ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          widget.breif!,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(160, 158, 158, 158),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "Requirements: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          widget.req!,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(160, 158, 158, 158),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "Years of experience: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          widget.years!,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      MaterialButton(
                        height: 60,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        color: Color.fromARGB(255, 74, 15, 84),
                        onPressed: () async {
                          String user_id =
                              FirebaseAuth.instance.currentUser!.uid;
                          await FirebaseFirestore.instance
                              .collection('Jobs')
                              .doc(widget.doc_id)
                              .update({
                            'Applied': FieldValue.arrayUnion([user_id])
                          });
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                actions: [Center(child: Text("Applied"))],
                              );
                            },
                          );
                        },
                        child: const Text(
                          "Apply To the Job",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                ),
              ))
        ]),
      ),
    );
  }
}
