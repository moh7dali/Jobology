// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:jobology/Widgets/bottun.dart';
import '../Widgets/mytext.dart';

class Course_previwe extends StatefulWidget {
  const Course_previwe({super.key});

  @override
  State<Course_previwe> createState() => _Course_previweState();
}

class _Course_previweState extends State<Course_previwe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: 320,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/cp.webp"), fit: BoxFit.cover),
                ),
              )),
          Positioned(
            top: 30,
            left: 15,
            child: Container(
                child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
              color: Colors.white,
            )),
          ),
          Positioned(
              top: 300,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                width: MediaQuery.of(context).size.width,
                height: 400,
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
                          text: "Flutter",
                          size: 40,
                          mycolor: Colors.black54.withOpacity(0.9),
                        ),
                        MyText(
                            text: "\$ Free",
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
                        trailing:
                            const Image(image: AssetImage("images/ltuc.jpg")),
                        title: MyText(
                          text: "LTUC",
                          size: 20,
                          mycolor: Colors.black54.withOpacity(0.9),
                        ),
                        subtitle: MyText(
                            text:
                                "An existing technical university that offers many specializations and training courses,/n especially information technology programs",
                            size: 14,
                            mycolor: Colors.black54.withOpacity(0.8))),
                    const SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: Bottun_Navigater(),
                    )
                  ],
                ),
              ))
        ]),
      ),
    );
  }
}
