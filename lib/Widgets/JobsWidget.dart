import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListTaleW extends StatefulWidget {
  ListTaleW(
      {required this.imageUrl,
      required this.title,
      required this.breif,
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

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(widget.title.toString()),
            actions: <Widget>[
              Column(
                children: [
                  Text(widget.breif!),
                  Text(widget.req!),
                  Text(widget.years!),
                  Text(widget.url!),
                  TextButton(
                    onPressed: () {},
                    child: Container(
                      color: Colors.green,
                      padding: const EdgeInsets.all(14),
                      child: Text("Visit"),
                    ),
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
        child: Image.asset(widget.imageUrl!),
      ),
      trailing: Icon(
        Icons.work,
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
