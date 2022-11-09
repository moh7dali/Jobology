import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobology/constants.dart';

class Start_page extends StatefulWidget {
  const Start_page({super.key});

  @override
  State<Start_page> createState() => _Start_pageState();
}

class _Start_pageState extends State<Start_page> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: backgroud,
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                "images/Logo.png",
                // width: 600,
                height: height * 0.5,
              ),
              Column(
                children: [
                  Text(
                    "Jobology,",
                    style: GoogleFonts.montserrat(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Your guide to find your dream job,",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(fontSize: 20),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "welcome");
                        },
                        style: OutlinedButton.styleFrom(
                          shape: const RoundedRectangleBorder(),
                          side: const BorderSide(color: Colors.black),
                          backgroundColor: buttonColor,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: Text("Get Started",
                            style: GoogleFonts.montserrat(fontSize: 25))),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
