import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  void nav() {
    Navigator.popAndPushNamed(context, 'forgetpassword');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          TextField(
            controller: emailController,
          ),
          TextField(
            controller: passController,
          ),
          TextButton(onPressed: nav, child: Text("ForgetPassword")),
          ElevatedButton.icon(
              onPressed: () async {
                try {
                  var auth = FirebaseAuth.instance;
                  UserCredential myuser = await auth.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passController.text);
                  Navigator.popAndPushNamed(context, "Home");
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              icon: const Icon(Icons.login),
              label: const Text("Log in")),
          ElevatedButton.icon(
              onPressed: () async {
                try {
                  final GoogleSignInAccount? googleUser =
                      await GoogleSignIn().signIn();
                  final GoogleSignInAuthentication? googleAuth =
                      await googleUser?.authentication;
                  final credential = GoogleAuthProvider.credential(
                    accessToken: googleAuth?.accessToken,
                    idToken: googleAuth?.idToken,
                  );
                  var auth = FirebaseAuth.instance;
                  UserCredential myuser =
                      await auth.signInWithCredential(credential);

                  Navigator.popAndPushNamed(context, "Home");
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              icon: const Icon(Icons.login),
              label: const Text("continue with google")),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "Sign_Up");
              },
              child: const Text("Sign_up"))
        ]),
      ),
    );
  }
}
