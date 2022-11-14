import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jobology/constants.dart';
import 'package:file_picker/file_picker.dart';

class editProfile extends StatefulWidget {
  editProfile(
      {this.img_url,
      this.cv,
      this.Fullname,
      this.address,
      this.age,
      this.phone,
      this.major,
      this.bio,
      this.github,
      this.linkedin,
      this.ChoosenSkills});
  String? img_url;
  String? cv;
  String? Fullname;
  String? address;
  String? age;
  String? major;
  String? phone;
  String? bio;
  String? github;
  String? linkedin;
  List? ChoosenSkills;

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  PlatformFile? cv_file;
  Future SelectCv() async {
    final ruselt = await FilePicker.platform.pickFiles();
    if (ruselt == null) {
      return;
    }
    setState(() {
      cv_file = ruselt.files.first;
    });
  }

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

  //List SelectedItem = [];

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
    TextEditingController githubController = TextEditingController(
        text: widget.github == null ? null : widget.github);
    TextEditingController linkedinController = TextEditingController(
        text: widget.linkedin == null ? null : widget.linkedin);

    return Scaffold(
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
                    prefixIcon: Icon(Icons.location_pin),
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
                    prefixIcon: Icon(Icons.calendar_month),
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
                    prefixIcon: Icon(Icons.book),
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
                    prefixIcon: Icon(Icons.format_quote),
                    labelText: 'Bio',
                    hintText: 'Enter your Bio',
                    border: OutlineInputBorder()),
                controller: bioController,
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
                    prefixIcon: Icon(Ionicons.logo_github),
                    labelText: 'GitHub',
                    hintText: 'Enter your Github url',
                    border: OutlineInputBorder()),
                controller: githubController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Ionicons.logo_linkedin),
                    labelText: 'linkedIn',
                    hintText: 'Enter your linkedIn account',
                    border: OutlineInputBorder()),
                controller: linkedinController,
              ),
              const SizedBox(
                height: 20,
              ),

              Container(
                // decoration: BoxDecoration(
                //   border: Border.all(
                //     width: 1,
                //     color: Colors.grey,
                //   ),
                // ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: DropdownButtonFormField(
                    style: const TextStyle(
                      color: Color.fromARGB(255, 130, 129, 129),
                    ),
                    value: Selected,
                    items: skills
                        .map((e) =>
                            DropdownMenuItem(value: e, child: Text("${e}")))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        Selected = value.toString();
                        //SelectedItem.add(Selected);
                        widget.ChoosenSkills!.add(Selected);
                        // print(SelectedItem);
                      });
                    },
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     children: [
              //       for (int i = 0; i < SelectedItem.length; i++)
              //         Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Text(
              //             "${SelectedItem[i].toString()},  ",
              //             style: const TextStyle(
              //               fontSize: ParagraphSize,
              //             ),
              //           ),
              //         ),
              //     ],
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 0; i < widget.ChoosenSkills!.length; i++)
                      Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            // color: containerBackgroun,
                            border: Border.all(color: containerBackgroun)),
                        child: Row(
                          children: [
                            Text(
                              "${widget.ChoosenSkills![i].toString()}",
                              style: const TextStyle(
                                fontSize: ParagraphSize,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('Users')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .update({
                                    'skills': FieldValue.arrayRemove(
                                        [widget.ChoosenSkills![i]])
                                  });
                                  widget.ChoosenSkills!
                                      .remove(widget.ChoosenSkills![i]);
                                  setState(() {
                                    widget.ChoosenSkills !=
                                        widget.ChoosenSkills!;
                                  });
                                  print(widget.ChoosenSkills!);
                                },
                                icon: Icon(Icons.delete))
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Icon(
                          Ionicons.cloud_upload_outline,
                          color: Color.fromARGB(255, 117, 116, 116),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Upload your CV",
                          style: TextStyle(
                            color: Color.fromARGB(255, 117, 116, 116),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  SelectCv();
                },
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
                  final cv_url;
                  if (cv_file == null) {
                    cv_url = widget.cv;
                  } else {
                    final path = 'Users_cv/${cv_file!.name}';
                    final file = File(cv_file!.path!);
                    final cv_ref = FirebaseStorage.instance.ref().child(path);
                    await cv_ref.putFile(file);
                    cv_url = await cv_ref.getDownloadURL();
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
                    'Githuburl': githubController.text,
                    'skills': FieldValue.arrayUnion(widget.ChoosenSkills!),
                    'cv': cv_url
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
