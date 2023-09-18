import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/modules/respondent/controllers/all_respondent_controller.dart';
import 'package:getx_pattern_starter/app/modules/respondent/controllers/respondent_detail_controller.dart';
import 'package:getx_pattern_starter/app/services/firebase/respondent_strream_service.dart';

import '../controllers/respondent_controller.dart';

class RespondentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RespondentController>(
      () => RespondentController(),
    );
    Get.lazyPut<RespondentStreamService>(() => RespondentStreamService());
    Get.lazyPut<AllRespondentController>(() => AllRespondentController());
    Get.lazyPut<RespondentDetailController>(() => RespondentDetailController());
  }
}
