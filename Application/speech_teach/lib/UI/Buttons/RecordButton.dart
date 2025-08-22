import 'package:flutter/material.dart';
import '/Tools/Recorder.dart';

class RecordButton extends StatefulWidget{
  final Recorder recorder;
  const RecordButton({super.key, required this.recorder});

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
        widget.recorder.startRecord();
      });
    }
    else{
      setState(() async {
        currentIconPath = recStart;
        isRecording = false;
        String filePath = await widget.recorder.stopRecord();
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