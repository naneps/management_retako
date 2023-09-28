import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/input/x_field.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/common/utils.dart';
import 'package:getx_pattern_starter/app/modules/questionare/bindings/questionare_binding.dart';
import 'package:getx_pattern_starter/app/modules/questionare/controllers/proactice_csc_controller.dart';
import 'package:getx_pattern_starter/app/modules/questionare/views/form_proactive.dart';
import 'package:getx_pattern_starter/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProactiveCSCView extends GetView<ProactiveCSCController> {
  const ProactiveCSCView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: RoundedContainer(
          color: Colors.transparent,
          radiusType: RadiusType.circle,
          margin: const EdgeInsets.only(bottom: 20),
          child: FloatingActionButton(
            onPressed: () {
              Get.defaultDialog(
                title: "Tambah Kategori",
                content: RoundedContainer(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("Nama Kategori"),
                      const SizedBox(
                        height: 10,
                      ),
                      XTextField(
                        onChanged: (value) {
                          controller.name.value = value;
                        },
                        controller: TextEditingController(),
                        hintText: "Nama Kategori",
                      )
                    ],
                  ),
                ),
                confirm: ElevatedButton(
                  onPressed: () {
                    controller.addCategory();
                    Get.back();
                  },
                  child: const Text("Tambah"),
                ),
              );
            },
            backgroundColor: Colors.brown,
            child: const Icon(Icons.add),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: controller.getQuestions(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(10),
                        separatorBuilder: (context, index) =>
                            const Divider(height: 5),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final category = snapshot.data![index];
                          return RoundedContainer(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RoundedContainer(
                                  radius: 0,
                                  width: Get.width,
                                  padding: const EdgeInsets.all(5),
                                  color: ThemeApp.primaryColor,
                                  child:
                                      Center(child: Text(category.category!)),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(
                                    "Pernyataan:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: category.questions!.length,
                                  itemBuilder: (context, indexQuestion) {
                                    final listFromMap = category
                                        .questions![indexQuestion]!
                                        .answers!
                                        .entries
                                        .toList();

                                    final statement =
                                        category.questions![indexQuestion];
                                    return ExpansionTile(
                                        leading: SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: Center(
                                            child: Text(
                                              "${indexQuestion + 1}.",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        title: Row(
                                          children: [
                                            Expanded(
                                                child:
                                                    Text(statement!.statement)),
                                            RoundedContainer(
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Get.to(
                                                          () =>
                                                              const FormProactive(),
                                                          arguments: {
                                                            "categoryId":
                                                                category.id,
                                                            "question": category
                                                                    .questions![
                                                                indexQuestion],
                                                            "indexQuestion":
                                                                indexQuestion,
                                                            "isEdit": true
                                                          },
                                                          binding:
                                                              QuestionaryBinding());
                                                    },
                                                    child: const Icon(
                                                      MdiIcons.pencil,
                                                      size: 15,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      controller.deleteQuestion(
                                                          category.id!,
                                                          indexQuestion);
                                                    },
                                                    child: const Icon(
                                                      MdiIcons.delete,
                                                      size: 15,
                                                      color: Colors.red,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        expandedAlignment: Alignment.topLeft,
                                        childrenPadding:
                                            const EdgeInsets.all(10),
                                        expandedCrossAxisAlignment:
                                            CrossAxisAlignment.start, // default

                                        children: [
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Jawaban",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: listFromMap.length,
                                            itemBuilder: (context, index) {
                                              final entry = listFromMap[index];
                                              final key = entry.key;
                                              final value = entry.value;
                                              return RoundedContainer(
                                                child: Text(value),
                                              );
                                            },
                                          )
                                        ]);
                                  },
                                ),
                                RoundedContainer(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.defaultDialog(
                                              title: "Tambah Kategori",
                                              content: RoundedContainer(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    const Text("Nama Kategori"),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    XTextField(
                                                      onChanged: (value) {
                                                        controller.name.value =
                                                            value;
                                                      },
                                                      initialValue:
                                                          category.category!,
                                                      hintText: "Nama Kategori",
                                                    )
                                                  ],
                                                ),
                                              ),
                                              confirm: ElevatedButton(
                                                onPressed: () {
                                                  controller.updateCategory(
                                                      category.id!);
                                                  Get.back();
                                                },
                                                child: const Text("Simpan"),
                                              ),
                                            );
                                          },
                                          child: const Icon(
                                            MdiIcons.pencil,
                                            color: Colors.green,
                                          ),
                                        ),
                                        // tambah pernyataan
                                        TextButton(
                                          onPressed: () {
                                            Get.to(() => const FormProactive(),
                                                arguments: {
                                                  "categoryId": category.id,
                                                  "question": null,
                                                  "indexQuestion": null,
                                                  "isEdit": false
                                                },
                                                binding: QuestionaryBinding());
                                          },
                                          child:
                                              const Text("Tambah Pernyataan"),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Utils.confirmDialog(
                                              title: "Hapus Kategori",
                                              message:
                                                  "Apakah anda yakin ingin menghapus kategori ini?",
                                              onConfirm: () {
                                                controller.deleteCategory(
                                                    category.id!);
                                                Get.back();
                                              },
                                            );
                                          },
                                          child: const Icon(
                                            MdiIcons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ))
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
              )
            ],
          ),
        ));
  }
}
