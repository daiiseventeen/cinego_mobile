import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final AuthController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<AuthController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.toNamed('/auth/login'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Form(
          key: controller.registerFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              const Text(
                'Sign Up To Your Account.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Create an account to access all features.',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 40),

              // Name Field
              const Text(
                'Full Name',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: controller.registerNameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'James Anderson',
                  hintStyle: const TextStyle(color: Colors.white30),
                  filled: true,
                  fillColor: const Color(0xFF1A1A1A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                validator: controller.validateName,
              ),
              const SizedBox(height: 20),

              // Email Field
              const Text(
                'Email',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: controller.registerEmailController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'james.anderson@gmail.com',
                  hintStyle: const TextStyle(color: Colors.white30),
                  filled: true,
                  fillColor: const Color(0xFF1A1A1A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                validator: controller.validateEmail,
              ),
              const SizedBox(height: 20),

              // Password Field
              const Text(
                'Password',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Obx(
                () => TextFormField(
                  controller: controller.registerPasswordController,
                  obscureText: controller.hideRegisterPassword.value,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: '••••••••',
                    hintStyle: const TextStyle(color: Colors.white30),
                    filled: true,
                    fillColor: const Color(0xFF1A1A1A),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.hideRegisterPassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.white30,
                      ),
                      onPressed: () {
                        controller.hideRegisterPassword.value =
                            !controller.hideRegisterPassword.value;
                      },
                    ),
                  ),
                  validator: controller.validatePassword,
                ),
              ),
              const SizedBox(height: 20),

              // Confirm Password Field
              const Text(
                'Confirm Password',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Obx(
                () => TextFormField(
                  controller: controller.registerPasswordConfirmController,
                  obscureText: controller.hideRegisterPasswordConfirm.value,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: '••••••••',
                    hintStyle: const TextStyle(color: Colors.white30),
                    filled: true,
                    fillColor: const Color(0xFF1A1A1A),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.hideRegisterPasswordConfirm.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.white30,
                      ),
                      onPressed: () {
                        controller.hideRegisterPasswordConfirm.value =
                            !controller.hideRegisterPasswordConfirm.value;
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirm password cannot be empty';
                    }
                    if (value != controller.registerPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Remember me
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      value: controller.rememberMe.value,
                      onChanged: (value) {
                        controller.rememberMe.value = value ?? false;
                      },
                      fillColor: MaterialStateProperty.all(
                        const Color(0xFFFFC107),
                      ),
                    ),
                  ),
                  const Text(
                    'Remember me',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Sign Up Button
              Obx(
                () => ElevatedButton(
                  onPressed: controller.isRegisterLoading.value
                      ? null
                      : controller.register,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: const Color(0xFFFFC107),
                    disabledBackgroundColor: Colors.grey[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: controller.isRegisterLoading.value
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.black),
                          ),
                        )
                      : const Text(
                          'Sign UP',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 24),

              // Divider
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.white10,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'OR',
                      style: TextStyle(
                        color: Colors.white30,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.white10,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Social Sign Up - Google
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://www.gstatic.com/images/branding/product/1x/googleg_40dp.png',
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Sign in with Google',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Social Sign Up - Apple
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.apple, color: Colors.white, size: 20),
                    SizedBox(width: 12),
                    Text(
                      'Continue with Apple',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Login Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Color(0xFFFFC107),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
