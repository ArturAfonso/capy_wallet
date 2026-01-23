import 'package:capy_wallet/app/data/models/wallet_info.dart';
import 'package:capy_wallet/app/data/services/wallet_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capy_wallet/app/routes/app_pages.dart';

class PinController extends GetxController {
  final storage = Get.find<WalletStorageService>();
  final pinController = TextEditingController();
  final confirmPinController = TextEditingController();
  
  final isCreatingPin = true.obs; // true = criar, false = confirmar
  final obscurePin = true.obs;
  final obscureConfirmPin = true.obs;
  final isPinValid = false.obs;
  final isConfirmPinValid = false.obs;
  final pinsMatch = true.obs;

  final int minLength = 6;
  final int maxLength = 100;

  // Variável para guardar a carteira que veio da tela anterior
  late WalletInfo targetWallet;

  @override
  void onInit() {
    super.onInit();

    // 1. Recupera o objeto passado por argumento
    // Se vier nulo (ex: reload direto), trate o erro ou redirecione
    if (Get.arguments != null && Get.arguments is WalletInfo) {
      targetWallet = Get.arguments as WalletInfo;
    } else {
      // Fallback de segurança (opcional)
      print("Erro: Nenhuma carteira passada para o PIN");
      Get.back(); 
    }
    
    pinController.addListener(() {
      isPinValid.value = _isValidPin(pinController.text);
    });

    confirmPinController.addListener(() {
      isConfirmPinValid.value = _isValidPin(confirmPinController.text);
      pinsMatch.value = pinController.text == confirmPinController.text;
    });
  }

  bool _isValidPin(String pin) {
    if (pin.length < minLength || pin.length > maxLength) return false;
    
    // Aceita letras, números e caracteres especiais comuns
    final validPattern = RegExp(r'^[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};:,.<>?]+$');
    return validPattern.hasMatch(pin);
  }

  void toggleObscurePin() {
    obscurePin.value = !obscurePin.value;
  }

  void toggleObscureConfirmPin() {
    obscureConfirmPin.value = !obscureConfirmPin.value;
  }

  void continueToConfirmation() {
    if (!isPinValid.value) return;
    isCreatingPin.value = false;
  }

  void goBackToCreatePin() {
    isCreatingPin.value = true;
    confirmPinController.clear();
  }

  void confirmPin() async {
    if (!isConfirmPinValid.value || !pinsMatch.value) return;
    
    try {
      // 2. Usa o ID da carteira real para salvar o PIN
      await storage.setWalletPin(targetWallet.id, pinController.text);
      
      print('PIN criado com sucesso para a carteira: ${targetWallet.name}');
      
      // 3. Tudo pronto, vai pra Home
      Get.offAllNamed(Routes.HOME);
      
    } catch (e) {
      Get.snackbar("Erro", "Não foi possível salvar o PIN.");
    }
  }


  @override
  void onClose() {
    pinController.dispose();
    confirmPinController.dispose();
    super.onClose();
  }
}