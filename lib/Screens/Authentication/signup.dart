// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jobology/constants.dart';
import 'package:validators/validators.dart';

class Sign_up extends StatefulWidget {
  Sign_up({
    super.key,
  });

  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String us_id = "";
  bool _isObscure = true;
  bool isEmailcorrect = false;
  bool success = false;

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
                    "Get on Board!",
                    style: GoogleFonts.montserrat(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Create Your Profile to start your journey",
                    style: GoogleFonts.poppins(fontSize: 20),
                  ),
                  Form(
                    child: Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.person_outline_outlined),
                                labelText: 'Full Name',
                                hintText: 'Enter Your Name',
                                border: OutlineInputBorder()),
                            controller: nameController,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
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
                                suffixIcon: emailController.text.isEmpty
                                    ? Icon(
                                        Icons.note_alt_outlined,
                                        color: Colors.white,
                                      )
                                    : isEmailcorrect == false
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
                                    color: emailController.text.isEmpty
                                        ? Colors.grey
                                        : isEmailcorrect == false
                                            ? Colors.red
                                            : Colors.green,
                                    width: 2,
                                  ),
                                ),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'phone',
                              hintText: 'add your phone number',
                              hintStyle: TextStyle(fontSize: 10),
                              prefixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder(),
                            ),
                            controller: phoneController,
                          ),
                          const SizedBox(
                            height: 10,
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
                                  color: passController.text.isEmpty
                                      ? Colors.grey
                                      : success == false
                                          ? Colors.red
                                          : Colors.green,
                                  width: 2,
                                ),
                              ),
                              suffixIcon: IconButton(
                                color: passController.text.isEmpty
                                    ? Colors.grey
                                    : success == false
                                        ? Colors.red
                                        : Colors.green,
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
                          FlutterPwValidator(
                            controller: passController,
                            minLength: 7,
                            width: 400,
                            height: 50,
                            onSuccess: () {
                              setState(() {
                                success = true;
                              });
                              print("MATCHED");
                            },
                            onFail: () {
                              setState(() {
                                success = false;
                              });
                              print("NOT MATCHED");
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                              var auth = FirebaseAuth.instance;
                              UserCredential myuser =
                                  await auth.createUserWithEmailAndPassword(
                                      email: emailController.text.trim(),
                                      password: passController.text.trim());
                              us_id = myuser.user!.uid;

                              FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc(myuser.user!.uid)
                                  .set({
                                'user_id': us_id,
                                'Fullname': nameController.text,
                                'Email': emailController.text,
                                'phone': phoneController.text,
                                'img': "",
                                'address': "",
                                'age': "",
                                'major': "",
                                'bio': "",
                                'rules': "User",
                                'Githuburl': "",
                                'linkedinurl': "",
                                'skills': [],
                                'cv': "",
                                'location':[],
                              });
                              print(myuser.additionalUserInfo!.isNewUser);
                              if (myuser.additionalUserInfo!.isNewUser) {
                                Navigator.popAndPushNamed(context, "Login");
                              }
                            } on FirebaseAuthException catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(e.message.toString())));
                            }
                          }
                        },
                        child: Text("SIGN UP",
                            style: GoogleFonts.montserrat(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      )),
                  const SizedBox(
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

                          us_id = myuser.user!.uid;
                          FirebaseFirestore.instance
                              .collection('Users')
                              .doc(myuser.user!.uid)
                              .set({
                            'user_id': us_id,
                            'Fullname': myuser.user!.displayName,
                            'Email': myuser.user!.email,
                            'phone': "",
                            'img': "",
                            'address': "",
                            'age': "",
                            'major': "",
                            'bio': "",
                            'rules': "User",
                            'Githuburl': "",
                            'linkedinurl': "",
                            'skills': [],
                            'cv': "",
                            'location':[],
                          });

                          Navigator.popAndPushNamed(context, "Check");
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
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text.rich(
                      TextSpan(
                        text: "Aleardy have an account ? ",
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                            color:
                                Get.isDarkMode ? Colors.white : Colors.black),
                        children: const [
                          TextSpan(
                            text: "LOG IN",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "Company Sign up");
                      },
                      child: const Text(
                        "Sign as a Company",
                        style: TextStyle(
                          color: buttonColor,
                          fontSize: ParagraphSize,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
