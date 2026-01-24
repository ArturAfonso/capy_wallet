import 'package:capy_wallet/app/data/theme/app_colors.dart';
import 'package:capy_wallet/app/data/theme/app_text_styles.dart';
import 'package:capy_wallet/app/modules/5-onchain_only/home_onchain/controllers/home_onchain_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarteirasTab extends GetView<HomeOnchainController> {
  const CarteirasTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Minhas Carteiras',
          style: AppTextStyles.headingMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => controller.changeTab(0),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction_outlined,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 24),
            Text(
              'Será implementado no futuro',
              style: AppTextStyles.headingMedium.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Aqui você poderá gerenciar\nsuas carteiras OnChain',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
