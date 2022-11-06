import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

class _Update_jobState extends State<Update_job> {
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: widget.title);
    TextEditingController briefController =
        TextEditingController(text: widget.breif);
    TextEditingController yearController =
        TextEditingController(text: widget.years);
    TextEditingController reqController =
        TextEditingController(text: widget.req);
    TextEditingController urlController =
        TextEditingController(text: widget.url);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          child: ListView(
            children: [
              Image.asset("images/jobCompany.png"),
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
                    labelText: 'Experience years',
                    hintText: '0-3, 4-7, 8 and more',
                    border: OutlineInputBorder()),
                controller: yearController,
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
                    hintText: 'Add url to your course',
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
                  FirebaseFirestore.instance
                      .collection('Jobs')
                      .doc(widget.docnid)
                      .update({
                    'job_title': titleController.text,
                    'breif': briefController.text,
                    'years': yearController.text,
                    'requirements': reqController.text,
                    'url': urlController.text
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
