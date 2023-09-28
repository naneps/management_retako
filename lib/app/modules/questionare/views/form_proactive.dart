import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/buttons/x_button.dart';
import 'package:getx_pattern_starter/app/common/input/x_field.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/common/ui/x_appbar.dart';
import 'package:getx_pattern_starter/app/modules/questionare/controllers/form_proactive_controller.dart';

class FormProactive extends GetView<FormProactiveController> {
  const FormProactive({super.key});

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
                          initialValue: controller.question.value,
                          onChanged: (value) {
                            // controller.questionText.value = value;
                            controller.question.value = value;
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
                                // controller.answers.add("");
                                // controller.weights.add(0);
                                controller.addAnswer();
                              },
                              icon: const Icon(Icons.add),
                            ),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                // controller.useTemplateAnswer();
                                controller.setDefaultAnswers();
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
                              final listAnswerFromMap =
                                  controller.answers.entries.toList();
                              final key = listAnswerFromMap[index].key;
                              final value = listAnswerFromMap[index].value;
                              // controller.answers.keys.toList()[index + 1] = key;
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
                                          initialValue: value,
                                          hintText: "Masukkan jawaban",
                                          onChanged: (value) {
                                            if (key.runtimeType == int) {
                                              controller.answers.remove(key);
                                              controller
                                                      .answers[key.toString()] =
                                                  value;
                                            } else {
                                              controller.answers[key] = value;
                                            }
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          controller.answers.remove(key);
                                        },
                                        icon: const Icon(Icons.delete),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Bobot $key",
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
                  if (Get.arguments['isEdit']) {
                    controller.updateQuestion();
                  } else {
                    controller.saveQuestion();
                  }

                  print(
                    "answers: ${controller.answers}, question: ${controller.question}",
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
