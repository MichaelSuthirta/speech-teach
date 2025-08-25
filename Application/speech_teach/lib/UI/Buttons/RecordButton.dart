import 'package:flutter/material.dart';
import 'package:speech_teach/Tools/BackendConnector.dart';
import '/Tools/Recorder.dart';

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

  void record() async{
    if(!isRecording){
      setState(() {
        currentIconPath = recStop;
        isRecording = true;
      });
      Recorder.startRecord();
    }
    else{
      setState(() {
        currentIconPath = recStart;
        isRecording = false;
      });
      List<String> fileData = await Recorder.stopRecord();
      BackendConnector.sendAudio(fileData);
    }
  }

  @override
  Widget build(BuildContext context){
    return SizedBox(
      width: 80,
      height: 80,
      child: IconButton(
        splashRadius: 110,
        splashColor: Colors.black,
        icon: Image(image: AssetImage(currentIconPath)),
        onPressed: () async{
          record();
          print("Clicked record");
          },
      )
    );
  }
}