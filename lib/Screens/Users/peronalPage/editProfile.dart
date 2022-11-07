import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class editProfile extends StatefulWidget {
  editProfile({
    this.img_url,
    this.Fullname,
    this.address,
    this.age,
    this.phone,
    this.major,
  });
  String? img_url;
  String? Fullname;
  String? address;
  String? age;
  String? major;
  String? phone;
  String? bio;
  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  TextEditingController Fullnameconrller = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController majorController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          child: ListView(
            children: [
              Container(
                  width: 100,
                  height: 100,
                  child: Image.asset("images/user.png")),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_outlined),
                    labelText: 'full name',
                    hintText: 'edit your name',
                    border: OutlineInputBorder()),
                controller: Fullnameconrller,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_outlined),
                    labelText: 'address',
                    hintText: 'enter your address',
                    border: OutlineInputBorder()),
                controller: addressController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_outlined),
                    labelText: 'age',
                    hintText: 'enter your age',
                    border: OutlineInputBorder()),
                controller: ageController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_outlined),
                    labelText: 'major',
                    hintText: 'enter your major',
                    border: OutlineInputBorder()),
                controller: majorController,
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_outlined),
                    labelText: 'phone',
                    hintText: 'enter your phone num',
                    border: OutlineInputBorder()),
                controller: phoneController,
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: OutlinedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 5, 108, 106),
                    shape: RoundedRectangleBorder(),
                    padding: EdgeInsets.symmetric(vertical: 15)),
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('Users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .update({
                    'Fullname': Fullnameconrller.text,
                    'address': addressController.text,
                    'age': ageController.text,
                    'major': majorController.text,
                    'phone': phoneController.text,
                    'bio': bioController.text,
                    'img': ""
                  });
                },
                child: Text(
                  "Update",
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
