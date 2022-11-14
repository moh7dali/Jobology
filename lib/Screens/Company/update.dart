import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jobology/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Update_job extends StatefulWidget {
  Update_job(
      {this.imageUrl,
      this.title,
      this.breif,
      this.url,
      this.years,
      this.req,
      this.docnid});
  String? title;
  String? imageUrl;
  String? breif;
  String? req;
  String? years;
  String? url;
  dynamic docnid;

  @override
  State<Update_job> createState() => _Update_jobState();
}

String comp_name = "";
String img_url = "";

class _Update_jobState extends State<Update_job> {
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
    TextEditingController titleController =
        TextEditingController(text: widget.title == null ? null : widget.title);
    TextEditingController briefController =
        TextEditingController(text: widget.breif == null ? null : widget.breif);
    TextEditingController yearsController =
        TextEditingController(text: widget.years == null ? null : widget.years);
    TextEditingController reqController =
        TextEditingController(text: widget.req == null ? null : widget.req);
    TextEditingController urlController =
        TextEditingController(text: widget.url == null ? null : widget.url);

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
                  prefixIcon: Icon(Ionicons.text_outline),
                  labelText: 'Ad Title',
                  hintText: 'Edit Title name',
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
                  hintText: 'Edit Brief',
                  border: OutlineInputBorder()),
              controller: briefController,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.calendar_month),
                  labelText: 'Experience',
                  hintText: 'Edit Years of Experience',
                  border: OutlineInputBorder()),
              controller: yearsController,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Ionicons.alert_outline),
                  labelText: 'Requirements',
                  hintText: 'Edit Requirements',
                  border: OutlineInputBorder()),
              controller: reqController,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Ionicons.link_outline),
                  labelText: 'URL',
                  hintText: 'Edit URL',
                  border: OutlineInputBorder()),
              controller: urlController,
            ),
            const SizedBox(
              height: 20,
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
                    .collection('Jobs')
                    .doc(widget.docnid!)
                    .update({
                  'job_title': titleController.text,
                  'breif': briefController.text,
                  'years': yearsController.text,
                  'requirements': reqController.text,
                  'url': urlController.text,
                  'img_url': url,
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
