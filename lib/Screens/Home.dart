import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:flutter_switch/flutter_switch.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

bool status8 = false;

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          backgroundColor: Color.fromARGB(0, 255, 255, 255),
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
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
          centerTitle: true,
          actions: [
            Row(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Image.asset(
                      "images/user.png",
                      width: 50,
                    ),
                  ],
                ),
                SizedBox(
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
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Username",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
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
                  FlutterSwitch(
                    value: status8,
                    activeColor: Color.fromARGB(255, 1, 95, 87),
                    activeIcon: Icon(
                      Icons.dark_mode,
                      color: Color.fromARGB(255, 6, 135, 113),
                    ),
                    inactiveIcon: Icon(
                      Icons.light_mode,
                      color: Color.fromARGB(255, 6, 135, 113),
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
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                  color: Color.fromARGB(147, 76, 175, 111),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: Icon(
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
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                  color: Color.fromARGB(147, 76, 175, 111),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: Icon(
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
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                  color: Color.fromARGB(147, 76, 175, 111),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: Icon(
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
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                  color: Color.fromARGB(147, 76, 175, 111),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: Icon(
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
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(bottom: 15),
                  height: 180,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 1, 95, 87),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    title: Text(
                      "Courses",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    subtitle: Text(
                      "Best courses ever",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "jobs");
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 15),
                  height: 180,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 1, 95, 87),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    title: Text(
                      "Jobs",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    subtitle: Text(
                      "Find your job easly",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(bottom: 15),
                  height: 180,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 1, 95, 87),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    title: Text(
                      "CV",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    subtitle: Text(
                      "Make your CV professionally",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(bottom: 15),
                  height: 180,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 1, 95, 87),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    title: Text(
                      "Interview questions",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
