// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobology/Screens/Authentication/Login.dart';
import 'package:jobology/Screens/Company/HomeCompany.dart';
import 'package:jobology/Screens/Users/Home.dart';
import 'package:jobology/Screens/start.dart';

class Check extends StatefulWidget {
  const Check({super.key});

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  String type = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              FirebaseFirestore.instance
                  .collection('Users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots()
                  .listen((event) {
                setState(() {
                  type = event['rules'];
                });
              });

              if (type == "User") {
                return Home();
              } else if (type == "company") {
                return CompanyHome();
              }
              return Center(child: CircularProgressIndicator());
            } else {
              return Start_page();
            }
          }),
    );
  }
}
