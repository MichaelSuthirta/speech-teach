import 'package:flutter/material.dart';
import '/Tools/AudioProcessor.dart';
import '/UI/Texts/LargeText.dart';
import '/UI/Texts/SmallText.dart';

class ResultDisplayer extends StatefulWidget{
  final AudioProcessor processor;
  const ResultDisplayer({super.key, required this.processor});

  @override
  State<ResultDisplayer> createState() => _ResDisplayState();
}

class _ResDisplayState extends State<ResultDisplayer>{
  String actualWord = '';
  String detectedWord = '';
  int correct = -1;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.fromLTRB(8, 15, 8, 0),
      child: ListenableBuilder(
        listenable: widget.processor,
        builder: (BuildContext context, Widget? child){
          String transcribedWord = widget.processor.getResult();
          if(transcribedWord == '-1'){
            // Code for text boxes, moved later
            return Container(
              width: double.infinity,
              height: 175,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(191, 242, 152, 1),
                  borderRadius: BorderRadius.all(Radius.circular(25))
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: Column(
                    children: [
                      LargeText(word: 'Correct', size: 40),
                      SmallText(sentence: 'Your word is detected as [word]', size: 20)
                    ],
                  ),
                )
              )
            );
          }
          return Text('${widget.processor.getResult()}');
        },
      )
    );
  }
}