import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

class BackendConnector{
  static String androidStudioIPPort = "10.0.2.2:5000";
  static String ipAddressPort = "192.168.1.7:5000";
  static String localHostPort = "127.0.0.1:5000";

  static String activePort = ipAddressPort;

  static Future<Map<String, dynamic>> fetchWords() async {
    var response = await http.get(
        Uri.parse("http://${activePort}/word")
    );
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  static void sendAudio(List<String> fileData) async{
    var uri = Uri.parse("http://${activePort}/assess");
    var request = new http.MultipartRequest("POST", uri);

    String filePath = fileData[0];
    String fileName = fileData[1];

    request.files.add(new http.MultipartFile.fromBytes(
      'file',
      await File(filePath).readAsBytes(),
      filename: fileName
    ));

    request.send().then((response){
      if(response.statusCode == 200) {
        print("Successfully sent file.");
      }
    });

    getTranscribedWord();

    // await http.post(
    //   uri,
    //   body: jsonEncode({"filePath" : filePath})
    // );
  }

  static void getTranscribedWord() async{
    var response = await http.get(Uri.parse("http://${activePort}/assess"));
    var result = jsonDecode(response.body) as Map<String, dynamic>;
    // print(result["Transcription"]);
    print(result);
  }
}
