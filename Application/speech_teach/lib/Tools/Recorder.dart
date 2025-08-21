import 'package:record/record.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Recorder{
  var recorder = AudioRecorder();

  void startRecord(String expectedWord) async{
    final appDocsDirectory = await getApplicationDocumentsDirectory();
    String filePath = join(appDocsDirectory.toString(), 'Record_{$expectedWord}.m4a');
    if(await recorder.hasPermission()){
      recorder.start(const RecordConfig(), path: filePath);
    }
  }

  Future<String?> stopRecord() async{
    return await recorder.stop();
  }
}