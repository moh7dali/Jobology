import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Welcome_widget extends StatefulWidget {
  Welcome_widget(
      {this.height, this.title, this.Subtitle, this.img_url, this.num});
  double? height;
  String? title;
  String? Subtitle;
  String? num;
  String? img_url;
  @override
  State<Welcome_widget> createState() => _Welcome_widgetState();
}

class _Welcome_widgetState extends State<Welcome_widget> {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Image(
        image: AssetImage('${widget.img_url}'),
        height: widget.height! * 0.4,
      ),
      Column(
        children: [
          Text(
            "${widget.title}",
            style: GoogleFonts.montserrat(
                fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "${widget.Subtitle}",
            style:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      Text(
        "${widget.num}",
        style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 80.0,
      )
    ]);
  }
}
