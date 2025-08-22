import 'package:record/record.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Recorder{
  var recorder = AudioRecorder();
  late String filename;

  void setFileName(String expectedWord){
    if(expectedWord.isNotEmpty){
      filename = 'Record_$expectedWord.m4a';
    }
    else{
      filename = 'VoiceRecord.m4a';
    }
  }

  void printFileName(){
    print(filename);
  }

  void startRecord() async{
    final appDocsDirectory = await getApplicationDocumentsDirectory();
    String filePath = join(appDocsDirectory.toString(), filename);
    if(await recorder.hasPermission()){
      recorder.start(const RecordConfig(), path: filePath);
    }
  }

  Future<String> stopRecord() async{
    String? nullablePath = await recorder.stop();
    String path = nullablePath ?? '';
    recorder.dispose();
    return path;
  }
}