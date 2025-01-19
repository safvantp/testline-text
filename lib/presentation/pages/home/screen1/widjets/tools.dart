import 'package:empapp/core/theme/color.dart';
import 'package:flutter/material.dart';

class QuizCard extends StatelessWidget {
  final String title;
  final String step;
  final int completedQuestions;
  final int totalQuestions;
    final String topic;
    



  const QuizCard({
    required this.title,
    required this.step,
    required this.completedQuestions,
    required this.totalQuestions,
    required this.topic,
  });

  @override
  Widget build(BuildContext context) {
    double progress = completedQuestions / totalQuestions;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 23, 19, 52),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    step,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
              Text(
                    '$completedQuestions/$totalQuestions',
                    style: const TextStyle(color: Colors.white70),
                  ),
                                Icon(Icons.arrow_forward, color: Colors.white),

            ],
          ),
          const SizedBox(height: 8),
          Stack(
            children: [
              Container(
                height: 6,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              Container(
                height: 6,
                width: MediaQuery.of(context).size.width * progress,
                decoration: BoxDecoration(
                  color: AppColors.primaryButton,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class ProgressCircle extends StatelessWidget {
  final String label;
  final Color color;
  final double progress; // Progress value from 0.0 to 1.0

  const ProgressCircle({
    required this.label,
    required this.color,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: CircularProgressIndicator(
                value: progress, // Progress indicator value
                strokeWidth: 8,
                color: color,
                backgroundColor: Colors.grey.shade300,
              ),
            ),
            Text(
              '${(progress * 100).toInt()}%', 
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}