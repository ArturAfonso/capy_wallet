import 'package:get/get.dart';

import '../controllers/home_onchain_controller.dart';

class HomeOnchainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeOnchainController>(
      () => HomeOnchainController(),
    );
  }
}
