// ignore_for_file: camel_case_types, library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../Screens/coursepreviwe.dart';

class Programming_list extends StatefulWidget {
  const Programming_list({super.key});

  @override
  _Programming_listState createState() => _Programming_listState();
}

class _Programming_listState extends State<Programming_list> {
  List<String> myimg = [
    "images/flutter.png",
    "images/js2.png",
    "images/asp2.webp"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return Course_previwe();
                  },
                ));
              });
            },
            child: Container(
              margin: const EdgeInsets.only(
                  top: 15, right: 10, left: 10, bottom: 10),
              width: double.maxFinite,
              height: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      image: AssetImage(myimg[index]), fit: BoxFit.cover)),
            ),
          );
        },
      ),
    );
  }
}

class Network_list extends StatefulWidget {
  const Network_list({super.key});

  @override
  State<Network_list> createState() => _Network_listState();
}

class _Network_listState extends State<Network_list> {
  List<String> myimg = [
    "images/flutter.png",
    "images/js2.png",
    "images/asp2.webp"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return Course_previwe();
                  },
                ));
              });
            },
            child: Container(
              margin: const EdgeInsets.only(
                  top: 15, right: 10, left: 10, bottom: 10),
              width: double.maxFinite,
              height: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      image: AssetImage(myimg[index]), fit: BoxFit.cover)),
            ),
          );
        },
      ),
    );
  }
}

class QA_list extends StatefulWidget {
  const QA_list({super.key});

  @override
  State<QA_list> createState() => _QA_listState();
}

class _QA_listState extends State<QA_list> {
  List<String> myimg = [
    "images/flutter.png",
    "images/js2.png",
    "images/asp2.webp"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return Course_previwe();
                  },
                ));
              });
            },
            child: Container(
              margin: const EdgeInsets.only(
                  top: 15, right: 10, left: 10, bottom: 10),
              width: double.maxFinite,
              height: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      image: AssetImage(myimg[index]), fit: BoxFit.cover)),
            ),
          );
        },
      ),
    );
  }
}
