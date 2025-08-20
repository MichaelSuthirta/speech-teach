import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> fetchWords() async{
  String androidStudioIPPort = "10.0.2.2:5000";
  var response = await http.get(Uri.parse("http://${androidStudioIPPort}/word"));
  return jsonDecode(response.body) as Map<String, dynamic>;
}