import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static String? _token;
  /// Base URL for the API. Change this to your server's URL.
  /// For Android emulator, use 'http://10.0.2.2:8080/api/v1/'
  /// For deployed server, use 'https://synhub-backend.onrender.com/api/v1/'.
  static const String _baseUrl = 'http://10.0.2.2:8080/api/v1/';

  static void updateToken(String newToken) {
    _token = newToken;
  }

  static void resetToken() {
    _token = null;
  }

  static Future<http.Response> get(String endpoint) async {
    final uri = Uri.parse(_baseUrl + endpoint);
    final headers = {
      if (_token != null) 'Authorization': 'Bearer $_token',
      'Content-Type': 'application/json',
    };
    return await http.get(uri, headers: headers);
  }

  static Future<http.Response> post(String endpoint, {Object? body}) async {
    final uri = Uri.parse(_baseUrl + endpoint);
    final headers = {
      if (_token != null) 'Authorization': 'Bearer $_token',
      'Content-Type': 'application/json',
    };
    return await http.post(
      uri,
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );
  }

  static Future<http.Response> put(String endpoint, {Object? body}) async {
    final uri = Uri.parse(_baseUrl + endpoint);
    final headers = {
      if (_token != null) 'Authorization': 'Bearer $_token',
      'Content-Type': 'application/json',
    };
    return await http.put(
      uri,
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );
  }

  static Future<http.Response> patch(String endpoint, {Object? body}) async {
    final uri = Uri.parse(_baseUrl + endpoint);
    final headers = {
      if (_token != null) 'Authorization': 'Bearer $_token',
      'Content-Type': 'application/json',
    };
    return await http.patch(
      uri,
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );
  }

  static Future<http.Response> delete(String endpoint, {Object? body}) async {
    final uri = Uri.parse(_baseUrl + endpoint);
    final headers = {
      if (_token != null) 'Authorization': 'Bearer $_token',
      'Content-Type': 'application/json',
    };
    return await http.delete(
      uri,
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );
  }
}