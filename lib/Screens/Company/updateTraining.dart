import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jobology/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Update_training extends StatefulWidget {
  Update_training(
      {this.imageUrl,
      this.title,
      this.breif,
      this.url,
      this.price,
      this.docnid});
  String? title;
  String? imageUrl;
  String? breif;
  String? price;
  String? url;
  dynamic docnid;

  @override
  State<Update_training> createState() => _Update_trainingState();
}

String comp_name = "";
String img_url = "";

class _Update_trainingState extends State<Update_training> {
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

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      setState(() {
        comp_name = event['Fullname'];
        img_url = event['img'];
      });
    });
    TextEditingController titleController =
        TextEditingController(text: widget.title == null ? null : widget.title);
    TextEditingController briefController =
        TextEditingController(text: widget.breif == null ? null : widget.breif);
    TextEditingController priceController =
        TextEditingController(text: widget.price == null ? null : widget.price);
    TextEditingController urlController =
        TextEditingController(text: widget.url == null ? null : widget.url);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
              icon: Image.asset(
                "images/back.png",
                width: 26,
              ),
              onPressed: () {
                Navigator.pushNamed(context, "companyHome");
              }),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Welcome",
                  style: TextStyle(
                    color: Color.fromARGB(255, 153, 152, 152),
                    fontSize: subTitleSize,
                  ),
                ),
                Text(
                  "$comp_name ,",
                  style: const TextStyle(color: Colors.black),
                )
              ],
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(img_url),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          child: ListView(
            children: [
              CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey,
                  backgroundImage:
                      pickedimg == null ? null : FileImage(pickedimg!)),
              const SizedBox(
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
                        icon: const Icon(Ionicons.folder),
                      ),
                      IconButton(
                        onPressed: () => funimg(ImageSource.camera),
                        icon: const Icon(
                          Ionicons.camera,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
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
                    hintText: 'Add url to your course',
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
                  final url;
                  if (pickedimg == null) {
                    url = widget.imageUrl!;
                  } else {
                    DateTime now = DateTime.now();
                    final storageRef = FirebaseStorage.instance
                        .ref()
                        .child('Users_img')
                        .child(comp_name.toString() +
                            now.hour.toString() +
                            now.minute.toString() +
                            now.second.toString() +
                            '.jpg');
                    await storageRef.putFile(pickedimg!);
                    url = await storageRef.getDownloadURL();
                  }

                  await FirebaseFirestore.instance
                      .collection('Training')
                      .doc(widget.docnid)
                      .update({
                    'job_title': titleController.text,
                    'breif': briefController.text,
                    'price': priceController.text,
                    'url': urlController.text
                  });
                  Navigator.pop(context);
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
