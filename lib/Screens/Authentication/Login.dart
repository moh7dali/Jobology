// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobology/Widgets/ck_login.dart';
import 'package:jobology/constants.dart';
import 'package:validators/validators.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  String us_id = "";
  bool _isObscure = true;
  bool isEmailcorrect = false;
  bool success = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                          controller: emailController,
                          onChanged: (val) {
                            setState(() {
                              isEmailcorrect = isEmail(val);
                            });
                          },
                          showCursor: true,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'something@gmail.com',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 18),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Colors.black87,
                            ),
                            suffixIcon: isEmailcorrect == false
                                ? Icon(
                                    Icons.close_sharp,
                                    color: Colors.red,
                                  )
                                : Icon(
                                    Icons.done,
                                    color: Colors.green,
                                  ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black54,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: isEmailcorrect == false
                                    ? Colors.red
                                    : Colors.green,
                                width: 2,
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter Your password',
                          prefixIcon: Icon(Icons.fingerprint),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black54,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  success == false ? Colors.red : Colors.green,
                              width: 2,
                            ),
                          ),
                          suffixIcon: IconButton(
                            color: success == false ? Colors.red : Colors.green,
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
                      SizedBox(
                        height: 5,
                      ),
                      FlutterPwValidator(
                        controller: passController,
                        minLength: 7,
                        width: 400,
                        height: 150,
                        onSuccess: () {
                          setState(() {
                            success = true;
                          });
                          print("MATCHED");
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Password is matched")));
                        },
                        onFail: () {
                          setState(() {
                            success = false;
                          });
                          print("NOT MATCHED");
                        },
                      )
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, 'forgetpassword');
                  },
                  child: Text(
                    "Forget Password ?",
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      color: buttonColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: OutlinedButton.styleFrom(
                        backgroundColor: isEmailcorrect == false
                            ? Colors.black45
                            : buttonColor,
                        shape: RoundedRectangleBorder(),
                        padding: EdgeInsets.symmetric(vertical: 15)),
                    onPressed: () async {
                      if (isEmailcorrect == true && success == true) {
                        try {
                          FocusScope.of(context).unfocus();
                          var auth = FirebaseAuth.instance;
                          var type;
                          UserCredential myuser =
                              await auth.signInWithEmailAndPassword(
                                  email: emailController.text.trim(),
                                  password: passController.text);
                          us_id = myuser.user!.uid;

                          Navigator.popAndPushNamed(context, "Check");
                        } on FirebaseAuthException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text("the email or password not vaild ")));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("correct your email or password  ")));
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
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
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
                            color:
                                Get.isDarkMode ? Colors.white : Colors.black),
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
                    Navigator.pushNamed(context, "Sign_Up");
                  },
                  child: Text.rich(TextSpan(
                      text: "Don't Have An Account ? ",
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                          color: Get.isDarkMode ? Colors.white : Colors.black),
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
    );
  }
}
