import 'package:get/get.dart';

import '../controllers/home_lightning_controller.dart';

class HomeLightningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeLightningController>(
      () => HomeLightningController(),
    );
  }
}
