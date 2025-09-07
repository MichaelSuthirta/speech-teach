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
  int isCorrect = -1;
  late Map<String, dynamic> result;
  Color correctDisplayColor = Color.fromRGBO(191, 242, 152, 1);
  Color wrongDisplayColor = Color.fromRGBO(255, 157, 139, 100);
  late String assessmentRes;
  late String explanation;
  late Color displayerColor;
  late Color? explanationColor;

  @override
  void initState(){
    super.initState();
    assessmentRes = '';
    explanation = '';
  }

  void setValues(){
    if(isCorrect == 1){
      displayerColor = correctDisplayColor;
      assessmentRes = 'Correct';
      explanation = 'Your word is detected as ${result['Result']}';
      explanationColor = null;
    }
    else if(isCorrect == 0){
      displayerColor = wrongDisplayColor;
      assessmentRes = 'Try again...';
      explanation = 'Your word is detected as ${result['Result']}';
      explanationColor = const Color.fromRGBO(255, 251, 241, 1);
    }
  }

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 15, 8, 0),
      child: ListenableBuilder(
        listenable: widget.processor,
        builder: (BuildContext context, Widget? child){
          String transcribedWord = widget.processor.getTranscribeResult();
          if(transcribedWord == '-1'){
            return Container();
          }

          result = widget.processor.getResult();
          isCorrect = result['Assessment Result'];
          setValues();

          // return Text(widget.processor.getTranscribeResult());
          return Container(
            width: double.infinity,
            height: 165,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: displayerColor,
                borderRadius: BorderRadius.all(Radius.circular(25))
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(7, 12, 7, 0),
                child: Column(
                  children: [
                    LargeText(word: assessmentRes, size: 40),
                    SmallText(sentence: explanation, size: 20, color: explanationColor)
                  ],
                ),
              )
            )
          );
        },
      )
    );
  }
}