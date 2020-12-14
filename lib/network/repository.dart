import 'dart:io';

import 'package:http/http.dart' as http;

class Repository {
  static Future<String> loadJson({
    String filePath,
    String url,
    Map<String, String> headers,
  }) async {
    if (filePath != null) return _getLocalDocumentation(filePath);
    return _getRemoteDocumentation(url, headers);
  }

  static Future<String> _getLocalDocumentation(String path) async {
    if (!await File(path).exists()) throw Exception('invalid $path');

    final file = File(path);
    final json = await file.readAsString();

    return json;
  }

  static Future<String> _getRemoteDocumentation(
    String url,
    Map<String, String> headers,
  ) async {
    final response = await http.get(url, headers: headers);
    if (response.statusCode != 200) throw Exception('${response.statusCode}');

    return response.body;
  }
}
