import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '/Tools/AudioProcessor.dart';
import '/UI/Texts/LargeText.dart';
import '/UI/Texts/SmallText.dart';

class ResultDisplayer extends StatefulWidget{
  final AudioProcessor processor;
  final AudioPlayer audioPlayer = AudioPlayer();
  ResultDisplayer({super.key, required this.processor});

  @override
  State<ResultDisplayer> createState() => _ResDisplayState();
}

class _ResDisplayState extends State<ResultDisplayer>{
  int isCorrect = -1;
  late Map<String, dynamic> result;
  Color correctDisplayColor = const Color.fromRGBO(191, 242, 152, 1);
  Color wrongDisplayColor = const Color.fromRGBO(255, 157, 139, 100);
  late String assessmentRes;
  late String explanation;
  late Color displayerColor;
  late Color? explanationColor;
  late String? audioPath;

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
      audioPath = 'audio/CorrectAnswer.mp3';
    }
    else if(isCorrect == 0){
      displayerColor = wrongDisplayColor;
      assessmentRes = 'Try again...';
      explanation = 'Your word is detected as ${result['Result']}';
      explanationColor = const Color.fromRGBO(255, 251, 241, 1);
      audioPath = 'audio/WrongAnswer.mp3';
    }
    else{
      audioPath == null;
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
          List<String> fileData = widget.processor.getData();
          if(transcribedWord == '-1' && fileData == ['','']){
            return Container(child: null);
          }

          else if(transcribedWord == '-1' && fileData != ['','']){
            return Container(
              child: CircularProgressIndicator(),
            );
          }

          result = widget.processor.getResult();
          isCorrect = result['Assessment Result'];
          setValues();

          if(audioPath != null){
            widget.audioPlayer.play(AssetSource(audioPath!));
          }

          // return Text(widget.processor.getTranscribeResult());
          return SizedBox(
            width: double.infinity,
            height: 165,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: displayerColor,
                borderRadius: const BorderRadius.all(Radius.circular(25))
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(7, 12, 7, 0),
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