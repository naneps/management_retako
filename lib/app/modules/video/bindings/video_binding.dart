import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/services/firebase/firestorage_services.dart';

import '../controllers/video_controller.dart';

class VideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoController>(
      () => VideoController(),
    );
    Get.lazyPut<FireStorageServices>(() => FireStorageServices());
  }
}
