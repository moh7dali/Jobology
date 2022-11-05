import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNewJob extends StatefulWidget {
  AddNewJob({Key? key}) : super(key: key);

  @override
  State<AddNewJob> createState() => _AddNewJobState();
}

class _AddNewJobState extends State<AddNewJob> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            child: ListView(
              children: [
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
                /*
                url 
                 */
              ],
            ),
          ),
        ),
      ),
    );
  }
}
