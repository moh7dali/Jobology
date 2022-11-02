import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({super.key});

  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          TextField(
            controller: emailController,
          ),
          TextField(
            controller: passController,
          ),
          ElevatedButton.icon(
              onPressed: () async {
                try {
                  var auth = FirebaseAuth.instance;
                  UserCredential myuser =
                      await auth.createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passController.text);
                  Navigator.pushNamed(context, "Login");
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("${e.toString()}")));
                }
              },
              icon: Icon(Icons.login),
              label: Text("Sign UP"))
        ]),
      ),
    );
  }
}
