// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jobology/constants.dart';
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
    return Container(
      child: GestureDetector(
        onTap: () {
          _url = Uri.parse('${widget.url}');
          Open();
        },
        child: Text(
          "${widget.text}",
          style: TextStyle(
              fontSize: subTitleSize,
              color: Colors.black,
              decoration: TextDecoration.underline),
        ),
      ),
    );
  }
}

Future<void> Open() async {
  if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $_url';
  }
}
