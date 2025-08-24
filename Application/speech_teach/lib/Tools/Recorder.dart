import 'package:record/record.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Recorder{
  static final recorder = AudioRecorder();
  static late String filename;

  static void setFileName(String expectedWord){
    if(expectedWord.isNotEmpty){
      filename = 'Record_$expectedWord.m4a';
    }
    else{
      filename = 'VoiceRecord.m4a';
    }
  }

  static void printFileName(){
    print(filename);
  }

  static void startRecord() async{
    if(!await Permission.manageExternalStorage.isGranted){
      Permission.manageExternalStorage.request();
    }
    final appStorageDirectory = await getExternalStorageDirectory() ?? await getApplicationDocumentsDirectory();
    String filePath = join(appStorageDirectory.path, filename);
    // String filePath = join(appDocsDirectory.toString(), filename);
    if(await recorder.hasPermission()){
      print("Recording starts. Permission: ${await recorder.hasPermission()}");
      await recorder.start(const RecordConfig(), path: filePath);
    }
    print("Permission: ${await recorder.hasPermission()}");
  }

  static Future<String> stopRecord() async{
    print("Recording status: ${await recorder.isRecording()}");
    String? nullablePath = await recorder.stop();
    print('Recording has stopped');
    String path = nullablePath ?? '';
    print(path);
    recorder.dispose();
    return path;
  }
}