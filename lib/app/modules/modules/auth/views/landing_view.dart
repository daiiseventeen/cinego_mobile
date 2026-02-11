import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView>
    with TickerProviderStateMixin {
  late AnimationController _titleAnimationController;
  late AnimationController _cardsAnimationController;
  late AnimationController _buttonAnimationController;
  late Animation<Offset> _titleSlideAnimation;
  late Animation<double> _titleFadeAnimation;

  final List<MovieCard> featuredMovies = [
    MovieCard(
      title: "Premium Seats",
      description: "Enjoy watching from best seats in class",
      color: const Color(0xFF6C5CE7),
      icon: Icons.event_seat,
    ),
    MovieCard(
      title: "Best Prices",
      description: "Get exclusive discounts & offers",
      color: const Color(0xFFFF6B6B),
      icon: Icons.local_offer,
    ),
    MovieCard(
      title: "Latest Movies",
      description: "Watch latest blockbusters first",
      color: const Color(0xFF1DD1A1),
      icon: Icons.movie,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    // Title Animation
    _titleAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _titleSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _titleAnimationController, curve: Curves.easeOut),
    );

    _titleFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _titleAnimationController, curve: Curves.easeIn),
    );

    // Cards Animation
    _cardsAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Button Animation
    _buttonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Start animations sequentially
    Future.delayed(const Duration(milliseconds: 300), () {
      _titleAnimationController.forward();
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      _cardsAnimationController.forward();
    });

    Future.delayed(const Duration(milliseconds: 1400), () {
      _buttonAnimationController.forward();
    });
  }

  @override
  void dispose() {
    _titleAnimationController.dispose();
    _cardsAnimationController.dispose();
    _buttonAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Section with Animation
              Container(
                height: size.height * 0.35,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF1A1A1A),
                      Color(0xFF0A0A0A),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // Animated background circles
                    Positioned(
                      right: -80,
                      top: -80,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFFFC107).withOpacity(0.1),
                        ),
                      ),
                    ),
                    Positioned(
                      left: -50,
                      bottom: -50,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFFFC107).withOpacity(0.05),
                        ),
                      ),
                    ),
                    // Title Content
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SlideTransition(
                            position: _titleSlideAnimation,
                            child: FadeTransition(
                              opacity: _titleFadeAnimation,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Logo/Title with cinema style
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xFFFFC107),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      "CINEGO",
                                      style: TextStyle(
                                        color: Color(0xFFFFC107),
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 3,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    "Experience Cinema\nLike Never Before",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      height: 1.3,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  const Text(
                                    "Book your favorite movies with premium seats and exclusive offers",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Features Section with Staggered Animation
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Why Choose CINEGO?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Staggered Cards Animation
                    for (int i = 0; i < featuredMovies.length; i++)
                      _buildAnimatedCard(i),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Stats Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatItem("500+", "Movies"),
                    _buildStatItem("1M+", "Users"),
                    _buildStatItem("4.9★", "Rating"),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // CTA Button with Animation
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.8, end: 1).animate(
                    CurvedAnimation(
                        parent: _buttonAnimationController,
                        curve: Curves.easeOut),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed('/auth/login');
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xFFFFC107),
                            Color(0xFFFFD700),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFFC107).withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.play_circle_outline,
                            color: Colors.black,
                            size: 24,
                          ),
                          SizedBox(width: 12),
                          Text(
                            "Get Started Now",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Footer
              Center(
                child: Column(
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed('/auth/login'),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Color(0xFFFFC107),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedCard(int index) {
    final movie = featuredMovies[index];
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(-0.5 * (index + 1), 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _cardsAnimationController,
          curve: Interval(
            index * 0.1,
            0.3 + (index * 0.1),
            curve: Curves.easeOut,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                movie.color.withOpacity(0.2),
                movie.color.withOpacity(0.05),
              ],
            ),
            border: Border.all(
              color: movie.color.withOpacity(0.3),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: movie.color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  movie.icon,
                  color: movie.color,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      movie.description,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: movie.color,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            color: Color(0xFFFFC107),
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class MovieCard {
  final String title;
  final String description;
  final Color color;
  final IconData icon;

  MovieCard({
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
  });
}
