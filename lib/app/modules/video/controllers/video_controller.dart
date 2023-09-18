import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/utils.dart';
import 'package:getx_pattern_starter/app/models/content_model.dart';
import 'package:getx_pattern_starter/app/services/firebase/firestorage_services.dart';
import 'package:image_picker/image_picker.dart';

class VideoController extends GetxController {
  //TODO: Implement VideoController
  final firebase = FirebaseFirestore.instance;
  final FireStorageServices _fireStorageServices = Get.find();
  final Rx<XFile> url = XFile('').obs;
  final RxString title = ''.obs;
  Stream<List<ContentModel>> getVideo() {
    return firebase.collection('videos').snapshots().map((event) =>
        event.docs.map((e) => ContentModel.fromFireStore(e)).toList());
  }

  Future<void> deleteVideo(String id) async {
    try {
      // Hapus video dari koleksi Firestore
      await FirebaseFirestore.instance.collection('videos').doc(id).delete();

      // Dapatkan referensi penyimpanan Firebase untuk video yang akan dihapus
      final videoReference =
          FirebaseStorage.instance.ref().child('videos/$id.mp4');

      // Hapus video dari penyimpanan Firebase
      await videoReference.delete();

      print('Video berhasil dihapus dari Firestore dan penyimpanan Firebase.');
    } catch (error) {
      print('Terjadi kesalahan saat menghapus video: $error');
    }
  }

  void addVideo() async {
    try {
      final videoDocument = await firebase.collection('videos').add({
        'title': title.value,
        'url': "",
      });

      await _fireStorageServices.uploadFile(
        file: File(url.value.path),
        fileName: videoDocument.id,
        ref: 'videos',
        onUploading: () {
          Utils.loadingDialog();
        },
        onSuccess: (downloadUrl) async {
          await videoDocument.update({
            'url': downloadUrl,
          });
          url.value = XFile('');
          title.value = '';
          Get.back();
          Get.back();
        },
        onError: (e) {
          print(e);
        },
      );
    } catch (e) {
      print(e);
    }
  }

  void pickVideo() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowCompression: true,
      withData: true,
    );
    if (result != null) {
      url.value = XFile(result.files.single.path!);
    } else {
      // User canceled the picker
    }
  }
}
