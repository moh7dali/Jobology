// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:jobology/Screens/Users/interview.dart';
import 'package:jobology/Widgets/questin_wedget.dart';

class ListTaleW extends StatefulWidget {
  ListTaleW(
      {this.imageUrl,
      this.title,
      this.breif,
      this.url,
      this.years,
      this.req,
      this.docnid});
  String? title;
  String? imageUrl;
  String? breif;
  String? req;
  String? years;
  String? url;
  dynamic docnid;
  @override
  State<ListTaleW> createState() => _ListTaleWState();
}

class _ListTaleWState extends State<ListTaleW> {
  void nav() {
    if (widget.title! == "flutter") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  InterView(questionList: getFlutterQuestions())));
    }
    if (widget.title! == "asp") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  InterView(questionList: getAspQuestions())));
    }
    if (widget.title! == "js") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => InterView(questionList: getJsQuestions())));
    }
    if (widget.title! == "php") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  InterView(questionList: getPhpQuestions())));
    } else {
      return;
    }
  }

  bool ispressd = true;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        setState(() {
          nav();
        });
      },
      leading: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            widget.imageUrl!,
            fit: BoxFit.contain,
          )),
      title: Text(
        widget.title!,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        widget.breif!,
        style: TextStyle(
          color: Color.fromARGB(255, 163, 167, 165),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
