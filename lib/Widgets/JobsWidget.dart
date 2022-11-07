import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jobology/Widgets/open_url.dart';

class ListTaleW extends StatefulWidget {
  ListTaleW(
      {this.imageUrl,
      this.company_name,
      this.title,
      this.breif,
      this.url,
      this.years,
      this.req,
      this.docnid});
  String? company_name;
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

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
            title: Text(
              widget.company_name!.toUpperCase(),
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            content: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(160, 158, 158, 158),
                  ),
                  child: Text(
                    "Job title: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Text(
                  widget.title!,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(160, 158, 158, 158),
                  ),
                  child: Text(
                    "About job: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Text(
                  widget.breif!,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(160, 158, 158, 158),
                  ),
                  child: Text(
                    "Requirements: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Text(
                  widget.req!,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(160, 158, 158, 158),
                  ),
                  child: Text(
                    "Years of experience: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Text(
                  widget.years!,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              Column(
                children: [
                  Text(widget.title!),
                  Text(widget.breif!),
                  Text(widget.req!),
                  Text(widget.years!),
                  Open_url(
                    url: widget.url!,
                    text: "visit",
                  ),
                ],
              ),
            ],
          ),
        );
      },
      leading: Container(
        width: 80,
        height: 80,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image(
            image: NetworkImage(
              widget.imageUrl!,
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
        widget.company_name!,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        widget.title!,
        style: TextStyle(
          color: Color.fromARGB(255, 163, 167, 165),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
