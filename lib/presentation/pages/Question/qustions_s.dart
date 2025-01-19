import 'dart:async'; 
import 'package:empapp/core/theme/color.dart';
import 'package:empapp/data/quizmodel.dart';
import 'package:empapp/presentation/pages/score/score.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class QuestionDetailPage extends StatefulWidget {
  final List<Question> questions;

  QuestionDetailPage({required this.questions});

  @override
  _QuestionDetailPageState createState() => _QuestionDetailPageState();
}

class _QuestionDetailPageState extends State<QuestionDetailPage> {
  int currentIndex = 0;
  int? selectedOption;
  bool isAnswerRevealed = false;
  int totalScore = 0;
  int notificationCount = 10;
  
  int timerDuration = 15; 
  late Timer _timer; 

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timerDuration > 0) {
        setState(() {
          timerDuration--;
        });
      } else {
        _timer.cancel();
        moveToNextQuestion(); 
      }
    });
  }

  void calculateScore() async {
    if (selectedOption != null &&
        widget.questions[currentIndex].options[selectedOption!].isCorrect) {
      totalScore++;
      if (await Vibration.hasVibrator()) {
        Vibration.vibrate(duration: 500);
      }
    }
  }

  void moveToNextQuestion() {
  if (currentIndex < widget.questions.length - 1) {
    calculateScore();
    setState(() {
      currentIndex++;
      selectedOption = null; 
      isAnswerRevealed = false; 
    });
  } else {
    calculateScore();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScorePage(totalScore: totalScore),
      ),
    );
  }
}


  @override
  void initState() {
    super.initState();
    startTimer(); 
  }

  @override
  void dispose() {
    _timer.cancel(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentIndex];
    final progress = (currentIndex + 1) / widget.questions.length;
    
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.homescreencolor,
      appBar: AppBar(
        backgroundColor: AppColors.homescreencolor,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/logo.png'),
        ),
        actions: [
          if (notificationCount >= 10)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  notificationCount > 9 ? '10+' : '$notificationCount',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05, 
          vertical: screenHeight * 0.03, 
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              alignment: Alignment.centerRight,
              child: Center(
                child: Text(
                  ' ${timerDuration}s',
                  style: TextStyle(
                    fontSize: screenWidth > 400 ? 16 : 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02), 

            SizedBox(height: screenHeight * 0.02), 

            Container(
              padding: EdgeInsets.all(screenWidth * 0.05), 
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 23, 19, 52),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black),
              ),
              child: Text(
                '${question.description}',
                style: TextStyle(
                  fontSize: screenWidth > 400 ? 14 : 12, 
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03), 

            LinearProgressIndicator(
              value: progress, 
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
            SizedBox(height: screenHeight * 0.03), 

            for (var i = 0; i < question.options.length; i++)
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedOption = i;
                    isAnswerRevealed = true;
                  });
                  Future.delayed(Duration(seconds: 1), () {
                    moveToNextQuestion();
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  margin: EdgeInsets.only(bottom: screenHeight * 0.02), 
                  decoration: BoxDecoration(
                    color: selectedOption == i
                        ? (question.options[i].isCorrect
                            ? Colors.green.withOpacity(0.6)
                            : Colors.red.withOpacity(0.6))
                        : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: selectedOption == i ? Colors.blue : Colors.grey,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '${String.fromCharCode(65 + i)}. ${question.options[i].description}',
                        style: TextStyle(
                          fontSize: screenWidth > 400 ? 14 : 12,
                        ),
                      ),
                      Spacer(),
                      if (isAnswerRevealed)
                        Icon(
                          question.options[i].isCorrect
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: question.options[i].isCorrect
                              ? Colors.green
                              : Colors.red,
                        ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: screenHeight * 0.01), 
            Divider(
              thickness: 2,
              color: Colors.black,
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
