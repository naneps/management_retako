import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/common/ui/x_appbar.dart';
import 'package:getx_pattern_starter/app/common/utils.dart';
import 'package:getx_pattern_starter/app/modules/respondent/controllers/all_respondent_controller.dart';
import 'package:getx_pattern_starter/app/modules/respondent/widgets/respondent_tile.dart';

class AllRespondentView extends GetView<AllRespondentController> {
  const AllRespondentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RoundedContainer(
          color: Colors.transparent,
          child: Column(
            children: [
              XAppBar(
                title: 'Semua Responden',
                hasRightIcon: true,
              ),
              Expanded(
                child: StreamBuilder(
                  stream: controller.getRespondentList(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Utils.loadingWidget();
                    } else if (snapshot.hasData) {
                      return ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        padding: const EdgeInsets.all(10),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return RespondentTile(
                              respondent: snapshot.data![index]);
                        },
                      );
                    }
                    return const SizedBox();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
