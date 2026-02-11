import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class ApiHelper {
  static final GetStorage _storage = GetStorage();

  static Map<String, String> headers() {
    String? token = _storage.read('auth_token');
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static Future<Map<String, dynamic>> post(
    String url, {
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers(),
        body: jsonEncode(body),
      );

      return _handleResponse(response);
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: ${e.toString()}',
      };
    }
  }

  static Future<Map<String, dynamic>> get(String url) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers(),
      );

      return _handleResponse(response);
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: ${e.toString()}',
      };
    }
  }

  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return {
        'success': true,
        'data': jsonDecode(response.body),
      };
    } else if (response.statusCode == 401) {
      return {
        'success': false,
        'message': 'Unauthorized',
      };
    } else {
      final responseBody = jsonDecode(response.body);
      return {
        'success': false,
        'message': responseBody['message'] ?? 'Server error',
        'data': responseBody,
      };
    }
  }

  static void saveToken(String token) {
    _storage.write('auth_token', token);
  }

  static String? getToken() {
    return _storage.read('auth_token');
  }

  static void removeToken() {
    _storage.remove('auth_token');
  }
}
