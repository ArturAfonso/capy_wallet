import 'package:capy_wallet/app/data/theme/app_colors.dart';
import 'package:capy_wallet/app/data/theme/app_text_styles.dart';
import 'package:capy_wallet/app/modules/5-onchain_only/home_onchain/controllers/home_onchain_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReceberTab extends GetView<HomeOnchainController> {
  const ReceberTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
        actions: [
          // Botão para selecionar endereço
          PopupMenuButton<int>(
            icon: const Icon(Icons.list),
            tooltip: 'Selecionar endereço',
            onSelected: controller.selectAddress,
            itemBuilder: (context) {
              return controller.addresses.asMap().entries.map((entry) {
                final index = entry.key;
                final address = entry.value;
                return PopupMenuItem<int>(
                  value: index,
                  child: Obx(() => Row(
                        children: [
                          if (controller.selectedAddressIndex.value == index)
                            const Icon(Icons.check, size: 16),
                          if (controller.selectedAddressIndex.value == index)
                            const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '#${index + 1}: ${address.substring(0, 15)}...',
                              style: AppTextStyles.bodySmall,
                            ),
                          ),
                        ],
                      )),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // QR Code
            _buildQRCode(),
            
            const SizedBox(height: 16),
            
            // Endereço
            _buildAddressDisplay(),
            
            const SizedBox(height: 24),
            
            // Campo de quantia
            _buildAmountField(),
            
            const SizedBox(height: 16),
            
            // Campo de descrição
            _buildDescriptionField(),
            
            const SizedBox(height: 24),
            
            // Botões de ação
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildQRCode() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Obx(() => QrImageView(
                data: controller.currentAddress,
                version: QrVersions.auto,
                size: 250,
                backgroundColor: Colors.white,
                errorCorrectionLevel: QrErrorCorrectLevel.M,
              )),
        ],
      ),
    );
  }

  Widget _buildAddressDisplay() {
    return Obx(() => GestureDetector(
          onTap: controller.copyAddress,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    controller.currentAddress,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.brown.shade700,
                      fontFamily: 'monospace',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.copy,
                  size: 18,
                  color: Colors.brown.shade700,
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildAmountField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() => Text(
                  'Quantia a receber (${controller.receiveUnit.value})',
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Obx(() => GestureDetector(
                  onTap: controller.toggleReceiveUnit,
                  child: Text(
                    '⇄ Mudar para ${controller.receiveUnit.value == "BTC" ? "R\$" : "BTC"}',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.lightPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            onChanged: (value) => controller.receiveAmount.value = value,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              hintText: '0.00',
              hintStyle: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.lightForeground.withOpacity(0.3),
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Descrição (opcional)',
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            onChanged: (value) => controller.receiveDescription.value = value,
            decoration: InputDecoration(
              hintText: 'Ex: Pagamento freelance',
              hintStyle: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.lightForeground.withOpacity(0.3),
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: controller.copyAddress,
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
          child: ElevatedButton.icon(
            onPressed: controller.shareQRCode,
            icon: const Icon(Icons.share),
            label: const Text('Compartilhar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.lightPrimary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
          ),
        ),
      ],
    );
  }
}
