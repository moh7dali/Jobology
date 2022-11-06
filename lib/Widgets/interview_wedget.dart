import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:jobology/Screens/Users/interview.dart';

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
    Navigator.pushNamed(context, "jobInfo");
  }

  bool ispressd = true;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        setState(() {
          Navigator.pushNamed(context, "interview");
        });
      },
      leading: Container(
        width: 80,
        height: 80,
        child: Image.asset(widget.imageUrl!),
      ),
      trailing: Icon(
        Icons.school,
        color: Colors.blue,
      ),
      title: Text(
        widget.title!,
        style: TextStyle(color: Colors.blue),
      ),
      subtitle: Text(widget.breif!, style: TextStyle(color: Colors.green)),
    );
  }
}
