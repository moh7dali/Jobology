import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNewTraining extends StatefulWidget {
  AddNewTraining({Key? key}) : super(key: key);

  @override
  State<AddNewTraining> createState() => _AddNewTrainingState();
}

class _AddNewTrainingState extends State<AddNewTraining> {
  @override
  Widget build(BuildContext context) {
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
                // controller: ,
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
                // controller: ,
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
                // controller: ,
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: OutlinedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 5, 108, 106),
                    shape: RoundedRectangleBorder(),
                    padding: EdgeInsets.symmetric(vertical: 15)),
                onPressed: () {},
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
