import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jobology/constants.dart';

class EditCompanyInfo extends StatefulWidget {
  EditCompanyInfo(
      {this.img_url,
      this.Fullname,
      this.address,
      this.email,
      this.phone,
      this.info,
      this.facebook,
      this.linkedin});
  String? img_url;
  String? Fullname;
  String? address;
  String? email;
  String? phone;
  String? info;
  String? facebook;
  String? linkedin;
  @override
  State<EditCompanyInfo> createState() => _EditCompanyInfoState();
}

class _EditCompanyInfoState extends State<EditCompanyInfo> {
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
    TextEditingController Fullnameconrller = TextEditingController(
        text: widget.Fullname == null ? null : widget.Fullname);
    TextEditingController addressController = TextEditingController(
        text: widget.address == null ? null : widget.address);
    TextEditingController emailController =
        TextEditingController(text: widget.email == null ? null : widget.email);
    TextEditingController phoneController =
        TextEditingController(text: widget.phone == null ? null : widget.phone);
    TextEditingController facebookController = TextEditingController(
        text: widget.facebook == null ? null : widget.facebook);
    TextEditingController linkedinController = TextEditingController(
        text: widget.linkedin == null ? null : widget.linkedin);
    TextEditingController InfoController =
        TextEditingController(text: widget.info == null ? null : widget.info);

    return Scaffold(
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
        padding: const EdgeInsets.all(20),
        child: Form(
          child: ListView(children: [
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
                  labelText: 'Company name',
                  hintText: 'Edit Company name',
                  border: OutlineInputBorder()),
              controller: Fullnameconrller,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.location_pin),
                  labelText: 'Address',
                  hintText: 'Enter Company address',
                  border: OutlineInputBorder()),
              controller: addressController,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email',
                  hintText: 'Enter Company Email',
                  border: OutlineInputBorder()),
              controller: emailController,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.book),
                  labelText: 'Information',
                  hintText: 'Enter Company info',
                  border: OutlineInputBorder()),
              controller: InfoController,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  labelText: 'phone',
                  hintText: 'Enter your phone num',
                  border: OutlineInputBorder()),
              controller: phoneController,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Ionicons.logo_facebook),
                  labelText: 'FaceBook',
                  hintText: 'Enter Company Facebook url',
                  border: OutlineInputBorder()),
              controller: facebookController,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Ionicons.logo_linkedin),
                  labelText: 'linkedIn',
                  hintText: 'Enter Company linkedIn account',
                  border: OutlineInputBorder()),
              controller: linkedinController,
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: OutlinedButton.styleFrom(
                  backgroundColor: buttonColor,
                  shape: RoundedRectangleBorder(),
                  padding: EdgeInsets.symmetric(vertical: 15)),
              onPressed: () async {
                final url;
                if (pickedimg == null) {
                  url = widget.img_url!;
                } else {
                  DateTime now = DateTime.now();
                  final storageRef = FirebaseStorage.instance
                      .ref()
                      .child('Users_img')
                      .child(widget.Fullname.toString() +
                          now.hour.toString() +
                          now.minute.toString() +
                          now.second.toString() +
                          '.jpg');
                  await storageRef.putFile(pickedimg!);
                  url = await storageRef.getDownloadURL();
                }
                await FirebaseFirestore.instance
                    .collection('Users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .update({
                  'Fullname': Fullnameconrller.text,
                  'address': addressController.text,
                  'Email': emailController.text,
                  'Info': InfoController.text,
                  'phone': phoneController.text,
                  'img': url,
                  'linkedinurl': linkedinController.text,
                  'facebookurl': facebookController.text,
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
          ]),
        ),
      ),
    );
  }
}
