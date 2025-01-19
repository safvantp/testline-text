import 'dart:async';
import 'package:empapp/core/theme/color.dart';
import 'package:empapp/data/dummydata.dart';
import 'package:flutter/material.dart';

class PremiumSlider extends StatefulWidget {
  @override
  _PremiumSliderState createState() => _PremiumSliderState();
}

class _PremiumSliderState extends State<PremiumSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

  

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < sliderData.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 23, 19, 52),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '50% Off',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primaryText),
              ),
              const SizedBox(height: 10),
              Text(
                'Get Premium!',
                style: TextStyle(fontSize: 16, color: AppColors.primaryText),
              ),
              const SizedBox(height: 8),
              ElevatedButton(onPressed: () {}, child: const Text('Get Now' , style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryButton,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

              ),
              
                  
              ),
            ],
          ),
          SizedBox(
            height: 200,
            width: 200,
            child: PageView.builder(
              controller: _pageController,
              itemCount: sliderData.length,
              itemBuilder: (context, index) {
                              final data = sliderData[index];

                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    data.image,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
