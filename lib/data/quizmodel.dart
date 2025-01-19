class Quiz {
  final String title;
  final String dailyDate;
  final int completedQuestions;
  final int totalQuestions;
  final String topic;
  final List<Question> questions; // List of questions

  Quiz({
    required this.title,
    required this.dailyDate,
    required this.completedQuestions,
    required this.totalQuestions,
    required this.topic,
    required this.questions,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    var list = json['questions'] as List;
    List<Question> questionsList = list.map((i) => Question.fromJson(i)).toList();
    return Quiz(
      title: json['title'] ?? 'Untitled Quiz',
      dailyDate: json['daily_date'] ?? '',
      completedQuestions: json['completed_questions'] ?? 0,
      totalQuestions: json['questions_count'] ?? 10,
      topic: json['topic'] ?? 'General',
      questions: questionsList,
    );
  }
}

class Question {
  final int id;
  final String description;
  final String topic;
  final String detailedSolution;
  final List<Option> options;

  Question({
    required this.id,
    required this.description,
    required this.topic,
    required this.detailedSolution,
    required this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    var list = json['options'] as List;
    List<Option> optionsList = list.map((i) => Option.fromJson(i)).toList();
    return Question(
      id: json['id'],
      description: json['description'],
      topic: json['topic'],
      detailedSolution: json['detailed_solution'],
      options: optionsList,
    );
  }
}

class Option {
  final int id;
  final String description;
  final bool isCorrect;

  Option({
    required this.id,
    required this.description,
    required this.isCorrect,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'],
      description: json['description'],
      isCorrect: json['is_correct'],
    );
  }
}
