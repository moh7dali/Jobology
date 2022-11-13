// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

late Uri _url;

class Icon_Url extends StatefulWidget {
  Icon_Url({this.url, required this.icon});
  String? url;

  Icon? icon;
  @override
  State<Icon_Url> createState() => _Icon_UrlState();
}

class _Icon_UrlState extends State<Icon_Url> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          _url = Uri.parse('${widget.url}');
          Open();
        },
        icon: widget.icon!);
  }
}

Future<void> Open() async {
  if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $_url';
  }
}
