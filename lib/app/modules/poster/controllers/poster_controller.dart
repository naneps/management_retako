import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/utils.dart';
import 'package:getx_pattern_starter/app/models/content_model.dart';
import 'package:getx_pattern_starter/app/services/firebase/firestorage_services.dart';
import 'package:image_picker/image_picker.dart';

class PosterController extends GetxController {
  //TODO: Implement PosterController
  final fireStorageServices = Get.find<FireStorageServices>();
  final Rx<XFile> url = XFile('').obs;
  final RxString title = ''.obs;
  final fireStore = FirebaseFirestore.instance;

  Stream<List<ContentModel>> getPoster() {
    return fireStore.collection('posters').snapshots().map((event) =>
        event.docs.map((e) => ContentModel.fromFireStore(e)).toList());
  }

  void deletePoster(String id) {
    try {
      fireStore.collection('posters').doc(id).delete();
      FirebaseStorage.instance.ref().child('posters/$id').delete();
    } catch (e) {}
  }

  void addPoster() async {
    final posterDocument = await fireStore.collection('posters').add({
      'title': title.value,
      'url': "",
    });

    await fireStorageServices.uploadFile(
      file: File(url.value.path),
      fileName: posterDocument.id,
      ref: 'posters',
      onUploading: () {
        Utils.loadingWidget();
      },
      onSuccess: (downloadUrl) async {
        await posterDocument.update({
          'url': downloadUrl,
        });
        url.value = XFile('');
        title.value = '';
        Get.back();
      },
      onError: (e) {
        Get.back();
        Get.snackbar('Error', e.toString());
      },
    );
  }

  void pickImage() async {
    final pickedFile =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (pickedFile != null) {
      url.value = XFile(pickedFile.files.single.path!);
    }
  }
}
