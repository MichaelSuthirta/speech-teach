import 'package:flutter/material.dart';
import '/Tools/AudioProcessor.dart';
import '/Tools/Recorder.dart';

class RecordButton extends StatefulWidget{
  final AudioProcessor processor;
  const RecordButton({super.key, required this.processor});

  @override
  State<RecordButton> createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton>{
  final String recStart = "assets/UI/Buttons/MicOnBtn.png";
  final String recStop = "assets/UI/Buttons/MicOffBtn.png";
  final AudioProcessor processor = AudioProcessor();
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
      widget.processor.resetFileData();
    }
    else{
      setState(() {
        currentIconPath = recStart;
        isRecording = false;
      });
      List<String> fileData = await Recorder.stopRecord();
      widget.processor.resetFileData();
      widget.processor.setData(fileData);
      widget.processor.assessAudio();
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
          if(widget.processor.getActualWord() == ''){
            null;
          }
          else{
            record();
            print("Clicked record");
          }
        },
      )
    );
  }
}