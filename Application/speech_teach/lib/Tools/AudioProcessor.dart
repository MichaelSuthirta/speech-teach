import '/Tools/BackendConnector.dart';

class AudioProcessor{
  static late Map<String, dynamic> assessmentResult;

  static void assessAudio(List<String> fileData) async{
    assessmentResult = await BackendConnector.assess(fileData);
  }

  static Map<String, dynamic> getResult(){
    return assessmentResult;
  }
}