import 'package:empapp/core/theme/color.dart';
import 'package:empapp/presentation/pages/home/screen1/screen1.dart';
import 'package:empapp/presentation/widgets/silder.dart';
import 'package:flutter/material.dart';

class homescreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<homescreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    PromoPage(),
    // CongratsPage(),
    // QuizPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.homescreencolor,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
            backgroundColor: const Color.fromARGB(255, 23, 19, 52),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
            ),
            label: 'Congrats',
            backgroundColor: const Color.fromARGB(255, 23, 19, 52),
          ),
          BottomNavigationBarItem(icon: Icon(Icons.quiz), label: 'Quiz'),
        ],
      ),
    );
  }
}







