import 'package:flutter/material.dart';

class RecordButton extends StatefulWidget{
  const RecordButton({super.key});

  @override
  State<RecordButton> createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton>{
  final String recStart = "assets/UI/Icons/MicOnBtn.png";
  final String recStop = "assets/UI/Icons/MicOffBtn.png";
  bool isRecording = false;

  String currentIconPath = '';

  @override
  void initState(){
    super.initState();
    currentIconPath = recStart;
    isRecording = false;
  }

  void record(){
    if(!isRecording){
      setState(() {
        currentIconPath = recStop;
        isRecording = true;
      });
    }
    else{
      setState(() {
        currentIconPath = recStart;
        isRecording = false;
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return SizedBox(
      width: 120,
      height: 120,
      child: IconButton(
        splashRadius: 110,
        splashColor: Colors.black,
        icon: Image(image: AssetImage(currentIconPath)),
        onPressed: (){
          record();
          print("Clicked record");
          },
      )
    );
  }
}