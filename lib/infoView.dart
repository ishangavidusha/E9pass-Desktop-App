import 'package:e9pass_desktop/const/appConst.dart';
import 'package:flutter/material.dart';

class InfoView extends StatefulWidget {
  @override
  _InfoViewState createState() => _InfoViewState();
}

class _InfoViewState extends State<InfoView> {
  AppColors appColors = AppColors();
  List<Map<int, String>> images = [
    {0 : "https://i.ibb.co/fpDTPSD/0001.jpg"},
    {1 : "https://i.ibb.co/Fw3TRFQ/0002.jpg"},
    {2 : "https://i.ibb.co/jksYB30/0003.jpg"},
    {3 : "https://i.ibb.co/WV7270G/0004.jpg"},
    {4 : "https://i.ibb.co/YNSM3td/0005.jpg"},
    {5 : "https://i.ibb.co/vBPwSL1/0006.jpg"},
    {6 : "https://i.ibb.co/2dV8HYh/0007.jpg"},
    {7 : "https://i.ibb.co/gMGQTbD/0008.jpg"},
    {8 : "https://i.ibb.co/9NbNLdB/0009.jpg"},
    {9 : "https://i.ibb.co/nbWs5zw/0010.jpg"},
    {10 : "https://i.ibb.co/4J6dS78/0011.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    double devWidth = MediaQuery.of(context).size.width;
    double devHeight = MediaQuery.of(context).size.height;
    return Container(
      width: devWidth - 200,
      height: devHeight - 100,
      child: ListView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(10),
            child: Image.network(images[index][index]),
          );
        },
      )
    );
  }
}