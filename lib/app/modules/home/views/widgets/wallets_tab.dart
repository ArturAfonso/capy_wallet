import 'package:capy_wallet/app/data/theme/app_colors.dart';
import 'package:capy_wallet/app/data/theme/app_text_styles.dart';
import 'package:capy_wallet/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletsTab extends GetView<HomeController> {
  const WalletsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Minhas Carteiras',
          style: AppTextStyles.headingMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              // Adicionar nova carteira
            },
            icon: const Icon(Icons.add),
            label: const Text('Nova'),
            style: TextButton.styleFrom(
              backgroundColor: AppColors.lightPrimary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.wallets.length + 1,
          itemBuilder: (context, index) {
            if (index == controller.wallets.length) {
              // Botão adicionar carteira
              return InkWell(
                onTap: () {
                  // Adicionar carteira
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add_circle_outline, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Adicionar Carteira',
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            final wallet = controller.wallets[index];
            return _WalletCard(wallet: wallet);
          },
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
      margin: const EdgeInsets.only(bottom: 12),
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
            height: 60,
            decoration: BoxDecoration(
              color: wallet.type == WalletType.onChain
                  ? AppColors.lightPrimary
                  : AppColors.lightAccent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          // Ícone
          Icon(
            wallet.type == WalletType.onChain ? Icons.link : Icons.flash_on,
            color: wallet.type == WalletType.onChain
                ? AppColors.lightPrimary
                : AppColors.lightAccent,
            size: 28,
          ),
          const SizedBox(width: 12),
          // Informações
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  wallet.name,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '₿ ${wallet.balance.toStringAsFixed(8)}',
                  style: AppTextStyles.headingMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  wallet.address,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.lightForeground.withOpacity(0.6),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Badge de rede
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.lightSecondary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              wallet.network,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
