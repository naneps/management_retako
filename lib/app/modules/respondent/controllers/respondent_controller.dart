import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/models/respondent_model.dart';
import 'package:getx_pattern_starter/app/services/firebase/respondent_strream_service.dart';

class RespondentController extends GetxController {
  final RespondentStreamService respondentStream =
      Get.find<RespondentStreamService>();

  RxInt totalRespondent = 0.obs;
  RxMap genderStatistic = {}.obs;
  RxMap smokingStatistic = {}.obs;
  @override
  void onInit() {
    super.onInit();
    genderStatistic.value = {
      "male": {"total": 0, "percentage": "0%"},
      "female": {"total": 0, "percentage": "0%"}
    };
    smokingStatistic.value = {
      "smoking": {"total": 0, "percentage": "0%"},
      "nonSmoking": {"total": 0, "percentage": "0%"}
    };
    _initializeData();
  }

  void _initializeData() {
    respondentStream.getRespondents().listen((event) {
      totalRespondent.value = event.length;
      final result = _calculateGenderStatistics(event);
      final smokingResult = _calculateStatisticSmoking(event);
      smokingStatistic.value = smokingResult;
      genderStatistic.value = result;
      print(result);
    });
  }

  Map<String, Map<String, dynamic>> _calculateStatisticSmoking(
      List<RespondentModel> respondents) {
    int totalSmoking = 0;
    int totalNonSmoking = 0;

    for (var respondent in respondents) {
      if (respondent.smoking == 'Ya') {
        totalSmoking++;
      } else if (respondent.smoking == 'Tidak') {
        totalNonSmoking++;
      }
    }

    final totalRespondents = totalSmoking + totalNonSmoking;
    final smokingPercentage = (totalSmoking / totalRespondents) * 100;
    final nonSmokingPercentage = (totalNonSmoking / totalRespondents) * 100;

    final Map<String, dynamic> smokingData = {
      'total': totalSmoking.toString(),
      'percentage': '${smokingPercentage.toStringAsFixed(1)}%',
    };

    final Map<String, dynamic> nonSmokingData = {
      'total': totalNonSmoking.toString(),
      'percentage': '${nonSmokingPercentage.toStringAsFixed(1)}%',
    };

    return {
      'smoking': smokingData,
      'nonSmoking': nonSmokingData,
    };
  }

  Map<String, Map<String, dynamic>> _calculateGenderStatistics(
      List<RespondentModel> respondents) {
    int totalMale = 0;
    int totalFemale = 0;

    for (var respondent in respondents) {
      if (respondent.gender == 'Laki-laki') {
        totalMale++;
      } else if (respondent.gender == 'Perempuan') {
        totalFemale++;
      }
    }

    final totalRespondents = totalMale + totalFemale;
    final malePercentage = (totalMale / totalRespondents) * 100;
    final femalePercentage = (totalFemale / totalRespondents) * 100;

    final Map<String, dynamic> maleData = {
      'total': totalMale.toString(),
      'percentage': '${malePercentage.toStringAsFixed(1)}%',
    };

    final Map<String, dynamic> femaleData = {
      'total': totalFemale.toString(),
      'percentage': '${femalePercentage.toStringAsFixed(1)}%',
    };

    return {
      'male': maleData,
      'female': femaleData,
    };
  }

  Stream<List<RespondentModel>> getRespondents() {
    return respondentStream.getRespondents();
  }
}
