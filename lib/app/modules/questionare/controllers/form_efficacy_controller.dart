import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/utils.dart';
import 'package:getx_pattern_starter/app/models/self_efficacy_model.dart';

class FormEfficacyController extends GetxController {
  RxInt totalAnswer = 0.obs;

  RxList<String> answers = <String>[].obs;
  RxList<int> weights = <int>[].obs;
  RxString questionText = ''.obs;
  // final questionId = Get.arguments['data'].id as String;
  final fireStore = FirebaseFirestore.instance;

  void addQuestionary() async {
    if (questionText.value.isEmpty) {
      Utils.snackMessage(
        type: "warning",
        messages: "Pertanyaan tidak boleh kosong",
        title: "Peringatan",
      );
      return;
    }

    try {
      if (Get.arguments['data'] != null) {
        final questionId = Get.arguments['data'].id as String;
        print(questionId);
        await fireStore
            .collection('questions-self-efficiency')
            .doc(questionId)
            .update({
          'text': questionText.value,
          'options': answers,
          'weights': weights,
        });
      } else {
        await fireStore.collection('questions-self-efficiency').add({
          'text': questionText.value,
          'options': answers,
          'weights': weights,
        });
      }

      Future.delayed(
        const Duration(milliseconds: 100),
        () {
          Utils.snackMessage(
            type: "success",
            messages: "Kuesioner berhasil disimpan",
            title: "Berhasil",
          );
        },
      );

      Get.back();
    } catch (e) {
      Utils.snackMessage(
        type: "error",
        messages: "Kuesioner gagal ditambahkan: $e",
        title: "Gagal",
      );
    }
  }

  void useTemplateAnswer() {
    for (var element in dAnswers) {
      answers.add(element);
    }
    for (var element in dWeights) {
      weights.add(element);
    }
  }

  List<String> dAnswers = [
    "Sama sekali tidak yakin",
    "Tidak terlalu yakin",
    "Lebih atau kurang yakin",
    "Cukup yakin",
    "Sangat yakin"
  ];
  List<int> dWeights = [1, 2, 3, 4, 5];
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments['data'] != null) {
      final data = Get.arguments['data'] as QuestionSelfEfficiencyModel;
      questionText.value = data.questionText;
      answers.value = data.options.cast<String>();
      weights.value = data.weights.cast<int>();
    }
  }
}
