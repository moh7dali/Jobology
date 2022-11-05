import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobology/Screens/buttonnav.dart';

class personalInfo extends StatefulWidget {
  const personalInfo({super.key});

  @override
  State<personalInfo> createState() => _personalInfoState();
}

class _personalInfoState extends State<personalInfo> {
  Icon Icon1 = Icon(
    Icons.thumb_up,
    color: Colors.blue,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 410,
              height: 300,
              color: Colors.white,
              child: Stack(children: [
                Container(
                  width: 410,
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://www.incimages.com/uploaded_files/image/1920x1080/getty_509107562_2000133320009280346_351827.jpg"),
                        fit: BoxFit.cover),
                    // borderRadius: BorderRadius.only(
                    //     bottomLeft: Radius.circular(100),
                    //     bottomRight: Radius.circular(100))
                  ),
                ),
                Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: CircleAvatar(
                      radius: 50,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://pbs.twimg.com/profile_images/669103856106668033/UF3cgUk4_400x400.jpg"),
                            ),
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ))
              ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 130,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Jeff Bezos",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                SizedBox(
                  width: 80,
                ),
                IconButton(
                    onPressed: () {
                      if (Icon1.toString() ==
                          (Icon(
                            Icons.thumb_up,
                            color: Colors.blue,
                          )).toString()) {
                        setState(() {
                          Icon1 = Icon(
                            Icons.thumb_down,
                            color: Colors.blue,
                          );
                        });
                      } else {
                        setState(() {
                          Icon1 = Icon(
                            Icons.thumb_up,
                            color: Colors.blue,
                          );
                        });
                      }
                    },
                    icon: Icon(Icon1.icon))
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "owner of amazon",
                style: TextStyle(fontWeight: FontWeight.w200, fontSize: 20),
              ),
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Accounts:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                )),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              IconButton(
                onPressed: () {},
                icon: Icon(FontAwesomeIcons.twitter),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(FontAwesomeIcons.instagram),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(FontAwesomeIcons.linkedin),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.facebook),
              ),
            ]),
            Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "About Me",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
            Align(
              alignment: Alignment.center,
              child: Container(
                  child: Text(
                "Born in Albuquerque and raised in Houston and Miami, Bezos graduated from Princeton University in 1986. He holds a degree in  electrical engineering and computer science",
                style: TextStyle(fontSize: 20),
              )),
            )
          ],
        ),
      )),
    );
  }
}
