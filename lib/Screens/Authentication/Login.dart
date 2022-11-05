import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jobology/Screens/Users/Home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  String us_id = "";
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back,",
                      style: GoogleFonts.montserrat(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Make it fast ...",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(fontSize: 20),
                    ),
                    Form(
                      child: Container(
                        padding: EdgeInsets.only(top: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.person_outline_outlined),
                                  labelText: 'Email',
                                  hintText: 'Enter Your Email',
                                  border: OutlineInputBorder()),
                              controller: emailController,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              obscureText: _isObscure,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter Your password',
                                prefixIcon: Icon(Icons.fingerprint),
                                border: OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                ),
                              ),
                              controller: passController,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                            onPressed: () {
                              Navigator.popAndPushNamed(
                                  context, 'forgetpassword');
                            },
                            child: Text("Forget Password ?",
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 5, 108, 106),
                                )))),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 5, 108, 106),
                              shape: RoundedRectangleBorder(),
                              padding: EdgeInsets.symmetric(vertical: 15)),
                          onPressed: () async {
                            try {
                              var auth = FirebaseAuth.instance;
                              var type;
                              UserCredential myuser =
                                  await auth.signInWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passController.text);
                              us_id = myuser.user!.uid;
                              FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc(us_id)
                                  .snapshots()
                                  .listen((event) {
                                setState(() {
                                  type = event['rules'];
                                  if (type == "User") {
                                    Navigator.popAndPushNamed(context, "Home");
                                  } else if (type == "company") {
                                    Navigator.popAndPushNamed(
<<<<<<< HEAD
                                        context, "companyHome");
=======
                                        context, "course");
>>>>>>> c2163656234d690a90bf8d70bd6d60e9f48c201b
                                  }
                                });
                              });
                            } on FirebaseAuthException catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(e.message.toString())));
                            }
                          },
                          child: Text("LOGIN",
                              style: GoogleFonts.montserrat(
                                  fontSize: 20, fontWeight: FontWeight.bold))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "OR",
                        style: GoogleFonts.montserrat(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(),
                            side: BorderSide(color: Colors.grey),
                            padding: EdgeInsets.symmetric(vertical: 15)),
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
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())));
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "images/gmail.png",
                              scale: 15,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Continue with google",
                              style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.popAndPushNamed(context, "Sign_Up");
                        },
                        child: Text.rich(TextSpan(
                            text: "Don't Have An Account ? ",
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                // fontWeight: FontWeight.bold,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black),
                            children: const [
                              TextSpan(
                                text: "Sign Up",
                                style: TextStyle(color: Colors.blue),
                              )
                            ]))),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
