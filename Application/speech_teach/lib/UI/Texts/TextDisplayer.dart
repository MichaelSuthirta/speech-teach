import 'package:flutter/material.dart';

abstract class TextDisplayer extends StatelessWidget{
  final String word;
  final double size;
  final String font;
  final double topPad;
  final double botPad;
  final Color textColor;

   const TextDisplayer({
    super.key,
    required this.word,
    required this.size,
    required this.font,
    required this.topPad,
    required this.botPad,
    required this.textColor
  });

  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.fromLTRB(0, topPad, 0, botPad),
      child: Text(
        word,
        style: TextStyle(
            fontFamily: font,
            fontSize: size,
            color: textColor
        ),
      ),
    );
  }
}