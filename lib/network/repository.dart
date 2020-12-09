import 'package:http/http.dart' as http;

class Repository {
  static Future<String> loadJson(String url) async {
    final response = await http.get(url);
    if (response.statusCode != 200) throw Exception('${response.statusCode}');

    return response.body;
  }
}
