import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/models/proactive_model.dart';

class ProactiveCSCController extends GetxController {
  final fireStore = FirebaseFirestore.instance;
  RxString name = ''.obs;
  Stream<List<QuestionnaireProactiveModel>> getQuestions() {
    return fireStore.collection('questions-proactive-csc').snapshots().map(
          (event) => event.docs
              .map((e) => QuestionnaireProactiveModel.fromFirestore(e))
              .toList(),
        );
  }

  void addCategory() async {
    if (name.value.isEmpty) {
      Get.snackbar('Error', 'Nama kategori tidak boleh kosong');
      return;
    }
    await fireStore.collection('questions-proactive-csc').add({
      'category': name.value,
      'questions': [],
    });
  }

  void updateCategory(String id) async {
    if (name.value.isEmpty) {
      Get.snackbar('Error', 'Nama kategori tidak boleh kosong');
      return;
    }
    await fireStore.collection('questions-proactive-csc').doc(id).update({
      'category': name.value,
    });
  }

  void deleteCategory(String id) async {
    await fireStore.collection('questions-proactive-csc').doc(id).delete();
  }

  void deleteQuestion(String id, int indexQuestion) async {
    // Fetch the current questions array from Firestore
    DocumentSnapshot documentSnapshot =
        await fireStore.collection('questions-proactive-csc').doc(id).get();
    List<dynamic> questions = documentSnapshot.get('questions');

    // Remove the element at the specified index from the list
    if (indexQuestion >= 0 && indexQuestion < questions.length) {
      questions.removeAt(indexQuestion);

      // Update the 'questions' array in Firestore with the modified list
      await fireStore.collection('questions-proactive-csc').doc(id).update({
        'questions': questions,
      });
    }
  }
}
