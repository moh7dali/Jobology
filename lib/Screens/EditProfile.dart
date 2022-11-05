import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jobology/HomeComponents/Navigationbar.dart';

class PersonalInfo extends StatefulWidget {
  PersonalInfo({Key? key}) : super(key: key);
  static GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

int _page = 0;

class _PersonalInfoState extends State<PersonalInfo> {
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey =
      GlobalKey<CurvedNavigationBarState>();

  void initState() {
    super.initState();
    PersonalInfo.bottomNavigationKey = bottomNavigationKey;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(),
        bottomNavigationBar: CurvedNavigationBar(
          key: bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: const <Widget>[
            Icon(Icons.logout, size: 30),
            SizedBox(
              width: 30,
            ),
            Icon(Icons.home, size: 30),
            SizedBox(
              width: 30,
            ),
            Icon(Icons.perm_identity, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: const Color.fromARGB(163, 12, 117, 99),
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() async {
              _page = index;
              if (_page == 0) {
                final GoogleSignInAccount? googleUser =
                    await GoogleSignIn().signOut();
                await FirebaseAuth.instance.signOut();

                print("User Sign Out");
                Navigator.pushNamed(context, "Start");
              } else if (_page == 2) {
                Navigator.pushNamed(context, "Home");
              } else if (_page == 4) {
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
          },
          letIndexChange: (index) => true,
        ),
      ),
    );
  }
}
