import 'package:flutter/material.dart';
import 'package:speech_teach/UI/Texts/TextDisplayer.dart';

class LargeText extends TextDisplayer{
  final String word;
  final double size;

   const LargeText({
     super.key,
     required this.word,
     required this.size
   }) : super(
     word: word,
     size: size,
     topPad: 0,
     botPad: 5,
     font: "Concert One",
     textColor: const Color.fromRGBO(61, 52, 139, 1.0)
   );
}