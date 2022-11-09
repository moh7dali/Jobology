import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jobology/constants.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({super.key});

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
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.mail),
                                labelText: 'Email',
                                hintText: 'Enter Your Email',
                                border: OutlineInputBorder()),
                            controller: emailController,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.phone),
                                labelText: 'Phone',
                                hintText: 'Enter Your Phone',
                                border: OutlineInputBorder()),
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
                          const SizedBox(
                            height: 10,
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
                        onPressed: () async {
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
                              'facebookurl': "",
                              'linkedinurl': ""
                            });

                            Navigator.popAndPushNamed(context, "Login");
                          } on FirebaseAuthException catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.message.toString())));
                          }
                        },
                        child: Text("SIGN UP",
                            style: GoogleFonts.montserrat(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,
                            shape: RoundedRectangleBorder(),
                            padding: EdgeInsets.all(15)),
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

                          Navigator.pushNamed(context, "Home");
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
