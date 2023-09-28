import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/models/self_efficacy_model.dart';

import '../../../common/utils.dart';

class SelfEfficacyController extends GetxController {
  final fireStore = FirebaseFirestore.instance;

  Stream<List<QuestionSelfEfficiencyModel>> getQuestions() {
    return fireStore.collection('questions-self-efficiency').snapshots().map(
          (event) => event.docs
              .map((e) => QuestionSelfEfficiencyModel.fromFirestore(e))
              .toList(),
        );
  }

  Future<void> saveQuestionnaire() async {}
  Future<void> updateQuestionnaire() async {}
  Future<void> deleteQuestionnaire(String id) async {
    try {
      await fireStore.collection('questions-self-efficiency').doc(id).delete();
    } catch (e) {
      Utils.snackMessage(
        type: "error",
        messages: "Kuesioner gagal dihapus: $e",
        title: "Gagal",
      );
    }
  }
}
