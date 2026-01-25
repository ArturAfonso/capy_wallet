import 'package:capy_wallet/app/data/theme/app_colors.dart';
import 'package:capy_wallet/app/data/theme/app_text_styles.dart';
import 'package:capy_wallet/app/modules/5-onchain_only/home_onchain/controllers/home_onchain_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

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
        centerTitle: false,
        title: Text(
          'Receber Bitcoin',
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.bold,
            //color: AppColors.lightForeground,
          ),
        ),
        actions: [
          // Botão para selecionar endereço
          PopupMenuButton<int>(
            icon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.lightBorder),
              ),
              child: Obx(() => Row(
                children: [
                  Text(
                        'Endereço #${controller.selectedAddressIndex.value + 1} ',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down_outlined)
                ],
              )),
            ),
            tooltip: 'Selecionar endereço',
            onSelected: controller.selectAddress,
            itemBuilder: (context) {
              return controller.addresses.asMap().entries.map((entry) {
                final index = entry.key;
                final address = entry.value;
                return PopupMenuItem<int>(
                  value: index,
                  child: SizedBox(
                    width: Get.size.width / 2,
                    child: Obx(() => Row(
                          children: [
                            if (controller.selectedAddressIndex.value == index) const Icon(Icons.check, size: 16),
                            if (controller.selectedAddressIndex.value == index) const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '#${index + 1}: ${address.substring(0, 15)}...',
                                style: AppTextStyles.bodySmall,
                              ),
                            ),
                          ],
                        )),
                  ),
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
        border: Border.all(
          color: AppColors.lightBorder,
        ),
      ),
      child: Column(
        children: [
          Obx(() {
            final qrCode = QrCode.fromData(
              data: controller.currentAddress,
              errorCorrectLevel: QrErrorCorrectLevel.H,
            );
            
            final qrImage = QrImage(qrCode);
            
            return PrettyQrView(
              qrImage: qrImage,
              decoration:  PrettyQrDecoration(
                
                shape: PrettyQrSmoothSymbol(
                  color: AppColors.lightSecondary ,
                ),
                image:  PrettyQrDecorationImage(
                  fit: BoxFit.scaleDown,
                  image: const AssetImage('assets/capyqrcode2.png', 
                 
                  ),
                  position: PrettyQrDecorationImagePosition.embedded,
                  colorFilter: ColorFilter.mode(
                   AppColors.lightSecondary ,
                    BlendMode.srcIn,
                  ),
                  scale: 0.45, // Aumenta o tamanho da imagem (padrão é 0.25)
                ),
                background: AppColors.lightCard,
              ),
            );
          }),

          const SizedBox(height: 16),

          // Endereço
          _buildAddressDisplay(),
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
              color: AppColors.lightCard,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColors.lightBorder,
              ),
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
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Obx(() => GestureDetector(
                  onTap: controller.toggleReceiveUnit,
                  child: Row(
                    children: [
                       Transform.rotate(
                        angle: 88 * 3.1415927 / 180,
                         child: Icon( 
                         FontAwesomeIcons.arrowRightArrowLeft,
                                               color: AppColors.lightForeground.withOpacity(0.7),
                                               size: 14,
                                               ),
                       ),
                      const SizedBox(width: 4), 
                      Text(
                        'Mudar para ${controller.receiveUnit.value == "BTC" ? "R\$" : "BTC"}',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.lightForeground.withOpacity(0.7),
                          //fontWeight: FontWeight.w600,
                        ),
                        
                      ),
                     
                    ],
                  ),
                )),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
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
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: AppColors.lightBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: AppColors.lightBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: AppColors.lightPrimary, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
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
          style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
        ),
        const SizedBox(height: 8),
        TextField(
          onChanged: (value) => controller.receiveDescription.value = value,
          decoration: InputDecoration(
            hintText: 'Ex: Pagamento freelance',
            hintStyle: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.lightForeground.withOpacity(0.3),
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: AppColors.lightBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: AppColors.lightBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: AppColors.lightPrimary, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
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
            icon:  Icon(Icons.copy, color: AppColors.lightForeground,),
            label: const Text('Copiar'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.lightForeground,
              side: BorderSide(color: AppColors.lightBorder),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: controller.shareQRCode,
            icon: const Icon(Icons.share, color: Colors.white,),
            label:   Text('Compartilhar', style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 16
                        ),),
          
            style: ElevatedButton.styleFrom(
              
              backgroundColor: AppColors.lightPrimary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 0,
            ),
          ),
        ),
      ],
    );
  }
}
