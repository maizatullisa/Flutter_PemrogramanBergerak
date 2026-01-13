import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:meditation_app/features/home/screens/home.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _fadeController;
  int _currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      'title': 'Temukan\nKedamaian',
      'subtitle': 'Mulai perjalanan meditasi Anda',
      'background': 'Kesadaran',
      'lottie': 'assets/lottie/yoga2.json',
    },
    {
      'title': 'Keseimbangan\nHidup',
      'subtitle': 'Sesi terpandu untuk Anda',
      'background': 'Ketenangan',
      'lottie': 'assets/lottie/yoga2.json',
    },
    {
      'title': 'Bangun\nKebiasaan',
      'subtitle': 'Pantau perkembangan Anda',
      'background': 'Transformasi',
      'lottie': 'assets/lottie/yoga2.json',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF3B4FB8),
                  Color(0xFF2E3A8F),
                ],
              ),
            ),
          ),

          // Animated background text
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _fadeController,
              builder: (context, child) {
                return Opacity(
                  opacity: 0.08,
                  child: Center(
                    child: Transform.scale(
                      scale: 1 + (0.1 * _fadeController.value),
                      child: Text(
                        pages[_currentPage]['background']!,
                        style: const TextStyle(
                          fontSize: 120,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: -2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // PageView
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
              _fadeController.forward(from: 0);
            },
            itemCount: pages.length,
            itemBuilder: (context, index) {
              return _buildOnboardingPage(
                title: pages[index]['title']!,
                subtitle: pages[index]['subtitle']!,
                lottie: pages[index]['lottie']!,
              );
            },
          ),

          // Bottom floating card
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 600),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, 100 * (1 - value)),
                  child: Opacity(
                    opacity: value,
                    child: child,
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 25,
                      offset: const Offset(0, -8),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 30,
                    right: 30,
                    top: 32,
                    bottom: MediaQuery.of(context).padding.bottom + 20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Minimal progress dots
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          pages.length,
                          (index) => _buildDot(index),
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Action button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFF3B4FB8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          onPressed: () {
                            if (_currentPage == pages.length - 1) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const HomeScreen(),
                                ),
                              );
                            } else {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          child: Text(
                            _currentPage == pages.length - 1
                                ? "MULAI SEKARANG"
                                : "LANJUT",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Skip button
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomeScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Lewati",
                          style: TextStyle(
                            color: Color(0xFF3B4FB8),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnboardingPage({
    required String title,
    required String subtitle,
    required String lottie,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 100),
        // Animation lottie
        SizedBox(
          height: 280,
          child: Center(
            child: Lottie.asset(
              lottie,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 280,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.15),
                        Colors.white.withOpacity(0.08),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              },
            ),
          ),
        ),
        const Spacer(),
        // Title with fade animation
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.2,
              letterSpacing: -1,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 16),
        // Subtitle
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.75),
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }

  Widget _buildDot(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
        height: 6,
        width: _currentPage == index ? 24 : 6,
        decoration: BoxDecoration(
          color: _currentPage == index
              ? const Color(0xFF3B4FB8)
              : const Color(0xFFD0D0D0),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }
}