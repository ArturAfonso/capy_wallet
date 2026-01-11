import 'package:capy_wallet/app/data/shared/custom_button.dart';
import 'package:capy_wallet/app/data/theme/app_colors.dart';
import 'package:capy_wallet/app/data/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/recover_wallet_controller.dart';

class RecoverWalletView extends GetView<RecoverWalletController> {
  const RecoverWalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recuperar Carteira',
          style: AppTextStyles.headingMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Imagem
              Center(
                child: Image.asset(
                  'assets/recuperacao_seed.png',
                  height: 250,
                ),
              ),
              const SizedBox(height: 16),
              // Texto explicativo
              Text(
                'Digite suas 12 palavras-chave para recuperar sua carteira',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.lightForeground.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // Nome da Carteira
              Text(
                'Nome da Carteira',
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.lightForeground,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: controller.walletNameController,
                decoration: InputDecoration(
                  hintText: 'Carteira Recuperada',
                  filled: true,
                  fillColor: AppColors.lightInput,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Palavras-Chave
            Row(
  children: [
    Text(
      'Palavras-Chave',
      style: AppTextStyles.bodyLarge.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.lightForeground,
      ),
    ),
    const SizedBox(width: 8),
    IconButton(
      icon: const Icon(Icons.paste),
      tooltip: 'Colar palavras',
      onPressed: controller.pasteFromClipboard,
    ),
  ],
),
              const SizedBox(height: 12),
              // Grid de campos de seed
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 12,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 2.2,
                ),
                itemBuilder: (context, index) {
                  return TextField(
                    controller: controller.seedControllers[index],
                    decoration: InputDecoration(
                      hintText: '${index + 1}. palavra',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: AppColors.lightForeground.withOpacity(0.4),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: AppColors.lightBorder,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: AppColors.lightBorder,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: AppColors.lightPrimary,
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 8,
                      ),
                    ),
                    style: const TextStyle(fontSize: 13),
                  );
                },
              ),
              const SizedBox(height: 16),
              // Dica
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.amber.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: Colors.amber.shade700,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Dica: Cole todas as palavras de uma vez',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.amber.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Aviso
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.lightForeground.withOpacity(0.7),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Preencha todas as 12 palavras para continuar',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.lightForeground.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Botão Recuperar
              Obx(
                () => CustomButton(
                  text: 'Recuperar Carteira',
                  textStyle: AppTextStyles.buttonLabel,
                  onPressed: controller.canRecover.value
                      ? controller.recoverWallet
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/**
 abandon ability       ableaboutaboveabsent absorb abstract absurd abuse access accident
 */