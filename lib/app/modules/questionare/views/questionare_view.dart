import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/ui/x_appbar.dart';
import 'package:getx_pattern_starter/app/modules/questionare/views/proactive_csc_view.dart';
import 'package:getx_pattern_starter/app/modules/questionare/views/self_efficacy_view.dart';

import '../controllers/questionare_controller.dart';

class QuestionaryView extends GetView<QuestionaryController> {
  const QuestionaryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          XAppBar(
            title: "Kelola Kuesioner",
            hasRightIcon: true,
          ),
          TabBar(
            controller: controller.tabController,
            tabs: const [
              Tab(
                text: "Self Efficacy",
              ),
              Tab(
                text: "Proactive CSC",
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: const [
                SelfEfficacyView(),
                ProactiveCSCView(),
              ],
            ),
          )
        ],
      )),
    );
  }
}
