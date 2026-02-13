import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/auth_service.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  final AuthService authService = Get.find<AuthService>();

  // Login variables
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  final isLoginLoading = false.obs;
  final hideLoginPassword = true.obs;

  // Register variables
  final registerNameController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerPasswordConfirmController = TextEditingController();
  final registerFormKey = GlobalKey<FormState>();
  final isRegisterLoading = false.obs;
  final hideRegisterPassword = true.obs;
  final hideRegisterPasswordConfirm = true.obs;

  // Common variables
  final rememberMe = false.obs;

  // Auth state
  final isLoggedIn = false.obs;
  final currentUser = Rx<Map<String, dynamic>?>(null);

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  @override
  void onClose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    registerNameController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerPasswordConfirmController.dispose();
    super.onClose();
  }

  void checkLoginStatus() {
    isLoggedIn.value = authService.isLoggedIn();
  }

  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) {
      return;
    }

    isLoginLoading.value = true;
    try {
      final response = await authService.login(
        email: loginEmailController.text.trim(),
        password: loginPasswordController.text,
      );

      if (response['success'] == true) {
        isLoggedIn.value = true;
        Get.snackbar(
          'Sukses',
          'Login berhasil',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // Navigate to dashboard
        Get.offAllNamed('/dashboard');
      } else {
        Get.snackbar(
          'Error',
          response['message'] ?? 'Login gagal',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoginLoading.value = false;
    }
  }

  Future<void> register() async {
    if (!registerFormKey.currentState!.validate()) {
      return;
    }

    if (registerPasswordController.text !=
        registerPasswordConfirmController.text) {
      Get.snackbar(
        'Error',
        'Password tidak cocok',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isRegisterLoading.value = true;
    try {
      final response = await authService.register(
        name: registerNameController.text.trim(),
        email: registerEmailController.text.trim(),
        password: registerPasswordController.text,
        passwordConfirmation: registerPasswordConfirmController.text,
      );

      if (response['success'] == true) {
        isLoggedIn.value = true;
        Get.snackbar(
          'Sukses',
          'Registrasi berhasil',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // Navigate to dashboard
        Get.offAllNamed('/dashboard');
      } else {
        Get.snackbar(
          'Error',
          response['message'] ?? 'Registrasi gagal',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isRegisterLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await authService.logout();
      isLoggedIn.value = false;
      currentUser.value = null;
      loginEmailController.clear();
      loginPasswordController.clear();
      registerNameController.clear();
      registerEmailController.clear();
      registerPasswordController.clear();
      registerPasswordConfirmController.clear();
      Get.offAllNamed('/auth');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Logout gagal: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Email tidak valid';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 6) {
      return 'Password minimal 6 karakter';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nama tidak boleh kosong';
    }
    if (value.length < 3) {
      return 'Nama minimal 3 karakter';
    }
    return null;
  }
}
