import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jobology/Screens/Authentication/Login.dart';

class personalInfo extends StatefulWidget {
  const personalInfo({super.key});

  @override
  State<personalInfo> createState() => _personalInfoState();
}

class _personalInfoState extends State<personalInfo> {
  Icon Icon1 = Icon(
    Icons.thumb_up,
    color: Colors.blue,
  );
  String username = "";
  String address = "";
  String phone = "";
  String major = "";
  String age = "";
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      setState(() {
        username = event['Fullname'];
      });
    });
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      setState(() {
        phone = event['phone'];
      });
    });
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      setState(() {
        major = event['major'];
      });
    });
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      setState(() {
        age = event['age'];
      });
    });
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      setState(() {
        address = event['address'];
      });
    });
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 410,
              height: 300,
              color: Colors.white,
              child: Stack(children: [
                Container(
                  width: 410,
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://www.incimages.com/uploaded_files/image/1920x1080/getty_509107562_2000133320009280346_351827.jpg"),
                        fit: BoxFit.cover),
                    // borderRadius: BorderRadius.only(
                    //     bottomLeft: Radius.circular(100),
                    //     bottomRight: Radius.circular(100))
                  ),
                ),
                Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: CircleAvatar(
                      radius: 50,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://pbs.twimg.com/profile_images/669103856106668033/UF3cgUk4_400x400.jpg"),
                            ),
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ))
              ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "editProfile");
                    },
                    icon: Icon(Icons.edit)),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    username,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      if (Icon1.toString() ==
                          (Icon(
                            Icons.thumb_up,
                            color: Colors.blue,
                          )).toString()) {
                        setState(() {
                          Icon1 = Icon(
                            Icons.thumb_down,
                            color: Colors.blue,
                          );
                        });
                      } else {
                        setState(() {
                          Icon1 = Icon(
                            Icons.thumb_up,
                            color: Colors.blue,
                          );
                        });
                      }
                    },
                    icon: Icon(Icon1.icon))
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "owner of amazon",
                style: TextStyle(fontWeight: FontWeight.w200, fontSize: 20),
              ),
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
                icon: Icon(FontAwesomeIcons.twitter),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(FontAwesomeIcons.instagram),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(FontAwesomeIcons.linkedin),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.facebook),
              ),
            ]),
            Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "About Me:",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
            Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                children: [
                  ListTile(
                    trailing: Icon(Icons.phone),
                    title: Text("Phone Number",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    subtitle: Text(
                      phone,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  ListTile(
                    trailing: Icon(FontAwesomeIcons.book),
                    title: Text("Major",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    subtitle: Text(
                      major,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  ListTile(
                    trailing: Icon(FontAwesomeIcons.locationArrow),
                    title: Text("address",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    subtitle: Text(
                      address,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  ListTile(
                    trailing: Icon(FontAwesomeIcons.person),
                    title: Text("Age",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    subtitle: Text(
                      age,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
      floatingActionButton: SpeedDial(
          buttonSize: Size(70, 70),
          spaceBetweenChildren: 15,
          child: Icon(
            Ionicons.menu,
            size: 30,
          ),
          backgroundColor: Color.fromARGB(255, 61, 14, 70),
          children: [
            SpeedDialChild(
              child: Icon(Icons.logout),
              label: 'Logout',
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Login();
                    },
                  ),
                );
              },
            ),
            SpeedDialChild(
              child: Icon(Ionicons.person),
              label: 'Profile',
              onTap: () {
                Navigator.pushNamed(context, "personalPage");
              },
            ),
            SpeedDialChild(
              child: Icon(Ionicons.home),
              label: 'Home',
              onTap: () {
                Navigator.pushNamed(context, "Home");
              },
            ),
          ]),
    );
  }
}
