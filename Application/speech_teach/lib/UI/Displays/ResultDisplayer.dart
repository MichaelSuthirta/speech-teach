import 'package:flutter/material.dart';
import '/Tools/AudioProcessor.dart';

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
      child: ListenableBuilder(
        listenable: widget.processor,
        builder: (BuildContext context, Widget? child){
          String transcribedWord = widget.processor.getResult();
          if(transcribedWord == '-1'){
            return Container();
          }
          return Text('${widget.processor.getResult()}');
        },
      )
    );
  }
}