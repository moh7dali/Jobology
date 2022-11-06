import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AddNewTraining extends StatefulWidget {
  AddNewTraining({Key? key}) : super(key: key);

  @override
  State<AddNewTraining> createState() => _AddNewTrainingState();
}

class _AddNewTrainingState extends State<AddNewTraining> {
  final ImagePicker _picker = ImagePicker();
  File? pickedimg;
  funimg(ImageSource src) async {
    final XFile? image = await _picker.pickImage(source: src);
    if (image == null) {
      return;
    }
    setState(() {
      pickedimg = File(image.path);
    });
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController briefController = TextEditingController();
  TextEditingController priceController = TextEditingController();
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
              //Image.asset("images/training.png"),
              CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey,
                  backgroundImage:
                      pickedimg == null ? null : FileImage(pickedimg!)),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Choose image From ?",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                      )),
                  TextButton(
                      onPressed: () => funimg(ImageSource.gallery),
                      child: Text("Gallery",
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.bold))),
                  TextButton(
                      onPressed: () => funimg(ImageSource.camera),
                      child: Text("Camera",
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.bold))),
                ],
              ),
              SizedBox(
                height: 5,
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
                    labelText: 'price',
                    hintText: 'Add price',
                    border: OutlineInputBorder()),
                controller: priceController,
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
                onPressed: () async {
                  DateTime now = DateTime.now();
                  final storageRef = FirebaseStorage.instance
                      .ref()
                      .child('course_img')
                      .child(comp_name +
                          now.hour.toString() +
                          now.minute.toString() +
                          now.second.toString() +
                          '.jpg');
                  await storageRef.putFile(pickedimg!);
                  final url = await storageRef.getDownloadURL();

                  FirebaseFirestore.instance.collection('Training').add({
                    'Company_name': comp_name,
                    'course_title': titleController.text,
                    'breif': briefController.text,
                    'price': priceController.text,
                    'url': urlController.text,
                    'img_url': url
                  });
                  Navigator.pop(context);
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
