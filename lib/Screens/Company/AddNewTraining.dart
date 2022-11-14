import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jobology/constants.dart';

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
  String comp_id = "";
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      setState(() {
        comp_name = event['Fullname'];
        comp_id = event['user_id'];
      });
    });
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroud,
        appBar: AppBar(
          toolbarHeight: 75,
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          elevation: 0,
          leading: Builder(
            builder: (context) => IconButton(
                icon: const Icon(
                  Ionicons.arrow_back,
                  color: Colors.black,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
              child: ListView(
            children: [
              //Image.asset("images/training.png"),
              CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey,
                  backgroundImage:
                      pickedimg == null ? null : FileImage(pickedimg!)),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Text("Choose image From ?",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => funimg(ImageSource.gallery),
                        icon: Icon(Ionicons.folder),
                      ),
                      IconButton(
                        onPressed: () => funimg(ImageSource.camera),
                        icon: Icon(
                          Ionicons.camera,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Ionicons.text_outline),
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
                    prefixIcon: Icon(Ionicons.document_text_outline),
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
                    prefixIcon: Icon(Ionicons.cash_outline),
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
                    prefixIcon: Icon(Ionicons.link_outline),
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
                    backgroundColor: buttonColor,
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
                  String date = now.day.toString() +
                      ":" +
                      now.hour.toString() +
                      ":" +
                      now.minute.toString();
                  FirebaseFirestore.instance.collection('Training').add({
                    'Company_name': comp_name,
                    'course_title': titleController.text,
                    'breif': briefController.text,
                    'price': priceController.text,
                    'url': urlController.text,
                    'img_url': url,
                    'comp_id': comp_id,
                    'date': date
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
