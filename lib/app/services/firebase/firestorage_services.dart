import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class FireStorageServices extends GetxService {
  FirebaseStorage? _storage;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _storage = FirebaseStorage.instance;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<String?> uploadFile(
      {required File file,
      required String fileName,
      required String ref,
      void Function()? onUploading,
      void Function(String)? onSuccess,
      void Function(String)? onError}) async {
    try {
      Reference storageReference =
          FirebaseStorage.instance.ref().child(ref).child(fileName);
      UploadTask uploadTask = storageReference.putFile(file);
      if (onUploading != null) {
        onUploading();
      }
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      if (onSuccess != null) {
        onSuccess(downloadUrl);
      }
      return downloadUrl;
    } on FirebaseException catch (e) {
      if (onError != null) {
        onError(e.toString());
      }
      print(e.toString());
      return null;
    }
  }
}
