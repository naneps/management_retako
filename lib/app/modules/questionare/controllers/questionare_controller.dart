import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionaryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //TODO: Implement QuestionareController
  late TabController tabController;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }
}
