import 'package:get/get.dart';
import '../utils/api.dart';
import '../utils/api_helper.dart';

class AuthService extends GetxService {
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await ApiHelper.post(
      ApiConstants.login,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response['success'] == true) {
      final token = response['data']['token'] ?? response['data']['access_token'];
      if (token != null) {
        ApiHelper.saveToken(token);
      }
    }

    return response;
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    final response = await ApiHelper.post(
      ApiConstants.register,
      body: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
    );

    if (response['success'] == true) {
      final token = response['data']['token'] ?? response['data']['access_token'];
      if (token != null) {
        ApiHelper.saveToken(token);
      }
    }

    return response;
  }

  Future<void> logout() async {
    await ApiHelper.post(ApiConstants.logout, body: {});
    ApiHelper.removeToken();
  }

  Future<Map<String, dynamic>> getProfile() async {
    final response = await ApiHelper.get(ApiConstants.me);
    return response;
  }

  bool isLoggedIn() {
    return ApiHelper.getToken() != null;
  }

  String? getToken() {
    return ApiHelper.getToken();
  }
}
