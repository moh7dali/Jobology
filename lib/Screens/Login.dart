import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
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
                  UserCredential myuser = await auth.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passController.text);
                  Navigator.pushNamed(context, "Home");
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("${e.toString()}")));
                }
              },
              icon: Icon(Icons.login),
              label: Text("Log in"))
        ]),
      ),
    );
  }
}
