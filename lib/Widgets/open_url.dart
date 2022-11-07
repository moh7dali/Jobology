import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

late Uri _url;

class Open_url extends StatefulWidget {
  Open_url({this.url});
  String? url;
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
        child: Container(
            color: Colors.green,
            padding: const EdgeInsets.all(14),
            child: Text("Visit")));
  }
}

Future<void> Open() async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}