import 'package:get/get.dart';

import '../middlewares/auth.middleware.dart';
import '../modules/modules/auth/bindings/auth_binding.dart';
import '../modules/modules/auth/views/auth_view.dart';
import '../modules/modules/auth/views/landing_view.dart';
import '../modules/modules/auth/views/login_view.dart';
import '../modules/modules/auth/views/register_view.dart';
import '../modules/modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/modules/dashboard/views/dashboard_view.dart';
import '../modules/modules/home/bindings/home_binding.dart';
import '../modules/modules/home/views/home_view.dart';
import '../modules/modules/profile/bindings/profile_binding.dart';
import '../modules/modules/profile/views/profile_view.dart';
import '../services/auth_service.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LANDING;

  static final routes = [
    // Landing Route
    GetPage(
      name: _Paths.LANDING,
      page: () => const LandingView(),
      binding: AuthBinding(),
    ),
    // Auth Routes
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: AuthBinding(),
    ),

    // Protected Routes
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];

  static Future<void> init() async {
    await Get.putAsync<AuthService>(() async => AuthService());
  }
}

