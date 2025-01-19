import 'package:empapp/data/quizmodel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PromoController extends GetxController {
  var quizzes = <Quiz>[].obs; 
  var isLoading = true.obs;   
  var error = ''.obs;        
  var notificationCount = 10.obs;

  @override
  void onInit() {
    fetchQuizData(); 
    super.onInit();
  }

  Future<void> fetchQuizData() async {
    const url = 'https://api.jsonserve.com/Uw5CrX';
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null) {
          quizzes.assignAll([Quiz.fromJson(data)]); 
        }
      } else {
        error('Failed to load quiz data');
      }
    } catch (e) {
      error('Error fetching quiz data: $e');
    } finally {
      isLoading(false);
    }
  }
}
