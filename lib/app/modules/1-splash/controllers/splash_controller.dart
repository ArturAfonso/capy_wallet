import 'dart:async';

import 'package:capy_wallet/app/data/services/wallet_storage_service.dart';
import 'package:capy_wallet/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final storage = Get.find<WalletStorageService>();
  RxString valueRoute = ''.obs;

  //TODO: Implement SplashController

  void defineRoute() async {
    // Lógica para definir a rota inicial
    final wallets = await storage.getWallets();
    if (wallets.isEmpty) {
      valueRoute.value = 'Nenhuma carteira encontrada... indo para Onboarding';
     Timer.periodic(const Duration(seconds: 3), (timer) {
      timer.cancel();
      // Se não tem carteira, vai para o Onboarding
      Get.offAllNamed(Routes.PREONBOARDING_SCREEN);
}); 
} else {
   // Se tem carteira, vai para o Login
   

    valueRoute.value = 'Carteira encontrada... indo para Login';
     Timer.periodic(const Duration(seconds: 3), (timer) {
      timer.cancel();
      // Se não tem carteira, vai para o Onboarding
      Get.offAllNamed(Routes.LOGIN); 
}); 
}
  }

  final count = 0.obs;



  void increment() => count.value++;

  @override
  void onInit() {
    defineRoute();  
    super.onInit();
  }
}
