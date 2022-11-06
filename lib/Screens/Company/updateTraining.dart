import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Update_training extends StatefulWidget {
  Update_training(
      {this.imageUrl,
      this.title,
      this.breif,
      this.url,
      this.years,
      this.price,
      this.docnid});
  String? title;
  String? imageUrl;
  String? breif;
  String? price;
  String? years;
  String? url;
  dynamic docnid;

  @override
  State<Update_training> createState() => _Update_trainingState();
}

class _Update_trainingState extends State<Update_training> {
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: widget.title);
    TextEditingController briefController =
        TextEditingController(text: widget.breif);
    TextEditingController yearController =
        TextEditingController(text: widget.years);
    TextEditingController priceController =
        TextEditingController(text: widget.price);
    TextEditingController urlController =
        TextEditingController(text: widget.url);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
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
                    backgroundColor: Color.fromARGB(255, 5, 108, 106),
                    shape: RoundedRectangleBorder(),
                    padding: EdgeInsets.symmetric(vertical: 15)),
                onPressed: () {
                  FirebaseFirestore.instance
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
