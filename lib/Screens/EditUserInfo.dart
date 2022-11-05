import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jobology/HomeComponents/Navigationbar.dart';
import 'package:get/get.dart';

class PersonalInfo extends StatefulWidget {
  PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

bool status8 = false;

int _page = 0;

class _PersonalInfoState extends State<PersonalInfo> {
  void OnTapping(int index) {
    setState(() {
      setState(() async {
        _page = index;
        if (_page == 0) {
          final GoogleSignInAccount? googleUser =
              await GoogleSignIn().signOut();
          await FirebaseAuth.instance.signOut();

          print("User Sign Out");
          Navigator.pushNamed(context, "Start");
        }
        if (_page == 2) {
          Navigator.pushNamed(context, "Home");
        }
        if (_page == 4) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return PersonalInfo();
              },
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          elevation: 0,
          leading: Builder(
            builder: (context) => IconButton(
              icon: Image.asset(
                "images/back.png",
                width: 26,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "images/user.png",
                width: 50,
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Welcome",
                    style: TextStyle(
                      color: Color.fromARGB(255, 153, 152, 152),
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    "Username,",
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
            ],
          ),
          centerTitle: true,
          actions: [
            Row(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    FlutterSwitch(
                      value: status8,
                      activeColor: Color.fromARGB(135, 16, 153, 130),
                      activeIcon: const Icon(
                        Icons.dark_mode,
                        color: Color.fromARGB(255, 118, 122, 121),
                      ),
                      inactiveIcon: const Icon(
                        Icons.light_mode,
                        color: Color.fromARGB(255, 223, 239, 3),
                      ),
                      onToggle: (val) {
                        setState(() {
                          status8 = val;
                          if (Get.isDarkMode) {
                            Get.changeTheme(ThemeData.light());
                          } else {
                            Get.changeTheme(
                              ThemeData.dark(),
                            );
                          }
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
          ],
        ),
        body: Column(),
        bottomNavigationBar: BottomBNavigator(
          OnTapping: OnTapping,
        ),
      ),
    );
  }
}
