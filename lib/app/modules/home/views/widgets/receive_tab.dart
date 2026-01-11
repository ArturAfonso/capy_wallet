import 'package:capy_wallet/app/data/theme/app_colors.dart';
import 'package:capy_wallet/app/data/theme/app_text_styles.dart';
import 'package:capy_wallet/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReceiveTab extends GetView<HomeController> {
  const ReceiveTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => controller.changeTab(0),
        ),
        title: Text(
          'Receber Bitcoin',
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
            // Imagem
            Center(
              child: Image.asset(
                'assets/Tela de Receber (A Capy Presente) 2.png',
                height: 120,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/Gemini_Generated_Image_smwc3rsmwc3rsmwc.png',
                    height: 120,
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            // Receber em qual carteira?
            Text(
              'Receber em qual carteira?',
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Obx(() => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.lightPrimary,
                      width: 2,
                    ),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: controller.selectedWalletToReceive.value,
                    underline: const SizedBox(),
                    icon: Icon(
                      Icons.link,
                      color: AppColors.lightPrimary,
                    ),
                    items: controller.wallets.map((wallet) {
                      return DropdownMenuItem(
                        value: wallet.name,
                        child: Row(
                          children: [
                            Icon(
                              wallet.type == WalletType.onChain
                                  ? Icons.link
                                  : Icons.flash_on,
                              color: wallet.type == WalletType.onChain
                                  ? AppColors.lightPrimary
                                  : AppColors.lightAccent,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(wallet.name),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        controller.selectedWalletToReceive.value = value;
                      }
                    },
                  ),
                )),
            const SizedBox(height: 24),
            // Toggle Endereço / Valor
            Container(
              decoration: BoxDecoration(
                color: AppColors.lightInput,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Obx(() => Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.receiveTab.value = 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: controller.receiveTab.value == 0
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text(
                                'Endereço',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontWeight: controller.receiveTab.value == 0
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.receiveTab.value = 1,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: controller.receiveTab.value == 1
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text(
                                'Valor',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontWeight: controller.receiveTab.value == 1
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            const SizedBox(height: 24),
            // QR Code
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.lightPrimary.withOpacity(0.2),
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    QrImageView(
                      data: 'bc1qxy2kgdyjrsqtzq2n0yrf2493p83kkf3hxw8lh',
                      version: QrVersions.auto,
                      size: 200,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'QR Code',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'bc1qxy2kgdyjrsqtzq2...',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.lightForeground.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Endereço copiável
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.lightInput,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'bc1qxy2kgdyjrsqtzq2n0yrf2493p83kkf3hxw8lh',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontFamily: 'monospace',
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () {
                      Clipboard.setData(
                        const ClipboardData(
                            text: 'bc1qxy2kgdyjrsqtzq2n0yrf2493p83kkf3hxw8lh'),
                      );
                      Get.snackbar(
                        'Copiado!',
                        'Endereço copiado para a área de transferência',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Botões Copiar e Compartilhar
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Clipboard.setData(
                        const ClipboardData(
                            text: 'bc1qxy2kgdyjrsqtzq2n0yrf2493p83kkf3hxw8lh'),
                      );
                      Get.snackbar(
                        'Copiado!',
                        'Endereço copiado para a área de transferência',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                    icon: const Icon(Icons.copy),
                    label: const Text('Copiar'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.lightForeground,
                      side: BorderSide(color: AppColors.lightBorder),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Compartilhar
                    },
                    icon: const Icon(Icons.share),
                    label: const Text('Compartilhar'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.lightForeground,
                      side: BorderSide(color: AppColors.lightBorder),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
