import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/models/respondent_model.dart';
import 'package:getx_pattern_starter/app/services/firebase/respondent_strream_service.dart';

class RespondentDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final respondentService = Get.find<RespondentStreamService>();
  late final tabController;
  RxInt tabIndex = 0.obs;
  String id = '';
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    id = Get.arguments;
    tabController = TabController(length: 2, vsync: this);
  }

  Stream<RespondentModel> getRespondent() {
    return respondentService.getRespondent(id);
  }
}
