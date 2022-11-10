import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jobology/constants.dart';

class editProfile extends StatefulWidget {
  editProfile(
      {this.img_url,
      this.Fullname,
      this.address,
      this.age,
      this.phone,
      this.major,
      this.bio,
      this.facebook,
      this.linkedin});
  String? img_url;
  String? Fullname;
  String? address;
  String? age;
  String? major;
  String? phone;
  String? bio;
  String? facebook;
  String? linkedin;

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
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

  List SelectedItem = [];
  @override
  Widget build(BuildContext context) {
    String Selected = "Skills";
    List skills = [
      "Skills",
      "Microsoft PowerPoint",
      'Google Slides',
      "SlideShare",
      "HTML",
      "Javascript",
      "C++",
      "Python",
      "Internet Applications",
      "Networks",
      "Operating Systems",
      "Troubleshooting",
      "Internet Security",
      "Data Privacy",
      "Programming Languages",
      "Agile Development",
      "Database Administration",
      "UI/UX",
      "Cloud Management",
      "Data Synchronization",
      "Social Media Experience",
      "Project Management",
      "Technical Writing",
      "Debugging",
      "Network Architecture",
      "Quality Assurance",
      "Technical Support",
      "SQL",
      "Oracle",
      "LINUX",
      "Java",
      "Software Installation",
      "Adobe Creative Suite",
      "Backup management",
      "Microsoft Office"
    ];
    TextEditingController Fullnameconrller = TextEditingController(
        text: widget.Fullname == null ? null : widget.Fullname);
    TextEditingController addressController = TextEditingController(
        text: widget.address == null ? null : widget.address);
    TextEditingController ageController =
        TextEditingController(text: widget.age == null ? null : widget.age);
    TextEditingController majorController =
        TextEditingController(text: widget.major == null ? null : widget.major);
    TextEditingController phoneController =
        TextEditingController(text: widget.phone == null ? null : widget.phone);
    TextEditingController bioController =
        TextEditingController(text: widget.bio == null ? null : widget.bio);
    TextEditingController facebookController = TextEditingController(
        text: widget.facebook == null ? null : widget.facebook);
    TextEditingController linkedinController = TextEditingController(
        text: widget.linkedin == null ? null : widget.linkedin);

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
                Navigator.pop(context);
              }),
        ),
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
                    prefixIcon: Icon(Icons.person_outline_outlined),
                    labelText: 'Full name',
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
                    labelText: 'Address',
                    hintText: 'Enter your address',
                    border: OutlineInputBorder()),
                controller: addressController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_outlined),
                    labelText: 'Age',
                    hintText: 'Enter your age',
                    border: OutlineInputBorder()),
                controller: ageController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_outlined),
                    labelText: 'Major',
                    hintText: 'Enter your major',
                    border: OutlineInputBorder()),
                controller: majorController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_outlined),
                    labelText: 'Bio',
                    hintText: 'Enter your Bio',
                    border: OutlineInputBorder()),
                controller: bioController,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_outlined),
                    labelText: 'phone',
                    hintText: 'Enter your phone num',
                    border: OutlineInputBorder()),
                controller: phoneController,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_outlined),
                    labelText: 'facebook',
                    hintText: 'Enter your facebook url',
                    border: OutlineInputBorder()),
                controller: facebookController,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_outlined),
                    labelText: 'linkedIn',
                    hintText: 'Enter your linkedIn account',
                    border: OutlineInputBorder()),
                controller: linkedinController,
              ),
              SizedBox(
                height: 20,
              ),
              DropdownButtonFormField(
                value: Selected,
                items: skills
                    .map((e) => DropdownMenuItem(value: e, child: Text("${e}")))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    Selected = value.toString();
                    SelectedItem.add(Selected);
                    print(SelectedItem);
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              for (int i = 0; i < SelectedItem.length; i++)
                Text(SelectedItem[i].toString()),
              SizedBox(
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
                    'age': ageController.text,
                    'major': majorController.text,
                    'phone': phoneController.text,
                    'bio': bioController.text,
                    'img': url,
                    'linkedinurl': linkedinController.text,
                    'facebookurl': facebookController.text,
                    'skills': FieldValue.arrayUnion(SelectedItem)
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
