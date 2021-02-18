import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this._url);

  final String _url;

  Future<dynamic> getData() async {
    final http.Response response = await http.get(_url);

    if (response.statusCode == 200) {
      final String data = response.body;

      return jsonDecode(data);
    } else {
      // ignore: avoid_print
      print(response.statusCode);
      return null;
    }
  }
}
