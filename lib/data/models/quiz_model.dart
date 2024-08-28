import 'package:ojo/data/models/question_model.dart';

class Quiz {
  final String name;
  final List<Question> questions;
  const Quiz({
    this.name = "No-Name", //TODO change this when in design will be add functionality for this parameter
    required this.questions,
  });

  Quiz copyWith({
    String? name,
    List<Question>? questions,
  }) {
    return Quiz(
      name: name ?? this.name,
      questions: questions ?? this.questions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'questions': questions.map((x) => x.toMap()).toList(),
    };
  }

  factory Quiz.fromMap(Map<String, dynamic> map) {
    return Quiz(
      name: map['name'] as String,
      questions: List.from(map["questions"] ?? []).map((e) => Question.fromMap(Map<String,dynamic>.from(Map.from(e)))).toList(),
    );
  }
}
