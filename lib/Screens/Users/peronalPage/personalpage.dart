import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jobology/Screens/Users/peronalPage/editProfile.dart';
import 'package:jobology/Widgets/iconUrl.dart';
import 'package:jobology/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class personalInfo extends StatefulWidget {
  personalInfo({this.user_id});
  String? user_id;
  @override
  State<personalInfo> createState() => _personalInfoState();
}

class _personalInfoState extends State<personalInfo> {
  
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> getlocation() async {
    _determinePosition();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
     latitude = position.latitude;
     longtude = position.longitude;
    print(latitude);
    print(longtude);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude!, longtude!);

    setState(() {
      Location1 =
          "${(placemarks[0].country).toString()} ,${(placemarks[0].administrativeArea).toString()}";
      print(Location1);
    });
  }
double? latitude;
  double? longtude;
  String Location1 = "";
  Icon Icon1 = const Icon(
    Icons.thumb_up,
    color: Colors.blue,
  );
  String img_url = "";
  String email = "";
  String username = "";
  String address = "";
  String phone = "";
  String major = "";
  String age = "";
  String bio = "";
  String github = "";
  String LinkedIn = "";
  String cv = "";
  List Skills = [];
  bool visibilty = false;
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.user_id)
        .snapshots()
        .listen((event) {
      setState(() {
        email = event['Email'];
        img_url = event['img'];
        bio = event['bio'];
        username = event['Fullname'];
        phone = event['phone'];
        address = event['address'];
        major = event['major'];
        age = event['age'];
        github = event['Githuburl'];
        LinkedIn = event['linkedinurl'];
        Skills = event["skills"];
        cv = event["cv"];
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
            Ionicons.arrow_back,
            color: Colors.black,
            size: 35,
          ),
        ),
        actions: [
          Visibility(
            visible: visibilty,
            child: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return editProfile(
                      img_url: img_url,
                      Fullname: username,
                      phone: phone,
                      address: address,
                      age: age,
                      major: major,
                      bio: bio,
                      github: github,
                      linkedin: LinkedIn,
                      ChoosenSkills: Skills,
                      cv: cv);
                }));
              },
              icon: const Icon(
                Icons.edit,
                size: 30,
              ),
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
              Center(
                child: Text(
                  bio,
                  style: const TextStyle(
                    fontSize: subTitleSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                    Icon_Url(
                      icon: const Icon(FontAwesomeIcons.github),
                      url: github,
                    ),
                    const Text(
                      "|",
                      style: TextStyle(
                        color: Color.fromARGB(158, 204, 203, 203),
                        fontSize: 40,
                      ),
                    ),
                    Icon_Url(
                      icon: const Icon(Ionicons.mail),
                      url: "mailto:${email}",
                    ),
                    const Text(
                      "|",
                      style: TextStyle(
                        color: Color.fromARGB(158, 204, 203, 203),
                        fontSize: 40,
                      ),
                    ),
                    Icon_Url(
                      icon: const Icon(Ionicons.document_sharp),
                      url: cv,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 0; i < Skills.length; i++,)
                        Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: containerBackgroun,
                          ),
                          child: Text(
                            Skills[i].toString(),
                            style: const TextStyle(
                              fontSize: subTitleSize,
                            ),
                          ),
                        ),
                    ],
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
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 16, bottom: 5),
                child: Center(
                  child: Text(
                    address,
                    style: const TextStyle(fontSize: subTitleSize),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Visibility(
                  visible: visibilty,
                  child: TextButton(
                    onPressed: () async {
                      await getlocation();
                      await FirebaseFirestore.instance
                          .collection('Users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .update({
                        'address': Location1,
                        'location':[latitude,longtude],
                      });
                    },
                    child: const CircleAvatar(
                      backgroundColor: iconColor,
                      child: Icon(
                        Ionicons.location_sharp,
                        color: buttonColor,
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
                      "Major",
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
                    major,
                    style: const TextStyle(fontSize: subTitleSize),
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
                  Navigator.popAndPushNamed(context, "Home");
                },
              ),
            ]),
      ),
    );
  }
}
