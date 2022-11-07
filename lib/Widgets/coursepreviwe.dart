// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

import 'mytext.dart';
import '../Screens/Users/course.dart';

class Course_previwe extends StatefulWidget {
  Course_previwe(
      {this.imageUrl,
      this.company_name,
      this.title,
      this.breif,
      this.url,
      this.price,
      this.docnid});
  String? company_name;
  String? title;
  String? imageUrl;
  String? breif;
  String? price;
  String? url;
  dynamic docnid;

  @override
  State<Course_previwe> createState() => _Course_previweState();
}

class _Course_previweState extends State<Course_previwe> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.infinity,
        child: Stack(children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: 320,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.imageUrl!), fit: BoxFit.cover),
                ),
              )),
          Positioned(
            top: 30,
            left: 15,
            child: Container(
                child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
            )),
          ),
          Positioned(
              top: 300,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                width: MediaQuery.of(context).size.width,
                height: height * 0.7,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                          text: widget.title,
                          size: 40,
                          mycolor: Colors.black54.withOpacity(0.9),
                        ),
                        MyText(
                            text: "${widget.price}" + "\$",
                            size: 30,
                            mycolor: Colors.black12.withOpacity(0.7))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.blue,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        MyText(
                          text: "Amman-Jordan",
                          size: 16,
                          mycolor: Colors.blue.withOpacity(0.8),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    MyText(
                      text: "Provider",
                      size: 30,
                      mycolor: Colors.black.withOpacity(0.9),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    ListTile(
                        trailing: Image(image: NetworkImage(widget.imageUrl!)),
                        title: MyText(
                          text: widget.company_name,
                          size: 20,
                          mycolor: Colors.black54.withOpacity(0.9),
                        ),
                        subtitle: MyText(
                            text: widget.breif,
                            size: 14,
                            mycolor: Colors.black54.withOpacity(0.8))),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: height * 0.2, left: 130),
                        child: MaterialButton(
                          height: 60,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          color: Colors.purple,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Course()));
                          },
                          child: const Text(
                            "Get Started",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                        )),
                  ],
                ),
              ))
        ]),
      ),
    );
  }
}
