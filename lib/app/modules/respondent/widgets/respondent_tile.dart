import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/common/utils.dart';
import 'package:getx_pattern_starter/app/models/respondent_model.dart';
import 'package:getx_pattern_starter/app/modules/respondent/bindings/respondent_binding.dart';
import 'package:getx_pattern_starter/app/modules/respondent/views/respondent_detail_view.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RespondentTile extends StatelessWidget {
  const RespondentTile({
    super.key,
    required this.respondent,
  });

  final RespondentModel respondent;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: ListTile(
        onLongPress: () {
          // delete
          //
          Get.bottomSheet(RoundedContainer(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Hapus Responden?"),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("Batal"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Utils.confirmDialog(
                            title: "Hapus Responden?",
                            message:
                                "Apakah anda yakin ingin menghapus responden ini?",
                            onConfirm: () {
                              respondent.delete();
                              Get.back();
                              Get.back();
                            });
                      },
                      child: const Text("Hapus"),
                    ),
                  ],
                ),
              ],
            ),
          ));
        },
        onTap: () {
          Get.to(
            () => const RespondentDetailView(),
            arguments: respondent.id,
            binding: RespondentBinding(),
          );
        },
        leading: SizedBox(
          width: 50,
          height: 50,
          child: Center(
            child: Icon(
              respondent.gender == "Laki-laki"
                  ? MdiIcons.humanMale
                  : MdiIcons.humanFemale,
              size: 40,
              color:
                  respondent.gender == "Laki-laki" ? Colors.blue : Colors.pink,
            ),
          ),
        ),
        title: Text('${respondent.age!} Tahun'),
        subtitle: Row(
          children: [
            Text(respondent.smoking == "Ya" ? "Perokok" : "Bukan Perokok"),
            const SizedBox(
              width: 10,
            ),
            Text(respondent.gender!),
          ],
        ),
        trailing: Text(respondent.createdAtString),
      ),
    );
  }
}
