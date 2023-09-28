import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/common/utils.dart';
import 'package:getx_pattern_starter/app/models/self_efficacy_model.dart';
import 'package:getx_pattern_starter/app/modules/questionare/bindings/questionare_binding.dart';
import 'package:getx_pattern_starter/app/modules/questionare/controllers/self_efficacy_controller.dart';
import 'package:getx_pattern_starter/app/modules/questionare/views/form_selfefficacy_view.dart';
import 'package:getx_pattern_starter/app/themes/theme.dart';

class SelfEfficacyView extends GetView<SelfEfficacyController> {
  const SelfEfficacyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(
              () => const FormEfficacyView(),
              binding: QuestionaryBinding(),
              arguments: {
                "data": null,
                "indexQuestion": -1,
              },
            );
          },
          backgroundColor: Colors.brown,
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<List<QuestionSelfEfficiencyModel>>(
                  stream: controller.getQuestions(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        padding: const EdgeInsets.all(10),
                        separatorBuilder: (context, index) =>
                            const Divider(height: 5),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final data = snapshot.data![index];
                          return RoundedContainer(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                RoundedContainer(
                                  height: 100,
                                  width: 30,
                                  color: ThemeApp.backgroundColor,
                                  child: Center(
                                    child: Text(
                                      "${index + 1}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(data.questionText),
                                      const SizedBox(height: 10),
                                      const Text(
                                        "Jawaban: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      ListView.builder(
                                        itemCount: data.options.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Text(data.options[index]);
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      RoundedContainer(
                                        width: Get.width,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            // delete dan edit
                                            InkWell(
                                              onTap: () {
                                                Get.to(
                                                  () =>
                                                      const FormEfficacyView(),
                                                  binding: QuestionaryBinding(),
                                                  arguments: {
                                                    "data": data,
                                                    "indexQuestion": index,
                                                  },
                                                );
                                              },
                                              child: const Icon(
                                                Icons.edit,
                                                color: Colors.green,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Utils.confirmDialog(
                                                  title: "Hapus",
                                                  message:
                                                      "Apakah anda yakin ingin menghapus kuesioner ini?",
                                                  onConfirm: () {
                                                    controller
                                                        .deleteQuestionnaire(
                                                            data.id!);
                                                    Get.back();
                                                  },
                                                );
                                              },
                                              child: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
