import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/common/ui/heading_text.dart';
import 'package:getx_pattern_starter/app/common/utils.dart';
import 'package:getx_pattern_starter/app/models/respondent_model.dart';
import 'package:getx_pattern_starter/app/modules/respondent/bindings/respondent_binding.dart';
import 'package:getx_pattern_starter/app/modules/respondent/views/all_respondent_view.dart';
import 'package:getx_pattern_starter/app/modules/respondent/widgets/respondent_tile.dart';
import 'package:getx_pattern_starter/app/themes/theme.dart';

import '../controllers/respondent_controller.dart';

class RespondentView extends GetView<RespondentController> {
  const RespondentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RoundedContainer(
          padding: const EdgeInsets.all(10),
          color: Colors.transparent,
          width: Get.width,
          height: Get.height,
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'RETAKO',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              StaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: [
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: RoundedContainer(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          RoundedContainer(
                            width: 60,
                            height: 60,
                            gradient: LinearGradient(
                              colors: [
                                ThemeApp.backgroundColor.withOpacity(0.5),
                                ThemeApp.backgroundColor,
                                ThemeApp.backgroundColor.withOpacity(0.5),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            child: Center(
                              child: Obx(() {
                                return Text(
                                  controller.totalRespondent.value.toString(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                );
                              }),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Total Responden',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 1,
                    child: RoundedContainer(
                      child: Obx(() {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              controller.smokingStatistic['smoking']
                                      ['percentage']
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Perokok',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: RoundedContainer(
                      child: Obx(() {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              controller.genderStatistic['male']['percentage']
                                      .toString() ??
                                  '0',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Laki-laki',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: RoundedContainer(
                      child: Obx(() {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              controller.genderStatistic['female']['percentage']
                                      .toString() ??
                                  '0',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Perempuan',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 4,
                    mainAxisCellCount: 2,
                    child: StreamBuilder<List<RespondentModel>>(
                        stream: controller.getRespondents(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: Utils.loadingWidget(),
                            );
                          }
                          return RoundedContainer(
                            child: Row(
                              children: [
                                Expanded(
                                  child: createAgeChart(
                                      snapshot.data ?? <RespondentModel>[]),
                                ),
                                const Expanded(
                                  child: Text(
                                    "Grafik Usia Responden",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(
                      thickness: 1,
                    ),
                    HeadingText(
                      leftText: 'Data Responden',
                      rightText: 'Lihat Semua',
                      color: ThemeApp.lightColor,
                      onPressRightText: () {
                        // Get.toNamed('/respondent/list');
                        Get.to(
                          () => const AllRespondentView(),
                          binding: RespondentBinding(),
                          transition: Transition.rightToLeftWithFade,
                          fullscreenDialog: true,
                        );
                      },
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Expanded(
                      child: StreamBuilder(
                        stream: controller.getRespondents(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: Utils.loadingWidget(),
                            );
                          } else if (snapshot.hasData) {
                            return ListView.separated(
                              itemBuilder: (context, index) {
                                final respondent = snapshot.data![index];
                                return RespondentTile(respondent: respondent);
                              },
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  thickness: 1,
                                );
                              },
                              itemCount: snapshot.data!.length,
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget createAgeChart(List<RespondentModel> respondents) {
    // Hitung frekuensi usia
    Map<String, int> ageFrequency = {};
    for (var respondent in respondents) {
      String age = respondent.age ??
          'Unknown'; // Jika usia tidak ada, tandai sebagai 'Unknown'
      ageFrequency[age] = (ageFrequency[age] ?? 0) + 1;
    }

    // Ubah data usia ke dalam bentuk data yang diperlukan untuk grafik
    List<PieChartSectionData> ageSections = ageFrequency.entries.map((entry) {
      return PieChartSectionData(
        color:
            getRandomColor(), // Fungsi ini menghasilkan warna acak, Anda dapat menggantinya sesuai keinginan.
        value: entry.value.toDouble(),
        title: "${entry.key} tahun ",
        radius: 80,
        showTitle: true,
        borderSide: const BorderSide(
          color: Colors.black,
          width: 1,
        ),
        titlePositionPercentageOffset: 0.6,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      );
    }).toList();

    // Buat grafik
    return PieChart(
      PieChartData(
        sections: ageSections,
        borderData: FlBorderData(show: true),
        pieTouchData: PieTouchData(),
        centerSpaceColor: Colors.white,
        centerSpaceRadius: 2,
        sectionsSpace: 2,
      ),
      swapAnimationCurve: Curves.bounceIn,
    );
  }

// Fungsi untuk mendapatkan warna acak
  Color getRandomColor() {
    final random = Random();
    return Color.fromRGBO(
      random.nextInt(150),
      random.nextInt(250),
      random.nextInt(250),
      random.nextDouble(),
    );
  }
}
