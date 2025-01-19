import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:empapp/core/theme/color.dart';
import 'package:empapp/data/dummydata.dart';
import 'package:empapp/presentation/pages/home/mainhome.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final isTabletOrDesktop = screenWidth > 600;
    final imageHeight =
        isTabletOrDesktop ? screenHeight * 0.5 : screenHeight * 0.4;
    final imageWidth =
        isTabletOrDesktop ? screenWidth * 0.6 : screenWidth * 0.8;

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingData.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              final data = onboardingData[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    data.image,
                    height: imageHeight,
                    width: imageWidth,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                    child: AnimatedTextKit(
                      key: ValueKey<int>(_currentPage),
                      animatedTexts: [
                        TypewriterAnimatedText(
                          data.title,
                          textAlign: TextAlign.center,
                          textStyle: TextStyle(
                            fontSize: isTabletOrDesktop ? 32 : 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryText,
                          ),
                          speed: const Duration(milliseconds: 80),
                        ),
                      ],
                      repeatForever: false,
                      isRepeatingAnimation: false,
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.05,
            left: MediaQuery.of(context).size.width * 0.05,
            child: Image.asset(
              'assets/logo.png',
              height: MediaQuery.of(context).size.width > 600 ? 100 : 20,
              width: MediaQuery.of(context).size.width > 600 ? 100 : 50,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => homescreen()),
                );
              },
              child: const Text(
                "Skip",
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.2,
            left: 0,
            right: 0,
            child: MediaQuery.of(context).size.width > 400
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboardingData.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: MediaQuery.of(context).size.width > 600
                            ? (_currentPage == index ? 16 : 12)
                            : (_currentPage == index ? 12 : 8),
                        height: MediaQuery.of(context).size.width > 600
                            ? (_currentPage == index ? 16 : 12)
                            : (_currentPage == index ? 12 : 8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
                              ? AppColors.activeIndicator
                              : AppColors.inactiveIndicator,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.05,
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
            child: ElevatedButton(
              onPressed: () {
                if (_currentPage == onboardingData.length - 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => homescreen()),
                  );
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryButton,
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.width > 600 ? 20 : 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: Size(
                  double.infinity,
                  MediaQuery.of(context).size.width > 600 ? 70 : 50,
                ),
              ),
              child: Text(
                _currentPage == onboardingData.length - 1
                    ? "Get Started"
                    : "Next",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 600 ? 18 : 16,
                  color: AppColors.primaryText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
