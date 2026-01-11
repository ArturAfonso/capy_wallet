import 'package:capy_wallet/app/data/shared/custom_button.dart';
import 'package:capy_wallet/app/data/theme/app_colors.dart';
import 'package:capy_wallet/app/data/theme/app_text_styles.dart';
import 'package:capy_wallet/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendTab extends GetView<HomeController> {
  const SendTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => controller.changeTab(0),
        ),
        title: Text(
          'Enviar Bitcoin',
          style: AppTextStyles.headingMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // De qual carteira?
            Text(
              'De qual carteira?',
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Obx(() => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.lightInput,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: controller.selectedWalletToSend.value,
                    underline: const SizedBox(),
                    items: [
                      const DropdownMenuItem(
                        value: 'Selecione uma carteira',
                        child: Text('Selecione uma carteira'),
                      ),
                      ...controller.wallets.map((wallet) {
                        return DropdownMenuItem(
                          value: wallet.name,
                          child: Text(wallet.name),
                        );
                      }),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        controller.selectedWalletToSend.value = value;
                      }
                    },
                  ),
                )),
            const SizedBox(height: 24),
            // Para qual endereço?
            Text(
              'Para qual endereço?',
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'bc1... ou lnbc...',
                filled: true,
                fillColor: AppColors.lightInput,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.qr_code_scanner),
                  onPressed: () {
                    // Scan QR Code
                  },
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
              ),
              onChanged: (value) => controller.sendAddress.value = value,
            ),
            const SizedBox(height: 24),
            // Quanto?
            Text(
              'Quanto?',
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '0',
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
                    onChanged: (value) => controller.sendAmount.value = value,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Obx(() => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: AppColors.lightInput,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: controller.sendUnit.value,
                          underline: const SizedBox(),
                          items: const [
                            DropdownMenuItem(value: 'sats', child: Text('sats')),
                            DropdownMenuItem(value: 'BTC', child: Text('BTC')),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              controller.sendUnit.value = value;
                            }
                          },
                        ),
                      )),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Botão Continuar
            CustomButton(
              text: 'Continuar',
              textStyle: AppTextStyles.buttonLabel,
              onPressed: () {
                // Processar envio
              },
            ),
          ],
        ),
      ),
    );
  }
}
