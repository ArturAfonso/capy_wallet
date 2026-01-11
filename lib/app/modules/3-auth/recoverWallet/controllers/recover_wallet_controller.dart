import 'package:capy_wallet/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';




class RecoverWalletController extends GetxController {
  final walletNameController = TextEditingController();
  final List<TextEditingController> seedControllers = List.generate(12, (_) => TextEditingController());
  
  final isWalletNameFilled = false.obs;
  final allSeedWordsFilled = false.obs;
  final canRecover = false.obs;
 

 
  @override
  void onInit() {
    super.onInit();
    
    // Listener para o nome da carteira
    walletNameController.addListener(() {
      isWalletNameFilled.value = walletNameController.text.trim().isNotEmpty;
      _checkCanRecover();
    });

    // Listeners para os campos de seed
    for (var controller in seedControllers) {
      controller.addListener(() {
        _checkAllSeedsFilled();
        _checkCanRecover();
      });
    }
  }

  void _checkAllSeedsFilled() {
    allSeedWordsFilled.value = seedControllers.every((c) => c.text.trim().isNotEmpty);
  }

  void _checkCanRecover() {
    canRecover.value = isWalletNameFilled.value && allSeedWordsFilled.value;
  }

  void recoverWallet() {
    if (!canRecover.value) return;
    
    final seeds = seedControllers.map((c) => c.text.trim()).toList();
    // Aqui você implementa a lógica de recuperação
    print('Nome: ${walletNameController.text}');
    print('Seeds: $seeds');
    
    // Exemplo: navegar para a próxima tela
     Get.toNamed(Routes.PIN);
  }


  void pasteFromClipboard() async {
  final data = await Clipboard.getData('text/plain');
  if (data?.text == null) return;
  final words = data!.text!.trim().split(RegExp(r'\s+'));
  for (int i = 0; i < 12; i++) {
    seedControllers[i].text = (i < words.length) ? words[i] : '';
  }
  _checkAllSeedsFilled();
  _checkCanRecover();
}

  @override
  void onClose() {
    walletNameController.dispose();
    for (var controller in seedControllers) {
      controller.dispose();
    }
    super.onClose();
  }

}
