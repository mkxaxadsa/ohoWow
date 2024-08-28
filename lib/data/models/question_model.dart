// ignore_for_file: public_member_api_docs, sort_constructors_first
class Question {
  final String question;
  final String answerA;
  final String answerB;
  final String answerC;
  final String answerD;
  const Question({
    required this.question,
    required this.answerA,
    required this.answerB,
    required this.answerC,
    required this.answerD,
  });

  List<String> get variants => [answerA, answerB, answerC, answerD];

  bool get isValidated =>
      question.isNotEmpty &&
      answerA.isNotEmpty &&
      answerB.isNotEmpty &&
      answerC.isNotEmpty &&
      answerD.isNotEmpty;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'question': question,
      'answerA': answerA,
      'answerB': answerB,
      'answerC': answerC,
      'answerD': answerD,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      question: map['question'] as String,
      answerA: map['answerA'] as String,
      answerB: map['answerB'] as String,
      answerC: map['answerC'] as String,
      answerD: map['answerD'] as String,
    );
  }

  Question copyWith({
    String? question,
    String? answerA,
    String? answerB,
    String? answerC,
    String? answerD,
  }) {
    return Question(
      question: question ?? this.question,
      answerA: answerA ?? this.answerA,
      answerB: answerB ?? this.answerB,
      answerC: answerC ?? this.answerC,
      answerD: answerD ?? this.answerD,
    );
  }

  factory Question.empty() {
    return const Question(
        question: "", answerA: "", answerB: "", answerC: "", answerD: "");
  }
}
