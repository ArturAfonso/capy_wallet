import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:capy_wallet/app/data/theme/app_colors.dart';
import 'package:capy_wallet/app/data/theme/app_text_styles.dart';
import '../controllers/onboarding_screen_controller.dart';

PageViewModel buildWalletSummaryPage(
  BuildContext context,
  OnboardingScreenController controller,
  PageDecoration pageDecoration,
  Widget Function(String, [double]) buildImage,
) {
  return PageViewModel(
    image: buildImage('assets/Tela de Receber (A Capy Presente) 2.png'),
    decoration: pageDecoration,
    titleWidget: Column(
      children: [
        Text(
          'Tudo Pronto!',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          'Sua carteira está configurada',
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.lightForeground.withOpacity(0.7),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
    bodyWidget: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 32),
        
        // Card de informações
        _buildSummaryCard(controller),
        
        const SizedBox(height: 32),
      ],
    ),
  );
}

Widget _buildSummaryCard(OnboardingScreenController controller) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: AppColors.lightBorder),
    ),
    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
    child: Column(
      children: [
        // Nome
        _buildSummaryRow(
          label: 'Nome',
          value: Obx(() => Text(
            controller.draft.value.name,
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.lightForeground,
            ),
          )),
        ),
        
        const SizedBox(height: 12),
        
        // Tipo
        _buildSummaryRow(
          label: 'Tipo',
          value: Obx(() => _buildTypeBadge(controller)),
        ),
        
        const SizedBox(height: 12),
        
        // Rede
        _buildSummaryRow(
          label: 'Rede',
          value: Obx(() => _buildNetworkBadge(controller)),
        ),
      ],
    ),
  );
}

Widget _buildSummaryRow({
  required String label,
  required Widget value,
}) {
  return Row(
    children: [
      Expanded(
        child: Text(
          label,
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.lightForeground.withOpacity(0.8),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      value,
    ],
  );
}

Widget _buildTypeBadge(OnboardingScreenController controller) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: !controller.draft.value.isLightningMode
          ? AppColors.lightPrimary 
          : Colors.deepPurpleAccent,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.rotate(
          angle: !controller.draft.value.isLightningMode 
              ? -45 * 3.1415927 / 180 
              : 45 * 3.1415927 / 220,
          child: Icon(
            !controller.draft.value.isLightningMode
                ? Icons.link 
                : MdiIcons.flashOutline,
            color: Colors.white,
            size: 18,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          !controller.draft.value.isLightningMode ? 'On-chain' : 'Lightning',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget _buildNetworkBadge(OnboardingScreenController controller) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: AppColors.lightInput,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Text(
      controller.draft.value.isTestnet ? 'Testnet' : 'Mainnet',
      style: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.lightForeground,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}