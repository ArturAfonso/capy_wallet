import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:get/get.dart';
import 'package:capy_wallet/app/data/theme/app_colors.dart';
import 'package:capy_wallet/app/data/theme/app_text_styles.dart';
import '../controllers/onboarding_screen_controller.dart';

PageViewModel buildSeedPage(
  BuildContext context,
  OnboardingScreenController controller,
  PageDecoration pageDecoration,
) {
  return PageViewModel(
    titleWidget: Column(
      children: [
        const SizedBox(height: 100),
        Text(
          'Suas palavras-Chave',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
        ),
        Text(
          "Guarde-as em um local seguro.",
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.normal,
            color: AppColors.lightForeground.withOpacity(0.7),
          ),
        ),
      ],
    ),
    decoration: pageDecoration,
    bodyWidget: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        
        // Alert de aviso
        _buildWarningAlert(),
        
        const SizedBox(height: 18),
        
        // Container de palavras
        _buildSeedWordsContainer(context, controller),
        
        const SizedBox(height: 18),
        
        // Checkbox de confirmação
        _buildConfirmationCheckbox(controller),
      ],
    ),
  );
}

Widget _buildWarningAlert() {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.lightDestructive.withOpacity(0.1),
      border: Border.all(
        color: AppColors.lightDestructive.withOpacity(0.3),
      ),
      borderRadius: BorderRadius.circular(16),
    ),
    padding: const EdgeInsets.all(16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
          size: 28,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Importante!',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Estas palavras são a única forma de recuperar sua carteira. '
                'Nunca compartilhe com ninguém.',
                style: AppTextStyles.bodyLarge.copyWith(fontSize: 15),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildSeedWordsContainer(
  BuildContext context,
  OnboardingScreenController controller,
) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(0.08),
      borderRadius: BorderRadius.circular(16),
    ),
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        // Controles (Revelar/Ocultar e Copiar)
        Row(
          children: [
            Obx(
              () => GestureDetector(
                onTap: () => controller.obscure.value = 
                    !controller.obscure.value,
                child: Row(
                  children: [
                    Icon(
                      controller.obscure.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      controller.obscure.value ? 'Revelar' : 'Ocultar',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: controller.copyToClipboard,
              child: Row(
                children: [
                  Icon(
                    Icons.copy,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Copiar',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        
        // Grid de palavras
        Obx(() => _buildSeedWordsGrid(controller)),
      ],
    ),
  );
}

Widget _buildSeedWordsGrid(OnboardingScreenController controller) {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: controller.seedWords.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 1.8,
    ),
    itemBuilder: (context, i) {
      final word = controller.seedWords[i];
      return Obx(
        () => controller.obscure.value
            ? _buildBlurredWord(i)
            : _buildVisibleWord(i, word),
      );
    },
  );
}

Widget _buildBlurredWord(int index) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          color: Colors.grey.withOpacity(0.18),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Text(
            '${index + 1}. ',
            style: const TextStyle(
              color: Colors.transparent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.transparent,
          ),
        ),
      ],
    ),
  );
}

Widget _buildVisibleWord(int index, String word) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(0.18),
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    child: Text(
      '${index + 1}. $word',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _buildConfirmationCheckbox(OnboardingScreenController controller) {
  return Row(
    children: [
     Obx(
  () => Checkbox(
    value: controller.draft.value.isSeedBackedUp,
    onChanged: (v) => controller.draft.value = controller.draft.value.copyWith(isSeedBackedUp: v ?? false),
  ),
),
      Expanded(
        child: Text(
          'Guardei minhas palavras em um local seguro',
          style: AppTextStyles.bodyMedium,
        ),
      ),
    ],
  );
}