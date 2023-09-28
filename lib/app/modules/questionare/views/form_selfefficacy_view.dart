import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/buttons/x_button.dart';
import 'package:getx_pattern_starter/app/common/input/x_field.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/common/ui/x_appbar.dart';
import 'package:getx_pattern_starter/app/modules/questionare/controllers/form_efficacy_controller.dart';

class FormEfficacyView extends GetView<FormEfficacyController> {
  const FormEfficacyView({super.key});

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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Pertanyaan ",
                        ),
                        XTextField(
                          minLines: 1,
                          maxLines: 5,
                          hintText: "Masukkan pertanyaan",
                          initialValue: controller.questionText.value,
                          onChanged: (value) {
                            controller.questionText.value = value;
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Jawaban",
                            ),
                            IconButton(
                              onPressed: () {
                                controller.answers.add("");
                                controller.weights.add(0);
                              },
                              icon: const Icon(Icons.add),
                            ),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                controller.useTemplateAnswer();
                              },
                              child: const Text(
                                "Gunakan Jawaban Default",
                                style: TextStyle(),
                              ),
                            )
                          ],
                        ),
                        Obx(
                          () => ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 5,
                            ),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.answers.length,
                            itemBuilder: (context, index) {
                              controller.weights[index] = index + 1;
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Jawaban ${index + 1}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: XTextField(
                                          minLines: 1,
                                          maxLines: 5,
                                          initialValue:
                                              controller.answers[index],
                                          hintText: "Masukkan jawaban",
                                          onChanged: (value) {
                                            controller.answers[index] = value;
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          controller.answers.removeAt(index);
                                          controller.weights.removeAt(index);
                                        },
                                        icon: const Icon(Icons.delete),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Bobot Jawaban ${controller.weights[index]}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            RoundedContainer(
              margin: const EdgeInsets.all(10),
              child: XButton(
                text: "Simpan",
                onPressed: () {
                  controller.addQuestionary();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
