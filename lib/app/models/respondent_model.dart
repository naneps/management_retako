import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getx_pattern_starter/app/common/utils.dart';

class RespondentModel {
  String? id;
  String? age;
  String? gender;
  String? smoking;
  String? smokingSince;
  int? selfEfficacyScore;
  int? proactiveCSCScore;
  String? createdAt;
  RespondentModel({
    this.id,
    this.age,
    this.gender,
    this.smoking,
    this.smokingSince,
    this.proactiveCSCScore,
    this.selfEfficacyScore,
    this.createdAt,
  });
  // to json
  toJson() {
    return {
      "age": age,
      "gender": gender,
      "smoking": smoking,
      "smokingSince": smokingSince,
      "createdAt": DateTime.now().millisecondsSinceEpoch,
    };
  }

  // copy with
  RespondentModel copyWith({
    String? age,
    String? gender,
    String? smoking,
    String? smokingSince,
    int? selfEfficacyScore,
    int? proactiveCSCScore,
  }) {
    return RespondentModel(
      age: age ?? this.age,
      gender: gender ?? this.gender,
      smoking: smoking ?? this.smoking,
      smokingSince: smokingSince ?? this.smokingSince,
      selfEfficacyScore: selfEfficacyScore ?? this.selfEfficacyScore,
      proactiveCSCScore: proactiveCSCScore ?? this.proactiveCSCScore,
    );
  }

  // from json
  RespondentModel.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
        age = doc['age'],
        smoking = doc['smoking'],
        smokingSince = doc['smokingSince'],
        gender = doc['gender'],
        createdAt = doc['createdAt'];

  String get createdAtString => Utils.getFormattedDate(createdAt!);
}
