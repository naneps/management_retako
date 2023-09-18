import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/models/proactive_model.dart';
import 'package:getx_pattern_starter/app/models/respondent_model.dart';
import 'package:getx_pattern_starter/app/models/self_efficacy_model.dart';

class RespondentStreamService extends GetxService {
  final firebaseFirestore = FirebaseFirestore.instance;
  final respondentCollection =
      FirebaseFirestore.instance.collection('respondents');

  Stream<QuerySnapshot<Map<String, dynamic>>> getRespondentsStream() {
    return respondentCollection.snapshots();
  }

  Stream<List<RespondentModel>> getRespondents() {
    return respondentCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => RespondentModel.fromFirestore(doc))
          .toList();
    });
  }

  Stream<RespondentModel> getRespondent(String id) {
    return respondentCollection.doc(id).snapshots().map(
          (doc) => RespondentModel.fromFirestore(doc),
        );
  }

  Stream<ProactiveModel> getProactive(String id) {
    return respondentCollection
        .doc(id)
        .collection("questionnaire")
        .doc("proactiveCSC")
        .snapshots()
        .map(
          (doc) => doc.exists
              ? ProactiveModel.fromFirestore(doc)
              : throw Exception("Document not found"),
        )
        .handleError((error) {
      print("Error fetching proactive document: $error");
      // Handle the error as needed, e.g., return a default value or show an error message.
    });
  }

  Stream<SelfEfficacyModel> getSelfEfficacy(String id) {
    print("id: $id");
    return respondentCollection
        .doc(id)
        .collection("questionnaire")
        .doc("selfEfficacy")
        .snapshots()
        .map(
          (doc) => doc.exists
              ? SelfEfficacyModel.fromFirestore(doc)
              : throw Exception("Document not found"),
        )
        .handleError((error) {
      print("Error fetching selfEfficacy document: $error");
      // Handle the error as needed, e.g., return a default value or show an error message.
    });
  }
}
