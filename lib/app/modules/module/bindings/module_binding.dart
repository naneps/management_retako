import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/services/firebase/firestorage_services.dart';

import '../controllers/module_controller.dart';

class ModuleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ModuleController>(
      () => ModuleController(),
    );
    Get.lazyPut<FireStorageServices>(() => FireStorageServices());
  }
}
