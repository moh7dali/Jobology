import 'package:flutter/material.dart';

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
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "${CardSubTitle}",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
