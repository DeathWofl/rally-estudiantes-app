import 'package:http/http.dart' as http;

class Server {

  static const String URL = '10.0.0.10:1323';
  static var client = http.Client();

  static Map<String, String> getHeader(String token) {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $token",
    };

    return headers;
  }
}