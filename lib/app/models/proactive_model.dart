import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProactiveModel {
  String? answeredAt;
  List<QuestionnaireProactiveModel>? questionnaires;
  int? score;

  ProactiveModel({
    this.answeredAt,
    this.questionnaires,
    this.score,
  });

  factory ProactiveModel.fromJson(Map<String, dynamic> json) {
    final answeredAt = json['answeredAt'] as String;
    final questionnairesList = json['questionnaires'] as List<dynamic>;
    final questionnaires = questionnairesList
        .map((questionnaire) =>
            QuestionnaireProactiveModel.fromJson(questionnaire))
        .toList();
    final score = json['score'] as int;

    return ProactiveModel(
      answeredAt: answeredAt,
      questionnaires: questionnaires,
      score: score,
    );
  }

  // from firestore
  ProactiveModel.fromFirestore(DocumentSnapshot doc)
      : answeredAt = doc['answeredAt'],
        // questionnaires =
        score = doc['score'],
        questionnaires = (doc['questions'] as List<dynamic>?)
                ?.map((questionnaire) => QuestionnaireProactiveModel.fromJson(
                      questionnaire,
                    ))
                .toList() ??
            <QuestionnaireProactiveModel>[];
}

class QuestionnaireProactiveModel {
  final String? category;
  List<QuestionModel?>? questions;
  RxBool? isAnsweredAll = false.obs;
  final String? id;
  QuestionnaireProactiveModel({
    this.category,
    this.questions,
    this.id,
    this.isAnsweredAll,
  });

  factory QuestionnaireProactiveModel.fromJson(Map<String, dynamic> json) {
    final category = json['category'] as String;
    final questionsList = json['questions'] as List<dynamic>;
    final questions = questionsList
        .map((question) => QuestionModel.fromJson(question))
        .toList();
    final isAnsweredAll = json['isAnsweredAll'] as bool;

    return QuestionnaireProactiveModel(
      category: category,
      questions: questions,
      isAnsweredAll: isAnsweredAll.obs,
    );
  }

  // from firestore
  QuestionnaireProactiveModel.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
        category = doc['category'],
        questions = List<QuestionModel>.from(
          doc['questions'].map(
            (question) => QuestionModel.fromJson(question),
          ),
        );
  toJson() {
    return {
      "category": category,
      "questions": questions!.map((e) => e!.toJson()).toList(),
      "isAnsweredAll":
          isAnsweredAll!.value, // Use .value to get the boolean value
      "answeredAt": DateTime.now().toIso8601String(),
    };
  }
}

class QuestionModel {
  final String statement;
  final Map<String, String> answers;
  String? selectedAnswer;
  int? selectedWeight;
  RxBool isAnswered = false.obs;

  QuestionModel({
    required this.statement,
    required this.answers,
    this.selectedAnswer,
    this.selectedWeight,
    required this.isAnswered,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    final statement = json['statement'] as String;
    final answersMap = json['answers'] as Map<String, dynamic>;
    final selectedAnswer = json['selectedAnswer'] as String;
    final selectedWeight = json['selectedWeight'] as int;
    final isAnswered = json['isAnswered'] as bool;
    final answers =
        answersMap.map((key, value) => MapEntry(key, value as String));

    return QuestionModel(
      statement: statement,
      answers: answers,
      isAnswered: isAnswered.obs,
      selectedAnswer: selectedAnswer,
      selectedWeight: selectedWeight,
    );
  }

  // from firestore
  QuestionModel.fromFirestore(DocumentSnapshot doc)
      : statement = doc['statement'],
        answers = Map<String, String>.from(doc['answers']),
        selectedAnswer = doc['selectedAnswer'],
        selectedWeight = doc['selectedWeight'],
        isAnswered = doc['isAnswered'];

  toJson() {
    return {
      "statement": statement,
      "answers": answers,
      "selectedAnswer": selectedAnswer,
      "isAnswered": isAnswered.value,
      "selectedWeight": selectedWeight,
      "answeredAt": DateTime.now().millisecondsSinceEpoch,
    };
  }
}
