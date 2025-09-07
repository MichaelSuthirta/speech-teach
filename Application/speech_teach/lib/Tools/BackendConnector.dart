import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

class BackendConnector{
  static String androidStudioIPPort = "10.0.2.2:5000";
  static String ipAddressPort = "192.168.1.7:5000";
  static String ipAddressPort2 = "192.168.0.103:5000";
  static String localHostPort = "127.0.0.1:5000";

  static String activePort = ipAddressPort2;

  static Future<Map<String, dynamic>> fetchWords() async {
    var response = await http.get(
        Uri.parse("http://${activePort}/word")
    );
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> assess(List<String> fileData, String actualWord) async{
    var uri = Uri.parse("http://${activePort}/assess");
    var request = http.MultipartRequest("POST", uri);

    print("Actual word: $actualWord");

    String filePath = fileData[0];
    String fileName = fileData[1];

    request.files.add(http.MultipartFile.fromBytes(
      'file',
      await File(filePath).readAsBytes(),
      filename: fileName
    ));

    request.fields.addAll(
        {
          "actualWord": actualWord
        }
    );

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}
