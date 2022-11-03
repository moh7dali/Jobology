import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("Welcome to home"),
          ElevatedButton.icon(
              onPressed: () async {
                final GoogleSignInAccount? googleUser =
                    await GoogleSignIn().signOut();
                await FirebaseAuth.instance.signOut();

                print("User Sign Out");
                Navigator.pushNamed(context, "Start");
              },
              icon: Icon(Icons.exit_to_app),
              label: Text("Log out")),
              ElevatedButton(onPressed: () {
             Navigator.pushNamed(context, "jobs");   
              }, child: Text("jobs"))
        ],
      ),
    );
  }
}
