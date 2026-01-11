import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capy_wallet/app/routes/app_pages.dart';

class PinController extends GetxController {
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

  @override
  void onInit() {
    super.onInit();
    
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

  void confirmPin() {
    if (!isConfirmPinValid.value || !pinsMatch.value) return;
    
    // Aqui você salvaria o PIN de forma segura (ex: usando flutter_secure_storage)
    print('PIN criado com sucesso: ${pinController.text}');
    
    // Navegar para a home
    Get.offAllNamed(Routes.HOME);
  }

  @override
  void onClose() {
    pinController.dispose();
    confirmPinController.dispose();
    super.onClose();
  }
}