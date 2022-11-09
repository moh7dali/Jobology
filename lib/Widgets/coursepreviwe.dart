// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'mytext.dart';
import '../Screens/Users/course.dart';

class Course_previwe extends StatefulWidget {
  Course_previwe(
      {this.imageUrl,
      this.company_name,
      this.title,
      this.breif,
      this.url,
      this.price,
      this.doc_id});
  String? company_name;
  String? title;
  String? imageUrl;
  String? breif;
  String? price;
  String? url;
  dynamic doc_id;

  @override
  State<Course_previwe> createState() => _Course_previweState();
}

class _Course_previweState extends State<Course_previwe> {
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
              top: 290,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                width: MediaQuery.of(context).size.width,
                height: height * 0.7,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.title!,
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        MyText(
                            text: "${widget.price}" + "\$",
                            size: 25,
                            mycolor: Colors.black12.withOpacity(0.7))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.blue,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        MyText(
                          text: "Amman-Jordan",
                          size: 16,
                          mycolor: Colors.blue.withOpacity(0.8),
                        )
                      ],
                    ),
                    const Divider(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(160, 158, 158, 158),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "About course:",
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
                          "Provider:",
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
                        widget.company_name!,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: height * 0.2, left: 130),
                        child: MaterialButton(
                          height: 60,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          color: Color.fromARGB(255, 74, 15, 84),
                          onPressed: () async {
                            String user_id =
                                FirebaseAuth.instance.currentUser!.uid;
                            await FirebaseFirestore.instance
                                .collection('Training')
                                .doc(widget.doc_id)
                                .update({
                              'Applied': FieldValue.arrayUnion([user_id])
                            });
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  actions: [Text("Applied")],
                                );
                              },
                            );
                          },
                          child: const Text(
                            "Apply To the Course",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        )),
                  ],
                ),
              ))
        ]),
      ),
    );
  }
}
