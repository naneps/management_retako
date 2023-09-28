import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/modules/questionare/controllers/form_efficacy_controller.dart';
import 'package:getx_pattern_starter/app/modules/questionare/controllers/form_proactive_controller.dart';
import 'package:getx_pattern_starter/app/modules/questionare/controllers/proactice_csc_controller.dart';
import 'package:getx_pattern_starter/app/modules/questionare/controllers/self_efficacy_controller.dart';

import '../controllers/questionare_controller.dart';

class QuestionaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuestionaryController>(
      () => QuestionaryController(),
    );
    Get.lazyPut<SelfEfficacyController>(() => SelfEfficacyController());
    Get.lazyPut<ProactiveCSCController>(() => ProactiveCSCController());
    Get.lazyPut<FormEfficacyController>(() => FormEfficacyController());
    Get.lazyPut<FormProactiveController>(() => FormProactiveController());
  }
}
