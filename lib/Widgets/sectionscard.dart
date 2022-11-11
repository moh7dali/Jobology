import 'package:flutter/material.dart';
import 'package:jobology/constants.dart';

class SectionsCard extends StatelessWidget {
  SectionsCard({
    this.CardTitle,
    this.CardSubTitle,
    this.ImageName,
    required this.OnTapping,
  });
  String? CardTitle;
  String? CardSubTitle;
  Function() OnTapping;
  String? ImageName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: OnTapping,
      child: Container(
        height: 250,
        width: 160,
        decoration: BoxDecoration(
          boxShadow: kElevationToShadow[1],
          image: DecorationImage(
            image: AssetImage("${ImageName}"),
            fit: BoxFit.contain,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ListTile(
              title: Text(
                "${CardTitle}",
                style: const TextStyle(
                  fontSize: subTitleSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  "${CardSubTitle}",
                  style: TextStyle(
                    fontSize: ParagraphSize,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
