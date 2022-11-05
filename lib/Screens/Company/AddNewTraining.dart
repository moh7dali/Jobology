import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddNewTraining extends StatefulWidget {
  AddNewTraining({Key? key}) : super(key: key);

  @override
  State<AddNewTraining> createState() => _AddNewTrainingState();
}

class _AddNewTrainingState extends State<AddNewTraining> {
  TextEditingController titleController = TextEditingController();
  TextEditingController briefController = TextEditingController();
  TextEditingController reqController = TextEditingController();
  TextEditingController urlController = TextEditingController();

  String comp_name = "";
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      setState(() {
        comp_name = event['Fullname'];
      });
    });
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
              child: ListView(
            children: [
              Image.asset("images/training.png"),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_outlined),
                    labelText: 'Ad title',
                    hintText: 'Enter Your Ad title',
                    border: OutlineInputBorder()),
                controller: titleController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_outlined),
                    labelText: 'Brief',
                    hintText: 'Enter a brief about job',
                    border: OutlineInputBorder()),
                controller: briefController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_outlined),
                    labelText: 'Requirments',
                    hintText: 'Add requirments',
                    border: OutlineInputBorder()),
                controller: reqController,
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_outlined),
                    labelText: 'Url',
                    hintText: 'Add url to your ad',
                    border: OutlineInputBorder()),
                controller: urlController,
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
                  FirebaseFirestore.instance.collection('Training').add({
                    'Company name': comp_name,
                    'job_title': titleController.text,
                    'breif': briefController.text,
                    'requirements': reqController.text,
                    'url': urlController.text
                  });
                },
                child: Text(
                  "Add",
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
