// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

late Uri _url;

class Open_url extends StatefulWidget {
  Open_url({this.url, this.text});
  String? url;
  String? text;
  @override
  State<Open_url> createState() => _Open_urlState();
}

class _Open_urlState extends State<Open_url> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _url = Uri.parse('${widget.url}');
          Open();
        },
        child: Text(
          "${widget.text}",
          style: TextStyle(
              fontSize: 24, color: Colors.blue, fontWeight: FontWeight.bold),
        ));
  }
}

Future<void> Open() async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}
