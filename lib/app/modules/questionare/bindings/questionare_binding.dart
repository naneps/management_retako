import 'package:get/get.dart';

import '../controllers/questionare_controller.dart';

class QuestionaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuestionaryController>(
      () => QuestionaryController(),
    );
  }
}
