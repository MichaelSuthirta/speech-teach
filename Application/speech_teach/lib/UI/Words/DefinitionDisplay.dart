import 'package:flutter/material.dart';

class DefinitionDisplay extends StatelessWidget{
  final String sentence;

  const DefinitionDisplay({
    super.key,
    required this.sentence
  });

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: Text(
        sentence,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: const TextStyle(
            fontFamily: "Consolas",
            fontSize: 24,
            color: Color.fromRGBO(118, 120, 237, 1.0)
        ),
      )
    );
  }
}