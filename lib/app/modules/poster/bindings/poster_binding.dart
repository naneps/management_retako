import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/input/xpicker_image.dart';
import 'package:getx_pattern_starter/app/services/firebase/firestorage_services.dart';

import '../controllers/poster_controller.dart';

class PosterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PosterController>(
      () => PosterController(),
    );
    Get.lazyPut<PickerController>(() => PickerController());
    Get.lazyPut<FireStorageServices>(() => FireStorageServices());
  }
}
