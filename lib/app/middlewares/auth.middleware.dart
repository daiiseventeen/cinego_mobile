import 'package:get/get.dart';
import '../services/auth_service.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  GetPage? onPageCalled(GetPage? page) {
    final authService = Get.find<AuthService>();
    
    if (!authService.isLoggedIn()) {
      Future.delayed(const Duration(milliseconds: 0), () {
        Get.offNamed('/login');
      });
    }
    
    return page;
  }
}
