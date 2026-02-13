import 'package:get/get.dart';
import '../../../services/auth_service.dart';

class ProfileController extends GetxController {
  // Mock data profil menggunakan observable (.obs)
  var userName = "".obs;
  var userEmail = "".obs;
  var memberStatus = "Gold Member".obs;
  var points = 1250.obs;
  var ticketCount = 12.obs;

  final AuthService authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    try {
      final response = await authService.getProfile();
      if (response['success'] == true && response['data'] != null) {
        final userData = response['data'];
        userName.value = userData['name'] ?? "User";
        userEmail.value = userData['email'] ?? "";
      }
    } catch (e) {
      print('Error loading profile: $e');
      userName.value = "User";
      userEmail.value = "";
    }
  }

  void logout() {
    // Logika navigasi ke halaman login setelah keluar
    Get.offAllNamed('/auth/login');
  }
}
