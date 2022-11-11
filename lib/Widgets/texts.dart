// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jobology/constants.dart';
import 'package:readmore/readmore.dart';

class Cvt1 extends StatelessWidget {
  const Cvt1({super.key});

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      style: TextStyle(fontSize: subTitleSize),
      "A CV—short for the Latin “curriculum vitae,” meaning “course of life”—is a detailed document highlighting your professional and academic history. CVs typically include information such as your work experience, along with your achievements, awards, scholarships or grants you’ve earned, coursework, research projects and publications of your work. A CV is typically two or three pages long, but it’s not unusual for it to be much longer for mid-level or senior job applicants as a CV serves as a full outline of one’s career accomplishments.",
      trimLines: 5,
      colorClickableText: containerBackgroun,
      trimMode: TrimMode.Line,
      trimCollapsedText: '  Read more',
      trimExpandedText: '  Less',
      moreStyle: TextStyle(
        fontSize: subTitleSize,
      ),
      textAlign: TextAlign.left,
    );
  }
}

class Cvt2 extends StatelessWidget {
  const Cvt2({super.key});

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      style: TextStyle(fontSize: subTitleSize),
      "A resume is a formal document providing an overview of your professional background and relevant skills. Standard sections on a resume include your work history, education, a professional summary, and a list of your skills. The three resume formats are reverse chronological, functional and combined.",
      trimLines: 5,
      colorClickableText: containerBackgroun,
      trimMode: TrimMode.Line,
      trimCollapsedText: '  Read more',
      trimExpandedText: '  Less',
      moreStyle: TextStyle(
        fontSize: subTitleSize,
      ),
      textAlign: TextAlign.left,
    );
  }
}

class Cvt3 extends StatelessWidget {
  const Cvt3({super.key});

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      style: TextStyle(fontSize: subTitleSize),
      "A CV—short for the Latin “curriculum vitae,” meaning “course of life”—is a detailed document highlighting your professional and academic history. CVs typically include information such as your work experience, along with your achievements, awards, scholarships or grants you’ve earned, coursework, research projects and publications of your work. A CV is typically two or three pages long, but it’s not unusual for it to be much longer for mid-level or senior job applicants as a CV serves as a full outline of one’s career accomplishments.",
      trimLines: 5,
      colorClickableText: containerBackgroun,
      trimMode: TrimMode.Line,
      trimCollapsedText: '  Read more',
      trimExpandedText: '  Less',
      moreStyle: TextStyle(
        fontSize: subTitleSize,
      ),
      textAlign: TextAlign.left,
    );
  }
}

class Cvt4 extends StatelessWidget {
  const Cvt4({super.key});

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      style: TextStyle(fontSize: subTitleSize),
      "While most CV documents share the same basic structure and format,the organization and content of a CV depends on the type of position you apply for.\n When organizing your CV, list the most relevant sections first to catch an employer's attention, whether that is your work history or an impressive list of publications. Heres a CV template to reference when creating your own:",
      trimLines: 5,
      colorClickableText: containerBackgroun,
      trimMode: TrimMode.Line,
      trimCollapsedText: '  Read more',
      trimExpandedText: '  Less',
      moreStyle: TextStyle(
        fontSize: subTitleSize,
      ),
      textAlign: TextAlign.left,
    );
  }
}
