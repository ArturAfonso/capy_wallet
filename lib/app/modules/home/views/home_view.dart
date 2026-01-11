import 'package:capy_wallet/app/data/theme/app_colors.dart';
import 'package:capy_wallet/app/data/theme/app_text_styles.dart';
import 'package:capy_wallet/app/modules/home/views/widgets/config_tab.dart';
import 'package:capy_wallet/app/modules/home/views/widgets/receive_tab.dart';
import 'package:capy_wallet/app/modules/home/views/widgets/send_tab.dart';
import 'package:capy_wallet/app/modules/home/views/widgets/wallets_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Mostrar a tela apropriada baseada no índice selecionado
      if (controller.currentIndex.value == 1) return const WalletsTab();
      if (controller.currentIndex.value == 2) return const SendTab();
      if (controller.currentIndex.value == 3) return const ReceiveTab();
      if (controller.currentIndex.value == 4) return const ConfigTab();

      // Tela Início (índice 0)
      return _HomeTab();
    });
  }
}

class _HomeTab extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Header com nome da carteira
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.lightPrimary.withOpacity(0.15),
                    child: Image.asset('assets/Gemini_Generated_Image_smwc3rsmwc3rsmwc.png', height: 32),
                  ),
                  const SizedBox(width: 12),
                  // Nome e rede
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(
                            controller.walletName.value,
                            style: AppTextStyles.headingMedium.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Obx(
                          () => Text(
                            controller.network.value,
                            style: AppTextStyles.bodySmall.copyWith(color: AppColors.lightForeground.withOpacity(0.6)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Botão adicionar
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () {
                      // Adicionar nova carteira
                    },
                  ),
                ],
              ),
            ),

            // Card de saldo
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.lightCard,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Saldo Total',
                            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.lightForeground.withOpacity(0.7)),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(
                                () => IconButton(
                                  icon: Icon(
                                    controller.balanceVisible.value
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: AppColors.lightForeground.withOpacity(0.5),
                                  ),
                                  onPressed: controller.toggleBalanceVisibility,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                children: [
                                  Text(
                                    '₿',
                                    style: TextStyle(fontSize: 32, color: AppColors.lightForeground.withOpacity(0.8)),
                                  ),
                                  Obx(
                                    () => Text(
                                      controller.balanceVisible.value
                                          ? controller.totalBalance.value.toStringAsFixed(8)
                                          : '••••••••',
                                      style: AppTextStyles.displayLarge.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 36,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: Icon(Icons.refresh, color: AppColors.lightForeground.withOpacity(0.5)),
                                onPressed: () {
                                  // Atualizar saldo
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Botões BTC, SATS, FIAT
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _CurrencyChip(label: 'BTC', isSelected: true),
                              const SizedBox(width: 8),
                              _CurrencyChip(label: 'SATS', isSelected: false),
                              const SizedBox(width: 8),
                              _CurrencyChip(label: 'FIAT', isSelected: false),
                            ],
                          ),
                          const SizedBox(height: 24),
                          // Botões Enviar e Receber
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: controller.goToSend,
                                  icon: const Icon(Icons.arrow_upward_rounded),
                                  label: const Text('Enviar'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.lightPrimary,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: controller.goToReceive,
                                  icon: const Icon(Icons.arrow_downward_rounded),
                                  label: const Text('Receber'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.lightSecondary,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Minhas Carteiras
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Text(
                            'Minhas Carteiras',
                            style: AppTextStyles.headingMedium.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: controller.goToWallets,
                            child: Row(
                              children: [
                                Text(
                                  'Ver todas',
                                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.lightPrimary),
                                ),
                                const SizedBox(width: 4),
                                Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.lightPrimary),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Lista de carteiras
                    Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.wallets.length,
                        itemBuilder: (context, index) {
                          final wallet = controller.wallets[index];
                          return _WalletCard(wallet: wallet);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Navigation
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -2)),
                ],
              ),
              child: Obx(() => BottomNavigationBar(
                    currentIndex: controller.currentIndex.value,
                    onTap: controller.changeTab,
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: AppColors.lightPrimary,
                    unselectedItemColor: AppColors.lightForeground.withOpacity(0.5),
                    selectedFontSize: 12,
                    unselectedFontSize: 12,
                    elevation: 0,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home_outlined),
                        activeIcon: Icon(Icons.home),
                        label: 'Início',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.wallet_outlined),
                        activeIcon: Icon(Icons.wallet),
                        label: 'Carteiras',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.send_outlined),
                        activeIcon: Icon(Icons.send),
                        label: 'Enviar',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.qr_code_scanner_outlined),
                        activeIcon: Icon(Icons.qr_code_scanner),
                        label: 'Receber',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.settings_outlined),
                        activeIcon: Icon(Icons.settings),
                        label: 'Config',
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class _CurrencyChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _CurrencyChip({required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.lightPrimary : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: AppTextStyles.bodySmall.copyWith(
          color: isSelected ? Colors.white : AppColors.lightForeground,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _WalletCard extends StatelessWidget {
  final WalletItem wallet;

  const _WalletCard({required this.wallet});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: wallet.type == WalletType.onChain
              ? AppColors.lightPrimary.withOpacity(0.3)
              : AppColors.lightAccent.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          // Indicador de tipo
          Container(
            width: 4,
            height: 50,
            decoration: BoxDecoration(
              color: wallet.type == WalletType.onChain ? AppColors.lightPrimary : AppColors.lightAccent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          // Ícone
          Icon(
            wallet.type == WalletType.onChain ? Icons.link : Icons.flash_on,
            color: wallet.type == WalletType.onChain ? AppColors.lightPrimary : AppColors.lightAccent,
          ),
          const SizedBox(width: 12),
          // Informações
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(wallet.name, style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                  '₿ ${wallet.balance.toStringAsFixed(8)}',
                  style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  wallet.address,
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.lightForeground.withOpacity(0.6)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Badge de rede
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: AppColors.lightSecondary, borderRadius: BorderRadius.circular(8)),
            child: Text(
              wallet.network,
              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
