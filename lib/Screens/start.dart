import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

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
        //backgroundColor: Get.isDarkMode ? Colors.blue.shade300 : Colors.red,
        body: Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.network(
            'https://static.wixstatic.com/media/bcace9_c8332fc9319a4cb79cce54c1324673c7~mv2.png/v1/fill/w_370,h_104,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/JOBOLOGY%20LOGO%20FINAL.png',
            height: height * 0.5,
          ),
          Column(
            children: [
              Text(
                "Jobology",
                style: GoogleFonts.montserrat(
                    fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "lqw ws rdtsyc ic djij sghgchgscs fcsfghdf dfgdjfd sgdfgfd sdfg dg",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 20),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "Login");
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(),
                      side: BorderSide(color: Colors.grey),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text("LOGIN",
                        style: GoogleFonts.montserrat(fontSize: 25))),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "Sign_Up");
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(),
                      side: BorderSide(color: Colors.black),
                      //backgroundColor: Color.fromRGBO(121, 188, 198, 1),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text("SIGN UP",
                        style: GoogleFonts.montserrat(fontSize: 25))),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
