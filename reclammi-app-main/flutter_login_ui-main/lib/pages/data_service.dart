import 'dart:convert';
import 'package:http/http.dart' as http;
import 'config.dart';
Future<int> tyy(String filterType) async {
  // Assuming `cat` is defined somewhere
  List? complaints;
  var reqBody = {
    "filterType": filterType
  };
  var responce = await http.post(Uri.parse(complaintA),
      headers: {"content-type": "application/json"},
      body: jsonEncode(reqBody));
  print('Response status code: ${responce.statusCode}');
  print('Response status message: ${responce.reasonPhrase}');
  print('Response body: ${responce.body}');

  var jsonResponse = jsonDecode(responce.body);
  print(jsonResponse);
  print(jsonResponse['success']);
  complaints= jsonResponse['success'];
  return complaints!.length;
}

