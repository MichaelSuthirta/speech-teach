import 'package:flutter/material.dart';
import '/Tools/BackendConnector.dart';

class AudioProcessor extends ChangeNotifier{
  late String actualWord;
  late List<String> audioData;
  Map<String, dynamic> assessmentResult = {'Result' : '-1'};

  void setActualWord(String word){
    actualWord = word;
  }

  void setData(List<String> fileData){
    audioData = fileData;
  }

  void assessAudio() async{
    assessmentResult = await BackendConnector.assess(audioData, actualWord);
    notifyListeners();
  }

  String getTranscribeResult() {
    return assessmentResult['Result'];
  }

  Map<String, dynamic> getResult(){
    return assessmentResult;
  }

  void resetResultContent(){
    assessmentResult = {'Result':'-1'};
    notifyListeners();
  }
}