import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool _isObscure = true;
  void nav() {
    Navigator.popAndPushNamed(context, 'forgetpassword');
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Image.network(
              'https://static.wixstatic.com/media/bcace9_c8332fc9319a4cb79cce54c1324673c7~mv2.png/v1/fill/w_370,h_104,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/JOBOLOGY%20LOGO%20FINAL.png',
              height: height * 0.2,
            ),
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
                          prefixIcon: Icon(Icons.person_outline_outlined),
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
                    onPressed: nav, child: const Text("Forget Password ?"))),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(),
                      padding: EdgeInsets.symmetric(vertical: 15)),
                  onPressed: () async {
                    try {
                      var auth = FirebaseAuth.instance;
                      UserCredential myuser =
                          await auth.signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passController.text);
                      Navigator.popAndPushNamed(context, "Home");
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
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
              child: OutlinedButton.icon(
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
                  icon: Icon(Ionicons.logo_google),
                  label: Text("continue with google",
                      style: GoogleFonts.montserrat(
                          fontSize: 20, fontWeight: FontWeight.bold))),
            ),
            SingleChildScrollView(scrollDirection: Axis.horizontal,
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(children: [
                    Text("Don't have an account ?",
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "Sign_Up");
                        },
                        child: Text("SIGN UP",
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.bold))),
                  ])),
            ),
          ]),
        ),
      ),
    );
  }
}