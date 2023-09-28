import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FormProactiveController extends GetxController {
  final fireStore = FirebaseFirestore.instance;
  final categoryId = Get.arguments['categoryId'];

  RxMap answers = {}.obs;
  RxString question = ''.obs;
  void setDefaultAnswers() {
    answers.value = dAnswers;
  }

  void addAnswer() {
    // set key to the length of the map
    final key = answers.length + 1;
    answers[key] = "";
  }

  void removeAnswer(int key) {
    answers.remove(key);
  }

  void setAnswer(int key, String value) {
    try {
      answers[key] = value;
    } catch (e) {
      print(e);
    }
  }

  RxMap dAnswers = {
    1: "Tidak benar sama sekali",
    2: "Kadang kadang",
    3: "Agak benar",
    4: "Sangat benar",
    5: "Sangat benar sekali"
  }.obs;

  void saveQuestion() {
    final questionMap = {
      "statement": question.value,
      "answers": answers.map<String, String>(
        (key, value) => MapEntry(key.toString(), value),
      ),
    };
    print(questionMap);

    fireStore
        .collection('questions-proactive-csc')
        .doc(categoryId)
        .update({
          'questions': FieldValue.arrayUnion([questionMap])
        })
        .then((value) => Get.back())
        .catchError((error) => print("Failed to add question: $error"));
  }

  void updateQuestion() {
    final updatedQuestion = {
      "statement": question.value,
      "answers": answers.map<String, String>(
        (key, value) => MapEntry(key.toString(), value),
      ),
    };

    final indexQuestion = Get.arguments['indexQuestion'];
    print(updatedQuestion);
    print(indexQuestion);
    fireStore
        .collection('questions-proactive-csc')
        .doc(categoryId)
        .get()
        .then((value) {
          final questions = value.data()!['questions'];
          questions[indexQuestion] = updatedQuestion;
          fireStore
              .collection('questions-proactive-csc')
              .doc(categoryId)
              .update({'questions': questions});
        })
        .then((value) => Get.back())
        .catchError((error) => print("Failed to update question: $error"));
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments['question'] != null) {
      final question = Get.arguments['question'];
      this.question.value = question.statement;
      answers.value = question.answers;
      print(question);
    }
  }
}
