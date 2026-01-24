import 'package:capy_wallet/app/data/models/wallet_info.dart';
import 'package:capy_wallet/app/data/shared/custom_button.dart';
import 'package:capy_wallet/app/data/theme/app_colors.dart';
import 'package:capy_wallet/app/data/theme/app_text_styles.dart';
import 'package:capy_wallet/app/modules/5-onchain_only/home_onchain/controllers/home_onchain_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InicioTab extends GetView<HomeOnchainController> {
  const InicioTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SafeArea(
        child: Column(
          children: [
            // Header com informações da carteira
            _buildHeader(),
            
            // Card de Saldo
            _buildBalanceCard(context),
            
            // Botões Enviar/Receber
            _buildActionButtons(context),
            
            // Toggle Histórico/Detalhes
            _buildSubTabToggle(),
            
            // Conteúdo (Histórico ou Detalhes)
            Expanded(
              child: Obx(() => controller.inicioSubTab.value == 0
                  ? _buildHistoricoList()
                  : _buildDetalhesList()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Avatar/Logo
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Image.asset(
                'assets/Gemini_Generated_Image_smwc3rsmwc3rsmwc.png',
                width: 35,
                height: 35,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.currency_bitcoin, size: 35);
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          
          // Nome e Rede
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.wallet.name,
                  style: AppTextStyles.headingMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  controller.wallet.network == 'mainnet' ? 'Mainnet' : 'Testnet',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.lightForeground.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 4,
      borderRadius: BorderRadius.circular(24),
      shadowColor: Colors.brown.withOpacity(0.10),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF8E1),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Saldo Total',
                  style: AppTextStyles.bodyMedium
                ),
                const Spacer(),
                Obx(() => IconButton(
                      icon: Icon(
                        controller.balanceVisible.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.brown.shade700,
                      ),
                      onPressed: controller.toggleBalanceVisibility,
                    )),
              ],
            ),
            const SizedBox(height: 8),
            Obx(() => Text(
                  controller.balanceVisible.value
                      ? '${(controller.balance.value / 100).toStringAsFixed(3).replaceAll('.', '.')} sats'
                      : '• • • • • • •',
                  style: AppTextStyles.displayLarge
                )),
            const SizedBox(height: 4),
            Obx(() => Text(
                  controller.balanceVisible.value
                      ? '+ ${(controller.pendingBalance.value / 100).toStringAsFixed(3)} sats pendente'
                      : '• • • • • • • ',
                  style: AppTextStyles.bodyMedium.copyWith(
                  
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
           Expanded(
            child: CustomButton(
              icon: Transform.rotate(
                    angle: -45 * 3.1415927 / 180,
                    child: const Icon(Icons.send,size: 20, color: Colors.white),
                  ),
              textStyle: AppTextStyles.buttonLabel.copyWith(fontSize: 18),
              text: 'Enviar',
            onPressed: () => controller.changeTab(2),
            ) /* ElevatedButton.icon(
              onPressed: () => controller.changeTab(2),
              icon: const Icon(Icons.send,   color: Colors.white,),
              label: const Text('Enviar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ), */
          ),
          const SizedBox(width: 12),
          Expanded(
            child: CustomButton(
              borderColor: AppColors.lightSecondary,
              backgroundColor: AppColors.lightSecondary ,
               textStyle: AppTextStyles.buttonLabel.copyWith(fontSize: 18),
              onPressed: () => controller.changeTab(3) ,
              icon: const Icon(Icons.qr_code, size: 20, color: Colors.white),
              text: 'Receber'),
          ),
        ],
      ),
    );
  }

  Widget _buildSubTabToggle() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE8E4D9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Obx(() => Row(
            children: [
              Expanded(
                child: _buildToggleButton(
                  'Histórico',
                  0,
                  controller.inicioSubTab.value == 0,
                ),
              ),
              Expanded(
                child: _buildToggleButton(
                  'Detalhes',
                  1,
                  controller.inicioSubTab.value == 1,
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildToggleButton(String label, int index, bool isSelected) {
    return GestureDetector(
      onTap: () => controller.changeInicioSubTab(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected
                ? AppColors.lightForeground
                : AppColors.lightForeground.withOpacity(0.6),
          ),
        ),
      ),
    );
  }

  Widget _buildHistoricoList() {
    return Obx(() {
      if (controller.transactions.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.inbox_outlined,
                size: 64,
                color: Colors.grey.shade400,
              ),
              const SizedBox(height: 16),
              Text(
                'Nenhuma transação ainda',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.transactions.length,
        itemBuilder: (context, index) {
          final tx = controller.transactions[index];
          return _buildTransactionItem(tx);
        },
      );
    });
  }

  Widget _buildTransactionItem(Map<String, dynamic> tx) {
    final isReceived = tx['type'] == 'received';
    
    return GestureDetector(
      onTap: () {
        // Navega para a tela de detalhes da transação
        Get.toNamed('/transaction-detail', arguments: tx);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
           boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.07),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
        ),
        child: Row(
          children: [
            // Ícone
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isReceived
                    ? AppColors.lightSecondary.withOpacity(0.1)
                    : AppColors.lightPrimary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                isReceived ? Icons.arrow_downward : Icons.arrow_upward,
                color: isReceived ? AppColors.lightSecondary : AppColors.lightPrimary,
              ),
            ),
            const SizedBox(width: 12),
            
            // Info
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isReceived ? 'Recebido' : 'Enviado',
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    tx['date'],
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.lightForeground.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            
            // Valor e confirmações
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${isReceived ? '+' : '-'}${(tx['amount'] / 100).toStringAsFixed(3).replaceAll('.', '.')} sats',
                    maxLines: 1,
                    style: AppTextStyles.bodyLarge.copyWith(
                      
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isReceived ? AppColors.lightSecondary : AppColors.lightForeground,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${tx['confirmations']} conf',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.lightForeground.withOpacity(0.6),
                      fontSize: 14
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right,
              color: AppColors.lightForeground.withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetalhesList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Nome', controller.wallet.name),
            const Divider(height: 24),
            _buildDetailRow('Tipo', controller.wallet.mode == WalletMode.onChainOnly ? 'On-Chain' : 'Lightning'),
            const Divider(height: 24),
            _buildDetailRow('Derivation Path', controller.wallet.derivationPath ?? 'm/84\'/0\'/0\''),
            const Divider(height: 24),
            _buildDetailRow('Rede', controller.wallet.network == 'mainnet' ? 'Mainnet' : 'Testnet'),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.lightForeground.withOpacity(0.6),
          ),
        ),
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
