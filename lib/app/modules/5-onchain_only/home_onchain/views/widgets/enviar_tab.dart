import 'package:capy_wallet/app/data/theme/app_colors.dart';
import 'package:capy_wallet/app/data/theme/app_text_styles.dart';
import 'package:capy_wallet/app/modules/5-onchain_only/home_onchain/controllers/home_onchain_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnviarTab extends GetView<HomeOnchainController> {
  const EnviarTab({super.key});

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
          'Enviar Bitcoin',
          style: AppTextStyles.headingMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Saldo disponível
            _buildBalanceHeader(),
            
            const SizedBox(height: 24),
            
            // Campo de endereço
            _buildAddressField(),
            
            const SizedBox(height: 16),
            
            // Campo de descrição
            _buildDescriptionField(),
            
            const SizedBox(height: 16),
            
            // Campo de valor
            _buildValueField(),
            
            const SizedBox(height: 8),
            
            // Valor convertido
            _buildConvertedValue(),
            
            const SizedBox(height: 24),
            
            // Botão Enviar
            _buildSendButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Saldo disponível',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.lightForeground.withOpacity(0.6),
            ),
          ),
          Obx(() => Text(
                '${(controller.balance.value / 100).toStringAsFixed(3).replaceAll('.', '.')} sats',
                style: AppTextStyles.headingMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildAddressField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Endereço de destino',
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
            onChanged: (value) => controller.sendAddress.value = value,
            decoration: InputDecoration(
              hintText: 'bc1...',
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
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Botão colar
                  IconButton(
                    icon: const Icon(Icons.content_paste),
                    onPressed: controller.pasteAddress,
                    tooltip: 'Colar',
                  ),
                  // Botão QR Scanner
                  IconButton(
                    icon: const Icon(Icons.qr_code_scanner),
                    onPressed: controller.scanQRCode,
                    tooltip: 'Escanear QR Code',
                  ),
                ],
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
            onChanged: (value) => controller.sendDescription.value = value,
            decoration: InputDecoration(
              hintText: 'Ex: Pagamento café',
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

  Widget _buildValueField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() => Text(
                  'Valor (${controller.sendUnit.value})',
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Obx(() => GestureDetector(
                  onTap: controller.toggleSendUnit,
                  child: Text(
                    '⇄ Mudar para ${controller.sendUnit.value == "BTC" ? "R\$" : "BTC"}',
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
            onChanged: (value) => controller.sendAmount.value = value,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              hintText: '0.00000000',
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
              suffixText: 'Máximo',
              suffixStyle: AppTextStyles.bodySmall.copyWith(
                color: AppColors.lightPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConvertedValue() {
    return Obx(() {
      final converted = controller.getConvertedSendAmount();
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          converted,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.lightForeground.withOpacity(0.6),
          ),
        ),
      );
    });
  }

  Widget _buildSendButton() {
    return Obx(() {
      final canSend = controller.sendAddress.value.isNotEmpty &&
          controller.sendAmount.value.isNotEmpty;

      return SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton.icon(
          onPressed: canSend ? controller.sendBitcoin : null,
          icon: const Icon(Icons.send),
          label: const Text('Enviar Bitcoins'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.lightPrimary,
            disabledBackgroundColor: AppColors.lightPrimary.withOpacity(0.3),
            foregroundColor: Colors.white,
            disabledForegroundColor: Colors.white.withOpacity(0.6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
        ),
      );
    });
  }
}
