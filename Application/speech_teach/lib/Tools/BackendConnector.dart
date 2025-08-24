import 'package:http/http.dart' as http;
import 'dart:convert';

class BackendConnector{
  static String androidStudioIPPort = "10.0.2.2:5000";
  static String ipAddressPort = "192.168.1.7:5000";
  static String localHostPort = "127.0.0.1:5000";

  static Future<Map<String, dynamic>> fetchWords() async {
    var response = await http.get(
        Uri.parse("http://${ipAddressPort}/word")
    );
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  static void sendAudio(String filePath) async{
    await http.post(
      Uri.parse("http://${ipAddressPort}/assess"),
      body: jsonEncode({"filePath" : filePath})
    );
    getTranscribedWord();
  }

  static void getTranscribedWord() async{
    var response = await http.get(Uri.parse("http://${ipAddressPort}/assess"));
    var result = jsonDecode(response.body) as Map<String, dynamic>;
    print(result["Transcription"]);
  }
}
