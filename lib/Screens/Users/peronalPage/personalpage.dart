import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jobology/Screens/Authentication/Login.dart';
import 'package:jobology/Screens/Users/peronalPage/editProfile.dart';

class personalInfo extends StatefulWidget {
  const personalInfo({super.key});

  @override
  State<personalInfo> createState() => _personalInfoState();
}

class _personalInfoState extends State<personalInfo> {
  Icon Icon1 = const Icon(
    Icons.thumb_up,
    color: Colors.blue,
  );
  String img_url = "";
  String username = "";
  String address = "";
  String phone = "";
  String major = "";
  String age = "";
  String bio = "";
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      setState(() {
        img_url = event['img'];
        bio = event['bio'];
        username = event['Fullname'];
        phone = event['phone'];
        major = event['major'];
        age = event['age'];
      });
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 35,
              ),
              CircleAvatar(
                radius: 100,
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(img_url),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return editProfile(
                              Fullname: username,
                              phone: phone,
                              address: address,
                              age: age,
                              major: major,
                              bio: bio);
                        }));
                      },
                      icon: const Icon(Icons.edit)),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      username,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (Icon1.toString() ==
                            (const Icon(
                              Icons.thumb_up,
                              color: Colors.blue,
                            )).toString()) {
                          setState(() {
                            Icon1 = const Icon(
                              Icons.thumb_down,
                              color: Colors.blue,
                            );
                          });
                        } else {
                          setState(() {
                            Icon1 = const Icon(
                              Icons.thumb_up,
                              color: Colors.blue,
                            );
                          });
                        }
                      },
                      icon: Icon(Icon1.icon))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  bio,
                  style: GoogleFonts.poppins(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Accounts:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  )),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(FontAwesomeIcons.twitter),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(FontAwesomeIcons.instagram),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(FontAwesomeIcons.linkedin),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.facebook),
                ),
              ]),
              const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "About Me:",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  children: [
                    ListTile(
                      trailing: const Icon(Icons.phone),
                      title: const Text("Phone Number",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      subtitle: Text(
                        phone,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    ListTile(
                      trailing: const Icon(FontAwesomeIcons.book),
                      title: const Text("Major",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      subtitle: Text(
                        major,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    ListTile(
                      trailing: const Icon(FontAwesomeIcons.locationArrow),
                      title: const Text("address",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      subtitle: Text(
                        address,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    ListTile(
                      trailing: const Icon(FontAwesomeIcons.person),
                      title: const Text("Age",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      subtitle: Text(
                        age,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
          buttonSize: const Size(70, 70),
          spaceBetweenChildren: 15,
          backgroundColor: const Color.fromARGB(255, 61, 14, 70),
          children: [
            SpeedDialChild(
              child: const Icon(Icons.logout),
              label: 'Logout',
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const Login();
                    },
                  ),
                );
              },
            ),
            SpeedDialChild(
              child: const Icon(Ionicons.person),
              label: 'Profile',
              onTap: () {
                Navigator.pushNamed(context, "personalPage");
              },
            ),
            SpeedDialChild(
              child: const Icon(Ionicons.home),
              label: 'Home',
              onTap: () {
                Navigator.pushNamed(context, "Home");
              },
            ),
          ],
          child: Icon(
            Ionicons.menu,
            size: 30,
          )),
    );
  }
}
