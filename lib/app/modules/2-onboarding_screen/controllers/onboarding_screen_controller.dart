import 'package:capy_wallet/app/data/services/wallet_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreenController extends GetxController {
  final WalletStorageService _storage = Get.find();
  RxInt actualPage = 0.obs;
  
  //=======Page 0 ============
  final Rx<TextEditingController> walletNameController = TextEditingController().obs;
  RxBool isOnChain = true.obs;
  RxBool isTestnet = false.obs;
  final introKey = GlobalKey<IntroductionScreenState>();
  RxBool isWalletNameFilled = false.obs;
  final isAdvancedOptionsExpanded = false.obs;

  //=======Page 1 ============
   RxBool obscure = true.obs;
  RxBool confirmed = false.obs;
   RxList<String> seedWords = [
    'abandon', 'ability', 'able', 'about', 'above', 'absent',
    'absorb', 'abstract', 'absurd', 'abuse', 'access', 'accident'
  ].obs; // Exemplo de palavras semente
 // final VoidCallback onContinue;

   void copyToClipboard() {
    final text = seedWords.join(' ');
    Clipboard.setData(ClipboardData(text: text));
    /* ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Palavras copiadas para a área de transferência!')),
    ); */
  }

  

  //========Page 2=======================

  

  @override
  void onInit() {
  
    super.onInit();
    walletNameController.value.addListener(() {
    isWalletNameFilled.value = walletNameController.value.text.trim().isNotEmpty;
  });

   actualPage = (introKey.currentState?.getCurrentPage() ?? 0).obs;
  }

 
}