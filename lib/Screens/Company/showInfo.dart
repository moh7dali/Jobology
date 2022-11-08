import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jobology/Screens/Users/peronalPage/personalpage.dart';

class Show_info extends StatefulWidget {
  Show_info({this.doc_id, this.type});
  String? doc_id;
  String? type;
  @override
  State<Show_info> createState() => _Show_infoState();
}

class _Show_infoState extends State<Show_info> {
  List Applied = [];
  String name = "";
  @override
  Widget build(BuildContext context) {
    if (widget.type == "Training") {
      FirebaseFirestore.instance
          .collection('Training')
          .doc(widget.doc_id)
          .snapshots()
          .listen((event) {
        setState(() {
          Applied = event['Applied'];
        });
      });
    } else if (widget.type == "Jobs") {
      FirebaseFirestore.instance
          .collection('Jobs')
          .doc(widget.doc_id)
          .snapshots()
          .listen((event) {
        setState(() {
          Applied = event['Applied'];
        });
      });
    }
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;
            return Padding(
              padding: EdgeInsets.all(10),
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  for (int i = 0; i < Applied.length; i++) {
                    if (docs[index].id == Applied[i]) {
                      return ListTile(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return personalInfo(
                                user_id: Applied[i],
                              );
                            },
                          ));
                        },
                        title: Text(docs[index]['Fullname']),
                        subtitle: Text(docs[index]['major']),
                        leading: Image.network(docs[index]['img']),
                      );
                    }
                  }
                  return Container();
                },
              ),
            );
          } else if (snapshot.hasError) {
            const Text('No data avaible right now');
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
