import 'dart:io';

import 'package:http/http.dart' as http;

class HttpClient {
  static void post(Uri uri, String jsonBody) async {
    // var url = Uri.parse('https://example.com/whatsit/create');
    var headers = <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
    };
    var response = await http.post(uri, body: jsonBody, headers: headers);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}
