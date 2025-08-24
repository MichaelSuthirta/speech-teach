import 'package:flutter/material.dart';

class WordDisplay extends StatelessWidget{
  final String word;

   const WordDisplay({
    super.key,
    required this.word
  });

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Text(
        word,
        style: const TextStyle(
            fontFamily: "Concert One",
            fontSize: 42,
            color: Color.fromRGBO(61, 52, 139, 1.0)
        ),
      ),
    );
  }
}