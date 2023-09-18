import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SelfEfficacyModel {
  int? score;
  String? answeredAt;
  List<QuestionSelfEfficiencyModel>? questionnaires;

  SelfEfficacyModel({
    this.score,
    this.answeredAt,
    this.questionnaires,
  });

  // from firestore
  SelfEfficacyModel.fromFirestore(DocumentSnapshot doc)
      : score = doc['score'],
        answeredAt = doc['answeredAt'],
        questionnaires = (doc['questions'] as List<dynamic>?)
                ?.map((questionnaire) => QuestionSelfEfficiencyModel.fromJson(
                      questionnaire,
                    ))
                .toList() ??
            <QuestionSelfEfficiencyModel>[];
}

class QuestionSelfEfficiencyModel {
  final String? id;
  final String questionText;
  final List<String> options;
  final List<int> weights;
  RxInt? selectedWeight = 0.obs;
  RxString? selectedOption = ''.obs;
  RxBool? isAnswered = false.obs;

  QuestionSelfEfficiencyModel({
    this.id,
    required this.questionText,
    required this.options,
    this.weights = const [1, 2, 3, 4, 5],
    this.isAnswered,
    this.selectedWeight,
    this.selectedOption,
  });

  Map<String, dynamic> toJson() {
    return {
      'text': questionText,
      'options': options,
      'weights': weights,
      'isAnswered': isAnswered!.value,
      'selectedWeight': selectedWeight!.value,
      'selectedOption': selectedOption!.value,
    };
  }

  // from json
  QuestionSelfEfficiencyModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        questionText = json['text'],
        options = List<String>.from(json['options']),
        weights = List<int>.from(json['weights']),
        isAnswered = RxBool(json['isAnswered']),
        selectedWeight = RxInt(json['selectedWeight']),
        selectedOption = RxString(json['selectedOption']);

  QuestionSelfEfficiencyModel.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
        questionText = doc['text'],
        options = List<String>.from(doc['options']),
        weights = List<int>.from(doc['weights']);
  // isAnswered = doc['isAnswered'],
  // selectedWeight = doc['selectedWeight'],
  // selectedOption = doc['selectedOption'];
}
