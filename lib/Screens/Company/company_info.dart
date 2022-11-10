import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jobology/Screens/Company/EditCompanyinfo.dart';
import 'package:jobology/Widgets/iconUrl.dart';
import 'package:jobology/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Company_info extends StatefulWidget {
  Company_info({this.user_id});
  String? user_id;

  @override
  State<Company_info> createState() => _Company_infoState();
}

class _Company_infoState extends State<Company_info> {
  Icon Icon1 = const Icon(
    Icons.thumb_up,
    color: Colors.blue,
  );
  String img_url = "";
  String username = "";
  String address = "";
  String phone = "";
  String email = "";
  String Facebook = "";
  String LinkedIn = "";
  String info = "";
  bool visibilty = false;
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.user_id)
        .snapshots()
        .listen((event) {
      setState(() {
        img_url = event['img'];
        username = event['Fullname'];
        phone = event['phone'];
        address = event['address'];
        email = event['Email'];
        Facebook = event['facebookurl'];
        LinkedIn = event['linkedinurl'];
        info = event["info"];
      });
    });
    if (widget.user_id == FirebaseAuth.instance.currentUser!.uid) {
      setState(() {
        visibilty = true;
      });
    }

    return Scaffold(
      backgroundColor: backgroud,
      appBar: AppBar(
        backgroundColor: backgroud,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Ionicons.chevron_back,
            size: 30,
          ),
          color: Colors.black,
        ),
        actions: [
          Visibility(
            visible: visibilty,
            child: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return EditCompanyInfo(
                    Fullname: username,
                    address: address,
                    img_url: img_url,
                    linkedin: LinkedIn,
                    phone: phone,
                    info: info,
                  );
                }));
              },
              icon: const Icon(Icons.edit),
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(img_url),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  username,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: titleSize,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Ionicons.call_sharp,
                        color: Color.fromARGB(255, 0, 0, 0),
                        size: 25,
                      ),
                      onPressed: () => launch("tel://$phone"),
                    ),
                    const Text(
                      "|",
                      style: TextStyle(
                        color: Color.fromARGB(158, 204, 203, 203),
                        fontSize: 40,
                      ),
                    ),
                    Icon_Url(
                      icon: const Icon(FontAwesomeIcons.linkedin),
                      url: LinkedIn,
                    ),
                    const Text(
                      "|",
                      style: TextStyle(
                        color: Color.fromARGB(158, 204, 203, 203),
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: containerBackgroun,
                  ),
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "TOP SKILLS",
                      style: TextStyle(
                        color: containerBackgroun,
                        fontSize: subTitleSize,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: containerBackgroun,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Address",
                      style: TextStyle(
                        color: containerBackgroun,
                        fontSize: subTitleSize,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    address,
                    style: const TextStyle(fontSize: subTitleSize),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: containerBackgroun,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Major",
                      style: TextStyle(
                        color: containerBackgroun,
                        fontSize: subTitleSize,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: visibilty,
        child: SpeedDial(
            buttonSize: Size(70, 70),
            spaceBetweenChildren: 15,
            child: Icon(
              Ionicons.menu,
              size: 30,
            ),
            backgroundColor: buttonColor,
            children: [
              SpeedDialChild(
                child: Icon(Icons.logout),
                label: 'Logout',
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.popAndPushNamed(context, "Login");
                },
              ),
              SpeedDialChild(
                child: Icon(Ionicons.home),
                label: 'Home',
                onTap: () {
                  Navigator.popAndPushNamed(context, "companyHome");
                },
              ),
            ]),
      ),
    );
  }
}
