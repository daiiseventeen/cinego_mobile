import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../services/auth_service.dart';

class DashboardController extends GetxController
    with GetTickerProviderStateMixin {
  // State untuk kategori yang dipilih menggunakan observable
  var selectedCategory = 'Semua'.obs;
  var userName = "".obs;
  var selectedNavIndex = 0.obs;

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  final List<String> categories = ['Semua', 'Action', 'Drama', 'Horror', 'Sci-Fi', 'Comedy'];

  final AuthService authService = Get.find<AuthService>();

  // Data contoh untuk film yang sedang tayang
  final nowPlayingMovies = [
    {
      'title': 'Avengers: Secret Wars',
      'image': 'https://images.unsplash.com/photo-1626814026160-2237a95fc5a0?q=80&w=2070&auto=format&fit=crop',
      'rating': '4.9'
    },
    {
      'title': 'Dune: Part Two',
      'image': 'https://images.unsplash.com/photo-1534447677768-be436bb09401?q=80&w=2094&auto=format&fit=crop',
      'rating': '4.8'
    },
    {
      'title': 'Oppenheimer',
      'image': 'https://images.unsplash.com/photo-1585647347483-22b66260dfff?q=80&w=2070&auto=format&fit=crop',
      'rating': '4.7'
    },
  ];

  // Data contoh untuk film yang akan datang
  final comingSoonMovies = [
    {
      'title': 'Joker: Folie à Deux',
      'image': 'https://images.unsplash.com/photo-1536440136628-849c177e76a1?q=80&w=1925&auto=format&fit=crop',
      'genre': 'Thriller'
    },
    {
      'title': 'Gladiator II',
      'image': 'https://images.unsplash.com/photo-1485846234645-a62644f84728?q=80&w=2059&auto=format&fit=crop',
      'genre': 'Action'
    },
  ];

  @override
  void onInit() {
    super.onInit();
    _initializeAnimation();
    loadUserName();
  }

  void _initializeAnimation() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
  }

  @override
  void onClose() {
    _animationController.dispose();
    super.onClose();
  }

  Future<void> loadUserName() async {
    try {
      final response = await authService.getProfile();
      if (response['success'] == true && response['data'] != null) {
        final userData = response['data'];
        userName.value = userData['name'] ?? "User";
      }
    } catch (e) {
      print('Error loading user name: $e');
      userName.value = "User";
    }
  }

  void changeCategory(String category) {
    selectedCategory.value = category;
  }

  void onNavItemTap(int index) {
    selectedNavIndex.value = index;
    _animationController.forward(from: 0);
  }

  void setNavIndex(int index) {
    selectedNavIndex.value = index;
  }

  Animation<double> getScaleAnimation() => _scaleAnimation;
}
