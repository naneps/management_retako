import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/common/utils.dart';
import 'package:getx_pattern_starter/app/models/proactive_model.dart';
import 'package:getx_pattern_starter/app/themes/theme.dart';

class ProactiveWidget extends StatelessWidget {
  Stream<ProactiveModel> proactiveStream;
  ProactiveWidget({
    super.key,
    required this.proactiveStream,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: proactiveStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Utils.loadingWidget(),
          );
        }

        if (snapshot.hasData) {
          final proactive = snapshot.data;
          return RoundedContainer(
            color: Colors.white10,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Hasil: ${getScoreCondition(proactive!.score!)}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "Skor : ${proactive.score!}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Expanded(
                    child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: proactive.questionnaires!.length,
                  itemBuilder: (context, index) {
                    final question = proactive.questionnaires![index];
                    return RoundedContainer(
                      // padding: const EdgeInsets.all(10),
                      radius: 5,
                      child: Column(
                        children: [
                          RoundedContainer(
                            radius: 10,
                            width: Get.width,
                            padding: const EdgeInsets.all(10),
                            color: ThemeApp.primaryColor,
                            child: Text(
                              question.category!,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ListView.separated(
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: question.questions!.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final questionItem = question.questions![index];
                              return ListTile(
                                contentPadding: const EdgeInsets.all(5),
                                leading: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      "${index + 1}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  questionItem!.statement,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Row(
                                  children: [
                                    const Text(
                                      "Jawaban: ",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      questionItem.selectedAnswer!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ))
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }

  String? getScoreCondition(int score) {
    if (score <= 36 && score <= 71) {
      return "Rendah";
    } else if (score >= 72 && score <= 107) {
      return "Cukup";
    } else if (score >= 108 && score <= 144) {
      return "Tinggi";
    }
    return null;
  }
}
