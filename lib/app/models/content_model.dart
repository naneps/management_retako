import 'package:cloud_firestore/cloud_firestore.dart';

class ContentModel {
  String? id;
  String? title;
  String? url;
  ContentModel({this.title, this.url, this.id});

//  from fireStore
  ContentModel.fromFireStore(DocumentSnapshot doc) {
    id = doc.id;
    title = doc['title'] ?? '';
    url = doc['url'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['url'] = url;
    return data;
  }
}
