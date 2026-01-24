import 'package:capy_wallet/app/data/theme/app_colors.dart';
import 'package:capy_wallet/app/data/theme/app_text_styles.dart';
import 'package:capy_wallet/app/modules/5-onchain_only/home_onchain/controllers/home_onchain_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfigTab extends GetView<HomeOnchainController> {
  const ConfigTab({super.key});

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
          'Configurações',
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
            // Card da carteira
            _buildWalletCard(),
            
            const SizedBox(height: 16),
            
            // Lightning Network (se compatível)
            if (controller.wallet.canUpgradeToLightning)
              _buildLightningCard(),
            
            if (controller.wallet.canUpgradeToLightning)
              const SizedBox(height: 16),
            
            // Seção Exibição
            _buildDisplaySection(),
            
            const SizedBox(height: 16),
            
            // Seção Rede
            _buildNetworkSection(),
            
            const SizedBox(height: 16),
            
            // Seção Segurança
            _buildSecuritySection(),
            
            const SizedBox(height: 16),
            
            // Zona de Perigo
            _buildDangerZone(),
            
            const SizedBox(height: 24),
            
            // Footer
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Image.asset(
                'assets/Gemini_Generated_Image_smwc3rsmwc3rsmwc.png',
                width: 45,
                height: 45,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.currency_bitcoin, size: 45);
                },
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Capy Wallet',
                  style: AppTextStyles.headingMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Carteira On-Chain',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.lightForeground.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLightningCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.flash_on,
                color: Colors.deepPurple.shade700,
              ),
              const SizedBox(width: 8),
              Text(
                'Lightning Network',
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Habilite a Lightning Network para pagamentos instantâneos e taxas baixas.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.lightForeground.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: controller.activateLightning,
              icon: const Icon(Icons.flash_on),
              label: const Text('Ativar Lightning Network'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple.shade700,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisplaySection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Exibição',
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          // Tema
          _buildSettingTile(
            icon: Icons.brightness_6_outlined,
            title: 'Tema',
            trailing: Obx(() => Switch(
                  value: controller.isDarkMode.value,
                  onChanged: (value) => controller.toggleTheme(),
                  activeColor: AppColors.lightPrimary,
                )),
          ),
          
          const Divider(height: 24),
          
          // Moeda Fiat
          _buildSettingTile(
            icon: Icons.attach_money,
            title: 'Moeda Fiat',
            trailing: Obx(() => DropdownButton<String>(
                  value: controller.selectedCurrency.value,
                  underline: const SizedBox(),
                  items: const [
                    DropdownMenuItem(value: 'BRL', child: Text('BRL')),
                    DropdownMenuItem(value: 'USD', child: Text('USD')),
                    DropdownMenuItem(value: 'EUR', child: Text('EUR')),
                  ],
                  onChanged: (value) {
                    if (value != null) controller.changeCurrency(value);
                  },
                )),
          ),
          
          const Divider(height: 24),
          
          // Formato de Saldo
          _buildSettingTile(
            icon: Icons.wallet_outlined,
            title: 'Formato de Saldo',
            trailing: Obx(() => DropdownButton<String>(
                  value: controller.balanceFormat.value,
                  underline: const SizedBox(),
                  items: const [
                    DropdownMenuItem(value: 'sats', child: Text('sats')),
                    DropdownMenuItem(value: 'BTC', child: Text('BTC')),
                  ],
                  onChanged: (value) {
                    if (value != null) controller.changeBalanceFormat(value);
                  },
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildNetworkSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rede',
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildSettingTile(
            icon: Icons.link_outlined,
            title: 'Rede Bitcoin',
            subtitle: 'Bitcoin real',
            trailing: Obx(() => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Main',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: controller.isMainnet.value
                            ? AppColors.lightPrimary
                            : Colors.grey,
                      ),
                    ),
                    Switch(
                      value: !controller.isMainnet.value,
                      onChanged: (value) => controller.toggleNetwork(),
                      activeColor: Colors.orange,
                    ),
                    Text(
                      'Test',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: !controller.isMainnet.value
                            ? Colors.orange
                            : Colors.grey,
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildSecuritySection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Segurança',
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildSettingTile(
            icon: Icons.key_outlined,
            title: 'Alterar PIN',
            subtitle: 'Proteja seu acesso',
            trailing: const Icon(Icons.chevron_right),
            onTap: controller.goToChangePin,
          ),
          
          const Divider(height: 24),
          
          _buildSettingTile(
            icon: Icons.shield_outlined,
            title: 'Backup das Seeds',
            subtitle: 'Visualize suas palavras-chave',
            trailing: const Icon(Icons.chevron_right),
            onTap: controller.goToBackupSeeds,
          ),
        ],
      ),
    );
  }

  Widget _buildDangerZone() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Zona de Perigo',
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.red.shade700,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildSettingTile(
            icon: Icons.delete_outline,
            title: 'Apagar Esta Carteira',
            subtitle: 'Esta ação não pode ser desfeita',
            titleColor: Colors.red.shade700,
            trailing: Icon(Icons.chevron_right, color: Colors.red.shade700),
            onTap: controller.deleteWallet,
          ),
          
          const Divider(height: 24),
          
          _buildSettingTile(
            icon: Icons.exit_to_app,
            title: 'Sair',
            subtitle: 'Bloquear a carteira',
            titleColor: Colors.red.shade700,
            trailing: Icon(Icons.chevron_right, color: Colors.red.shade700),
            onTap: controller.logout,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    Color? titleColor,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Icon(icon, color: titleColor ?? AppColors.lightForeground),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                      color: titleColor,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.lightForeground.withOpacity(0.6),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Image.asset(
          'assets/Gemini_Generated_Image_smwc3rsmwc3rsmwc.png',
          height: 40,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.currency_bitcoin, size: 40);
          },
        ),
        const SizedBox(height: 8),
        Text(
          'Capy Wallet v1.0.0',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.lightForeground.withOpacity(0.7),
          ),
        ),
        Text(
          '100% Não-custodial • Feito com 💚',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.lightForeground.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}
