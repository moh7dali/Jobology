import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jobology/Screens/Company/update.dart';

class CompanyHome extends StatefulWidget {
  CompanyHome({Key? key}) : super(key: key);

  @override
  State<CompanyHome> createState() => _CompanyHomeState();
}

class _CompanyHomeState extends State<CompanyHome> {
  String comp_name = "";
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      setState(() {
        comp_name = event['Fullname'];
      });
    });
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Jobs').snapshots(),
        builder: (context, snapshot) {
          final docs = snapshot.data!.docs;
          return Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                if (comp_name == docs[index]['Company name']) {
                  return ListTile(
                    title: Text(docs[index]['Company name']),
                    subtitle: Text(docs[index]['job_title']),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text(docs[index]['job_title']),
                          actions: <Widget>[
                            Column(
                              children: [
                                Text(docs[index]['breif']),
                                Text(docs[index]['years']),
                                Text(docs[index]['requirements']),
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection('Jobs')
                                            .doc(docs[index].id)
                                            .delete();
                                      },
                                      child: Container(
                                        color: Colors.green,
                                        padding: const EdgeInsets.all(14),
                                        child: Icon(Icons.delete),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return Update_job(
                                              title: docs[index]['job_title'],
                                              breif: docs[index]['breif'],
                                              req: docs[index]['requirements'],
                                              years: docs[index]['years'],
                                              url: docs[index]['url'],
                                              docnid: docs[index].id,
                                            );
                                          },
                                        ));
                                      },
                                      child: Container(
                                        color: Colors.green,
                                        padding: const EdgeInsets.all(14),
                                        child: Icon(Icons.edit),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else
                  return Container();
              },
            ),
          );
        },
      ),
      floatingActionButton: SpeedDial(
          spaceBetweenChildren: 15,
          child: Icon(Icons.add),
          backgroundColor: Color.fromARGB(255, 61, 14, 70),
          children: [
            SpeedDialChild(
              child: Icon(Icons.shopping_bag),
              label: 'Add new job',
              onTap: () {
                Navigator.pushNamed(context, "addNewPage");
              },
            ),
            SpeedDialChild(
              child: Icon(Ionicons.document_outline),
              label: 'Add new training',
              onTap: () {
                Navigator.pushNamed(context, "addNewTraining");
              },
            ),
          ]),
    );
  }
}
