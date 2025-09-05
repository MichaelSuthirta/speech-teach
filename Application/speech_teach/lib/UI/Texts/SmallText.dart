import 'package:flutter/material.dart';
import 'package:speech_teach/UI/Texts/TextDisplayer.dart';

class SmallText extends TextDisplayer{
  final String sentence;
  final double size;

  const SmallText({
    super.key,
    required this.sentence,
    required this.size
  }) : super(
      word: sentence,
      size: size,
      topPad: 5,
      botPad: 0,
      font: "Consolas",
      textColor: const Color.fromRGBO(118, 120, 237, 1.0)
  );

  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.fromLTRB(0, topPad, 0, botPad),
      child: Text(
        sentence,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: TextStyle(
            fontFamily: "Consolas",
            fontSize: size,
            color: textColor
        ),
      )
    );
  }
}