import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:jobology/HomeComponents/sectionscard.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:jobology/Screens/EditProfile.dart';
import 'package:jobology/Screens/jobs.dart';

class Home extends StatefulWidget {
  Home({super.key});
  static GlobalKey<CurvedNavigationBarState> bottomNavigationKey =
      GlobalKey<CurvedNavigationBarState>();
  @override
  State<Home> createState() => _HomeState();
}

bool status8 = false;
int _page = 0;

class _HomeState extends State<Home> {
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey =
      GlobalKey<CurvedNavigationBarState>();

  void initState() {
    super.initState();
    Home.bottomNavigationKey = bottomNavigationKey;
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
                "images/drawer.png",
                width: 35,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
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
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Column(
                  children: [
                    Image.asset(
                      "images/user.png",
                      width: 80,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Username",
                      style: TextStyle(fontSize: 18),
                    ),
                    const Text(
                      "example@example.com",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 145, 143, 143),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(147, 76, 175, 111),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Home",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(147, 76, 175, 111),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Personal information",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(147, 76, 175, 111),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () async {
                    final GoogleSignInAccount? googleUser =
                        await GoogleSignIn().signOut();
                    await FirebaseAuth.instance.signOut();

                    print("User Sign Out");
                    Navigator.pushNamed(context, "Start");
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(147, 76, 175, 111),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Exit the app",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
              ),
            ],
          ),
        ),
        body: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text(
                      "Start your\ntrip,",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SectionsCard(
                      OnTapping: () {},
                      CardTitle: "Courses",
                      CardSubTitle: "Your way to your job",
                      ImageName: "images/Courses.png",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SectionsCard(
                      OnTapping: () {},
                      CardTitle: "CV",
                      CardSubTitle: "Create your CV",
                      ImageName: "images/cv.png",
                    ),
                  ],
                ),
                const SizedBox(
                  width: 30,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    SectionsCard(
                      OnTapping: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return jobs();
                            },
                          ),
                        );
                      },
                      CardTitle: "Jobs",
                      CardSubTitle: "Find your job easly",
                      ImageName: "images/job.png",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SectionsCard(
                      OnTapping: () {},
                      CardTitle: "Interview Questions",
                      CardSubTitle: "",
                      ImageName: "images/interview.png",
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
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
          },
          letIndexChange: (index) => true,
        ),
      ),
    );
  }
}
