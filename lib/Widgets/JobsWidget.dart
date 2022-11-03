import 'package:flutter/material.dart';

class ListTaleW extends StatefulWidget {
  ListTaleW(
      { required this.imageUrl, required this.subTitle, required this.name});
  String? name;
  
  String? imageUrl;
  String? subTitle;
  @override
  State<ListTaleW> createState() => _ListTaleWState();
}

class _ListTaleWState extends State<ListTaleW> {
  void nav() {
    Navigator.pushNamed(context, "jobInfo");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: nav,
        child: ListTile(
          leading: Container(width:80 ,height: 80,
            child: Image.asset(widget.imageUrl!),
          ),
          trailing: Icon(Icons.work,color: Colors.white,),
          title: Text(widget.name!,style: TextStyle(color: Colors.white),),
          subtitle: Text(widget.subTitle!,style: TextStyle(color: Colors.white)),
        ));
  }
}
