import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/models/respondent_model.dart';
import 'package:getx_pattern_starter/app/services/firebase/respondent_strream_service.dart';

class AllRespondentController extends GetxController {
  final respondentService = Get.find<RespondentStreamService>();
  RxList<RespondentModel> respondentList = RxList<RespondentModel>([]);

  Stream<List<RespondentModel>> getRespondentList() {
    return respondentService.getRespondents();
  }
}
