import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/utils.dart';
import 'package:getx_pattern_starter/app/models/content_model.dart';
import 'package:getx_pattern_starter/app/services/firebase/firestorage_services.dart';
import 'package:image_picker/image_picker.dart';

class ModuleController extends GetxController {
  //TODO: Implement ModuleController
  final fireStorageServices = Get.find<FireStorageServices>();
  final Rx<XFile> url = XFile('').obs;
  final RxString title = ''.obs;
  final fireStore = FirebaseFirestore.instance;

  Stream<List<ContentModel>> getModule() {
    return fireStore.collection('modules').snapshots().map((event) =>
        event.docs.map((e) => ContentModel.fromFireStore(e)).toList());
  }

  void deleteModule(String id) {
    try {
      fireStore.collection('modules').doc(id).delete();
      FirebaseStorage.instance.ref().child('modules/$id').delete();
    } catch (e) {}
  }

  void addModule() async {
    final moduleDocument = await fireStore.collection('modules').add({
      'title': title.value,
      'url': "",
    });

    await fireStorageServices.uploadFile(
      file: File(url.value.path),
      fileName: moduleDocument.id,
      ref: 'modules',
      onUploading: () {
        Utils.loadingWidget();
      },
      onSuccess: (downloadUrl) async {
        await moduleDocument.update({
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

  void pickPdf() async {
    final pickedFile = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (pickedFile != null) {
      url.value = XFile(pickedFile.files.single.path!);
    }
  }
}
