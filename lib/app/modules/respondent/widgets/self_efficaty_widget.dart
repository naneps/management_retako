import 'package:flutter/material.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/common/utils.dart';
import 'package:getx_pattern_starter/app/models/self_efficacy_model.dart';

class SelfEfficacyWidget extends StatelessWidget {
  Stream<SelfEfficacyModel> selfEfficacyStream;
  SelfEfficacyWidget({
    super.key,
    required this.selfEfficacyStream,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: selfEfficacyStream,
      builder: (context, snapshot) {
        print(snapshot.data);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Utils.loadingWidget(),
          );
        }
        if (snapshot.hasData) {
          final selfEfficacy = snapshot.data;
          return RoundedContainer(
            color: Colors.white10,
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Hasil: ${analyzeSelfEfficacySmoking(selfEfficacy!.score!)}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "Skor : ${selfEfficacy.score}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: selfEfficacy.questionnaires!.length,
                    // shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final question = selfEfficacy.questionnaires![index];
                      return ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        leading: SizedBox(
                          width: 40,
                          height: 40,
                          child: Center(
                            child: Text(
                              "${index + 1}",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          question.questionText,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            const Text(
                              "Jawaban",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              question.selectedOption!.value,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  String? analyzeSelfEfficacySmoking(int selfEfficacyScore) {
    if (selfEfficacyScore <= 12 && selfEfficacyScore <= 27) {
      return "Rendah";
    } else if (selfEfficacyScore >= 28 && selfEfficacyScore <= 43) {
      return "Cukup";
    } else if (selfEfficacyScore >= 44 && selfEfficacyScore <= 60) {
      return "Tinggi";
    }
    return null;
  }
}
