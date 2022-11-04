import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailController = TextEditingController();
  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text.toLowerCase().trim());
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("check your email"),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    }
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
              "Forget Password ",
              style: GoogleFonts.montserrat(
                  fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(
              "Just Enter your Email and Reset Your password",
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
                          labelText: 'E-mail',
                          hintText: 'Enter Your Email',
                          border: OutlineInputBorder()),
                      controller: emailController,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(),
                      padding: EdgeInsets.symmetric(vertical: 15)),
                  onPressed: passwordReset,
                  child: Text("Reset Password",
                      style: GoogleFonts.montserrat(
                          fontSize: 20, fontWeight: FontWeight.bold))),
            ),
          ]),
        ),
      ),
    );
  }
}
