import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/common/ui/x_appbar.dart';
import 'package:getx_pattern_starter/app/common/utils.dart';
import 'package:getx_pattern_starter/app/modules/respondent/controllers/respondent_detail_controller.dart';
import 'package:getx_pattern_starter/app/modules/respondent/widgets/proactive_widget.dart';
import 'package:getx_pattern_starter/app/modules/respondent/widgets/self_efficaty_widget.dart';
import 'package:getx_pattern_starter/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RespondentDetailView extends GetView<RespondentDetailController> {
  const RespondentDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            XAppBar(
              title: 'Detail Responden',
              hasRightIcon: true,
            ),
            Expanded(
              child: StreamBuilder(
                stream: controller.getRespondent(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Utils.loadingWidget(),
                    );
                  }

                  if (snapshot.hasData) {
                    final respondent = snapshot.data;
                    return ListView(
                      children: [
                        RoundedContainer(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            leading: SizedBox(
                              width: 50,
                              height: 50,
                              child: Center(
                                child: Icon(
                                  respondent!.gender == "Laki-laki"
                                      ? MdiIcons.humanMale
                                      : MdiIcons.humanFemale,
                                  size: 40,
                                  color: respondent.gender == "Laki-laki"
                                      ? Colors.blue
                                      : Colors.pink,
                                ),
                              ),
                            ),
                            title: Text('${respondent.age!} Tahun'),
                            subtitle: Row(
                              children: [
                                Text(respondent.smoking == "Ya"
                                    ? "Perokok"
                                    : "Bukan Perokok"),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(respondent.gender!),
                              ],
                            ),
                            trailing: Text(respondent.createdAtString),
                          ),
                        ),
                        RoundedContainer(
                          height: Get.height,
                          color: Colors.white10,
                          margin: const EdgeInsets.all(10),
                          // padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              TabBar(
                                controller: controller.tabController,
                                tabs: const [
                                  Tab(
                                    child: Text(
                                      'Proactive CSC',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      'Self Efficacy',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                                indicatorColor: ThemeApp.primaryColor,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: TabBarView(
                                  controller: controller.tabController,
                                  children: [
                                    ProactiveWidget(
                                        proactiveStream: controller
                                            .respondentService
                                            .getProactive(respondent.id!)),
                                    SelfEfficacyWidget(
                                      selfEfficacyStream: controller
                                          .respondentService
                                          .getSelfEfficacy(respondent.id!),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
