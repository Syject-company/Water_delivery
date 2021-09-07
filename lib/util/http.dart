import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class Http {
  static Future<http.Response> get(
    String uri, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) {
    String queryString = Uri(queryParameters: queryParameters).query;

    return http.get(
      Uri.parse('$uri?$queryString'),
      headers: _withContentType(headers),
    );
  }

  static Future<http.Response> post(
    String uri, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    return http.post(
      Uri.parse(uri),
      headers: _withContentType(headers),
      body: jsonEncode(body),
      encoding: encoding,
    );
  }

  static Future<http.Response> put(
    String uri, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    return http.put(
      Uri.parse(uri),
      headers: _withContentType(headers),
      body: jsonEncode(body),
      encoding: encoding,
    );
  }

  static Future<http.Response> delete(
      String uri, {
        Map<String, String>? headers,
        Object? body,
        Encoding? encoding,
      }) {
    return http.delete(
      Uri.parse(uri),
      headers: _withContentType(headers),
      body: jsonEncode(body),
      encoding: encoding,
    );
  }

  static Future<http.Response> patch(
    String uri, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    return http.patch(
      Uri.parse(uri),
      headers: _withContentType(headers),
      body: jsonEncode(body),
      encoding: encoding,
    );
  }

  static Map<String, String> _withContentType(Map<String, String>? headers) {
    final modifiedHeaders = Map.of(headers ?? <String, String>{});
    if (!modifiedHeaders.containsKey(HttpHeaders.contentTypeHeader)) {
      modifiedHeaders[HttpHeaders.contentTypeHeader] =
          'application/json; charset=UTF-8';
    }
    return modifiedHeaders;
  }
}
