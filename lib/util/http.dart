import 'dart:convert';

import 'package:http/http.dart' as http;

const Map<String, String> _defaultHeaders = {
  'Content-Type': 'application/json; charset=UTF-8',
};

class Http {
  static Future<http.Response> get(String uri, {Map<String, String>? headers}) {
    return http.get(Uri.parse(uri), headers: headers ?? _defaultHeaders);
  }

  static Future<http.Response> post(String uri,
      {Map<String, String>? headers, Object? body}) {
    return http.post(Uri.parse(uri),
        headers: headers ?? _defaultHeaders, body: jsonEncode(body));
  }
}
