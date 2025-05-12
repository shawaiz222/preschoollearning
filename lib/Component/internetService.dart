import 'package:http/http.dart' as http;

class InternetCheckService {
  static Future<bool> isInternetAvailable() async {
    try {
      final response = await http
          .get(Uri.parse('https://example.com'))
          .timeout(const Duration(seconds: 5));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
