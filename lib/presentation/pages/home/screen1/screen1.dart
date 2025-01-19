import 'package:empapp/core/theme/color.dart';
import 'package:empapp/data/quizmodel.dart';
import 'package:empapp/presentation/controllers/quizcontroller.dart';
import 'package:empapp/presentation/pages/Question/qustions_s.dart';
import 'package:empapp/presentation/pages/home/screen1/widjets/tools.dart';
import 'package:empapp/presentation/widgets/silder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PromoPage extends StatelessWidget {
  final PromoController controller = Get.put(PromoController());

  PromoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homescreencolor,
      appBar: AppBar(
        backgroundColor: AppColors.homescreencolor,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/logo.png'),
        ),
        actions: [
          Obx(() {
            return controller.notificationCount >= 10
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        controller.notificationCount.value > 9
                            ? '10+'
                            : '${controller.notificationCount.value}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink();
          }),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: 
          CircularProgressIndicator(),
          );
        } else if (controller.error.isNotEmpty) {
          return Center(child: Text('Error: ${controller.error}'));
        } else if (controller.quizzes.isEmpty) {
          return const Center(child: Text('No quizzes available'));
        } else {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PremiumSlider(),
                const SizedBox(height: 16),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ProgressCircle(
                        label: 'Top 1', color: Colors.red, progress: 0.7),
                    ProgressCircle(
                        label: 'Top 2', color: Colors.green, progress: 0.5),
                    ProgressCircle(
                        label: 'Top 3', color: Colors.blue, progress: 0.9),
                  ],
                ),
                Text(
                  'Today\'s Quizzes',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                ...controller.quizzes.map((quiz) {
                  return GestureDetector(
                    onTap: () {
                      // Handle the tap action
                      Get.to(
                          () => QuestionDetailPage(questions: quiz.questions

                          ));
                    },
                    child: QuizCard(
                      title: quiz.title,
                      step: quiz.dailyDate,
                      completedQuestions: 3,
                      totalQuestions: 10,
                      topic: quiz.topic,
                    ),
                    
                  );
                }).toList(),
                const SizedBox(height: 16),
                QuizCard(
                  title: 'Quiz 2',
                  step: 'Step 2',
                  completedQuestions: 5,
                  totalQuestions: 10,
                  topic: 'Topic 2',
                ),
                const SizedBox(height: 16),
                QuizCard(
                  title: 'Quiz 3',
                  step: 'Step 3',
                  completedQuestions: 7,
                  totalQuestions: 10,
                  topic: 'Topic 3',
                )
              ],
            ),
          );
        }
      }),
    );
  }
}

