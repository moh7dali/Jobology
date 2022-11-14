// ignore_for_file: camel_case_types
import 'package:flutter/cupertino.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jobology/Screens/Company/company_info.dart';
import 'package:jobology/Screens/Users/peronalPage/personalpage.dart';
import 'package:jobology/Widgets/open_url.dart';
import 'package:jobology/constants.dart';
import 'mytext.dart';

class Course_previwe extends StatefulWidget {
  Course_previwe(
      {this.imageUrl,
      this.company_name,
      this.comp_id,
      this.title,
      this.breif,
      this.url,
      this.price,
      this.doc_id});
  String? company_name;
  String? comp_id;
  String? title;
  String? imageUrl;
  String? breif;
  String? price;
  String? url;
  dynamic doc_id;

  @override
  State<Course_previwe> createState() => _Course_previweState();
}

class _Course_previweState extends State<Course_previwe> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: double.maxFinite,
                  height: 320,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.imageUrl!),
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            Positioned(
              top: 30,
              left: 15,
              child: Container(
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Ionicons.arrow_back,
                    color: Colors.black,
                    size: 35,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 290,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                width: MediaQuery.of(context).size.width,
                height: height * 0.7,
                decoration: const BoxDecoration(
                    color: backgroud,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${widget.title!.toString().toUpperCase()}",
                                  style: const TextStyle(
                                      fontSize: titleSize,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return Company_info(
                                          user_id: widget.comp_id,
                                        );
                                      },
                                    ));
                                  },
                                  child: const Icon(
                                    Icons.info,
                                    color: buttonColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      MyText(
                          text: "${widget.price}" + "\$",
                          size: 25,
                          mycolor: Colors.black12.withOpacity(0.7)),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.blue,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          MyText(
                            text: "Amman-Jordan",
                            size: 16,
                            mycolor: Colors.blue.withOpacity(0.8),
                          )
                        ],
                      ),
                      const Divider(
                        height: 15,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: containerBackgroun,
                            borderRadius: BorderRadius.circular(15)),
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "About course:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: subTitleSize,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          widget.breif!,
                          style: const TextStyle(
                            fontSize: subTitleSize,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: containerBackgroun,
                            borderRadius: BorderRadius.circular(15)),
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Provider:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: subTitleSize,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          widget.company_name!,
                          style: const TextStyle(
                            fontSize: subTitleSize,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            const Icon(Ionicons.link_outline),
                            const SizedBox(
                              width: 10,
                            ),
                            Open_url(
                                url: widget.url!, text: "Visit the website"),
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: MaterialButton(
                              height: 60,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              color: buttonColor,
                              onPressed: () async {
                                String user_id =
                                    FirebaseAuth.instance.currentUser!.uid;
                                await FirebaseFirestore.instance
                                    .collection('Training')
                                    .doc(widget.doc_id)
                                    .update({
                                  'Applied': FieldValue.arrayUnion([user_id])
                                });
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoAlertDialog(
                                      content: Column(
                                        children: const [
                                          Text(
                                            "Applied Successfully!",
                                            style: TextStyle(
                                              fontSize: subTitleSize,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "We will contact you soon..",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 96, 96, 96),
                                              fontSize: ParagraphSize,
                                            ),
                                          )
                                        ],
                                      ),
                                      actions: [
                                        MaterialButton(
                                          onPressed: () {
                                            Navigator.pop(context, "course");
                                          },
                                          child: const Text(
                                            "Done",
                                            style: TextStyle(
                                              fontSize: subTitleSize,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Text(
                                "Apply now",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
          buttonSize: const Size(70, 70),
          spaceBetweenChildren: 15,
          child: const Icon(
            Ionicons.menu,
            size: 30,
          ),
          backgroundColor: buttonColor,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.logout),
              label: 'Logout',
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.popAndPushNamed(context, "Login");
              },
            ),
            SpeedDialChild(
              child: Icon(Ionicons.person),
              label: 'Profile',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return personalInfo(
                      user_id: FirebaseAuth.instance.currentUser!.uid,
                    );
                  },
                ));
              },
            ),
          ]),
    );
  }
}
