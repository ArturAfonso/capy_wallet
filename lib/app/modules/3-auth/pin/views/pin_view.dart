import 'package:capy_wallet/app/data/shared/custom_button.dart';
import 'package:capy_wallet/app/data/theme/app_colors.dart';
import 'package:capy_wallet/app/data/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/pin_controller.dart';

class PinView extends GetView<PinController> {
  const PinView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Obx(() {
              return controller.isCreatingPin.value
                  ? _buildCreatePinView(context)
                  : _buildConfirmPinView(context);
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildCreatePinView(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Imagem
        Image.asset(
          'assets/Gemini_Generated_Image_smwc3rsmwc3rsmwc.png',
          height: 140,
        ),
        const SizedBox(height: 24),
        // Título
        Text(
          'Crie seu PIN',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Este PIN protegerá seu acesso à carteira',
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.lightForeground.withOpacity(0.7),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        // Campo de PIN
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.lightBorder),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Digite seu PIN',
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Obx(() => TextField(
                    controller: controller.pinController,
                    obscureText: controller.obscurePin.value,
                    decoration: InputDecoration(
                      hintText: 'Mínimo 6 caracteres',
                      filled: true,
                      fillColor: AppColors.lightInput,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obscurePin.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: AppColors.lightForeground.withOpacity(0.5),
                        ),
                        onPressed: controller.toggleObscurePin,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                    ),
                  )),
              const SizedBox(height: 12),
              // Informações de segurança
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.blue.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.blue.shade700,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Use letras, números e caracteres especiais para maior segurança',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Colors.blue.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        // Botão continuar
        Obx(
          () => CustomButton(
            text: 'Continuar',
            textStyle: AppTextStyles.buttonLabel,
            onPressed: controller.isPinValid.value
                ? controller.continueToConfirmation
                : null,
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmPinView(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Imagem
        Image.asset(
          'assets/Gemini_Generated_Image_smwc3rsmwc3rsmwc.png',
          height: 140,
        ),
        const SizedBox(height: 24),
        // Título
        Text(
          'Confirme seu PIN',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Digite novamente para confirmar',
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.lightForeground.withOpacity(0.7),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        // Campo de confirmação de PIN
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.lightBorder),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Confirme seu PIN',
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Obx(() => TextField(
                    controller: controller.confirmPinController,
                    obscureText: controller.obscureConfirmPin.value,
                    decoration: InputDecoration(
                      hintText: 'Digite o mesmo PIN',
                      filled: true,
                      fillColor: AppColors.lightInput,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obscureConfirmPin.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: AppColors.lightForeground.withOpacity(0.5),
                        ),
                        onPressed: controller.toggleObscureConfirmPin,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                    ),
                  )),
              const SizedBox(height: 12),
              // Aviso de erro se não conferir
Obx(() {
  // Capturamos o valor ANTES do if para garantir que o Obx registre a variável
  final pinsMatch = controller.pinsMatch.value;
  final textIsNotEmpty = controller.confirmPinController.text.isNotEmpty;

  if (textIsNotEmpty && !pinsMatch) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.red.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'PINs não conferem',
              style: AppTextStyles.bodySmall.copyWith(
                color: Colors.red.shade900,
              ),
            ),
          ),
        ],
      ),
    );
  }
  return const SizedBox.shrink();
}),
            ],
          ),
        ),
        const SizedBox(height: 24),
        // Botão confirmar
        Obx(
          () => CustomButton(
            text: 'Confirmar',
            textStyle: AppTextStyles.buttonLabel,
            onPressed: (controller.isConfirmPinValid.value &&
                    controller.pinsMatch.value)
                ? controller.confirmPin
                : null,
          ),
        ),
        const SizedBox(height: 12),
        // Link para voltar
        TextButton(
          onPressed: controller.goBackToCreatePin,
          child: Text(
            '← Voltar e alterar PIN',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.lightPrimary,
            ),
          ),
        ),
      ],
    );
  }
}