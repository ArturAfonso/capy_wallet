import 'dart:ui';

import 'package:capy_wallet/app/data/shared/custom_button.dart';
import 'package:capy_wallet/app/data/theme/app_colors.dart';
import 'package:capy_wallet/app/data/theme/app_text_styles.dart';
import 'package:capy_wallet/app/modules/onboarding_screen/views/pre_onboarding_screen.dart';
import 'package:capy_wallet/app/routes/app_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../controllers/onboarding_screen_controller.dart';

class OnboardingScreenView extends GetView<OnboardingScreenController> {
  const OnboardingScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final pageDecoration = PageDecoration(
      titleTextStyle: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold, fontSize: 30),
      bodyTextStyle: AppTextStyles.bodyLarge.copyWith(
        fontWeight: FontWeight.normal,
        color: AppColors.lightForeground.withOpacity(0.7),
      ),
      bodyPadding: EdgeInsets.symmetric(horizontal: 15),
      pageColor: Theme.of(context).scaffoldBackgroundColor,
      imagePadding: EdgeInsets.only(top: 50),
      titlePadding: EdgeInsets.zero,
      imageAlignment: Alignment.center,
      bodyAlignment: Alignment.topCenter,
      imageFlex: 1,
      bodyFlex: 2,
    );

    void onIntroEnd(BuildContext context) {
      Get.toNamed(Routes.HOME);
    }

    Widget buildImage(String assetName, [double width = 350]) {
      return Image.asset(assetName, width: width);
    }

    List<PageViewModel> pages = [
      PageViewModel(
        titleWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Nova Carteira',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold, fontSize: 40),
            ),
            Text(
              "Configure os detalhes.",
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.normal,
                color: AppColors.lightForeground.withOpacity(0.7),
              ),
            ),
          ],
        ),
        //body: "Anote cada refeição e acompanhe se está dentro ou fora da sua dieta.",
        image: buildImage('assets/Gemini_Generated_Image_smwc3rsmwc3rsmwc.png'),
        decoration: pageDecoration,
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),
            Text(
              "Nome da Carteira",
              style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold, color: AppColors.lightForeground),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: controller.walletNameController.value,
              decoration: InputDecoration(
                hintText: "Ex: Carteira Principal",
                filled: true,
                fillColor: AppColors.lightInput,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              ),
            ),
            const SizedBox(height: 24),
            // Tipo de Carteira
            Text(
              "Tipo de Carteira",
              style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold, color: AppColors.lightForeground),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                // On-chain
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.isOnChain.value = true,
                    child: Obx(
                      () => Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: controller.isOnChain.value ? AppColors.lightPrimary.withOpacity(0.08) : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: controller.isOnChain.value ? AppColors.lightPrimary : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Transform.rotate(
                              angle: -45 * 3.1415927 / 180,
                              child: Icon(Icons.link, color: AppColors.lightPrimary),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "On-chain",
                              style: AppTextStyles.bodyLarge.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.lightForeground,
                              ),
                            ),
                            Text(
                              "Bitcoin na blockchain",
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.lightForeground.withOpacity(0.7),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Lightning
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.isOnChain.value = false,
                    child: Obx(
                      () => Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: !controller.isOnChain.value ? Colors.deepPurpleAccent.withOpacity(0.08) : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: !controller.isOnChain.value ? Colors.deepPurpleAccent : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Transform.rotate(
                              angle: 45 * 3.1415927 / 220,

                              child: Icon(MdiIcons.flashOutline, color: Colors.deepPurpleAccent),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Lightning",
                              style: AppTextStyles.bodyLarge.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.lightForeground,
                              ),
                            ),
                            Text(
                              "Pagamentos rápidos",
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.lightForeground.withOpacity(0.7),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Rede Testnet
            Container(
              decoration: BoxDecoration(color: AppColors.lightInput, borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rede Testnet",
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.lightForeground,
                          ),
                        ),
                        Text(
                          "Para testes e desenvolvimento",
                          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.lightForeground.withOpacity(0.7)),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => Switch(
                      value: controller.isTestnet.value,
                      onChanged: (v) => controller.isTestnet.value = v,
                      activeThumbColor: AppColors.lightPrimary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
      PageViewModel(
        titleWidget: Column(
          children: [
            SizedBox(height: 100),
            Text(
              'Suas palavras-Chave',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold, fontSize: 40),
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
            Container(
              decoration: BoxDecoration(
                color: AppColors.lightDestructive.withOpacity(0.1),
                border: Border.all(color: AppColors.lightDestructive.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
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
                        SizedBox(height: 2),
                        Text(
                          'Estas palavras são a única forma de recuperar sua carteira. Nunca compartilhe com ninguém.',
                          style: AppTextStyles.bodyLarge.copyWith(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            // Palavras-chave com blur
            Container(
              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.08), borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Obx(
                        () => GestureDetector(
                          onTap: () => controller.obscure.value = !controller.obscure.value,
                          child: Row(
                            children: [
                              Icon(controller.obscure.value ? Icons.visibility : Icons.visibility_off),
                              const SizedBox(width: 4),
                              Text(
                                controller.obscure.value ? 'Revelar' : 'Ocultar',
                                style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500),
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
                            Icon(Icons.copy, color: Theme.of(context).colorScheme.primary),
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
                  // Substitua o trecho do Wrap por este GridView:
                  Obx(
                    () => GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.seedWords.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // 3 colunas
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 1.8, // Ajuste para o formato desejado
                      ),
                      itemBuilder: (context, i) {
                        final word = controller.seedWords[i];
                        return Obx(
                          () => controller.obscure.value
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        color: Colors.grey.withOpacity(0.18),
                                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                        child: Text(
                                          '${i + 1}. ',
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
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.18),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                  child: Text(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    '${i + 1}. $word',
                                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            // Checkbox
            Row(
              children: [
                Obx(
                  () => Checkbox(
                    value: controller.confirmed.value,
                    onChanged: (v) => controller.confirmed.value = v ?? false,
                  ),
                ),
                Expanded(child: Text('Guardei minhas palavras em um local seguro', style: AppTextStyles.bodyMedium)),
              ],
            ),
          ],
        ),
      ),
      PageViewModel(
        image: buildImage('assets/Tela de Receber (A Capy Presente) 2.png'),
        decoration: pageDecoration,
        titleWidget: Column(
          children: [
            Text(
              'Tudo Pronto!',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold, fontSize: 32),
              textAlign: TextAlign.center,
            ),
            Text(
              'Sua carteira está configurada',
              style: AppTextStyles.bodyLarge.copyWith(color: AppColors.lightForeground.withOpacity(0.7)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            // Card de informações
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.lightBorder),
              ),
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Nome',
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: AppColors.lightForeground.withOpacity(0.8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      Obx(
                        () => Text(
                          controller.walletNameController.value.text,
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.lightForeground,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Tipo',
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: AppColors.lightForeground.withOpacity(0.8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Obx(
                        () => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: controller.isOnChain.value ? AppColors.lightPrimary : Colors.deepPurpleAccent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Transform.rotate(
                                angle: controller.isOnChain.value ? -45 * 3.1415927 / 180 : 45 * 3.1415927 / 220,
                                child: Obx(
                                  () => Icon(
                                    controller.isOnChain.value ? Icons.link : MdiIcons.flashOutline,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Obx(
                                () => Text(
                                  controller.isOnChain.value ? 'On-chain' : 'Lightning',
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Rede",
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: AppColors.lightForeground.withOpacity(0.8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Obx(
                        () => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.lightInput,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            controller.isTestnet.value ? 'Testnet' : 'Mainnet',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.lightForeground,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Botão finalizar
          ],
        ),
      ),
    ];
    RxInt actualPage = (controller.introKey.currentState?.getCurrentPage() ?? 0).obs;

    return IntroductionScreen(
      key: controller.introKey,
      globalBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      allowImplicitScrolling: false,
      freeze: true,
      globalHeader: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 16),
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(20)),
              child: IconButton(
                onPressed: () {
                  final currentPage = controller.introKey.currentState?.getCurrentPage() ?? 0;
                  if (currentPage > 0 && currentPage < 2) {
                    actualPage.value = currentPage - 1;
                    controller.introKey.currentState?.previous();
                  } else if (currentPage == 2) {
                    print(currentPage);
                  } else {
                    // Se está na primeira página, pode voltar para a tela anterior ou sair
                    Get.back(); // ou Navigator.pop(context);
                  }
                },
                icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).colorScheme.onSurface, size: 20),
                padding: const EdgeInsets.all(8),
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              ),
            ),
          ),
        ),
      ),
      infiniteAutoScroll: false,

      globalFooter: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Obx(
          () => CustomButton(
            text: actualPage.value == 2 ? 'Finalizar e Criar Pin' : 'Continuar ',
            textStyle: AppTextStyles.buttonLabel,
            onPressed:
                (actualPage.value == 0 && controller.isWalletNameFilled.value) ||
                    (actualPage.value == 1 && controller.confirmed.value) ||
                    (actualPage.value == 2)
                ? () {
                    final currentPage = controller.introKey.currentState?.getCurrentPage() ?? 0;
                    if (currentPage < 2) {
                      actualPage.value = currentPage + 1;
                      controller.introKey.currentState?.next();
                    } else if (currentPage == 2) {
                      // Leva para a nova página (exemplo: tela de PIN)
                      //Get.toNamed(Routes.PIN); // Troque para a rota desejada
                      print('criar pin');
                      Get.toNamed(Routes.PIN);
                    }
                  }
                : null,
          ),
        ),
      ),
      pages: pages,
      onDone: () => onIntroEnd(context),
      onSkip: () => onIntroEnd(context), // You can override onSkip callback

      skipOrBackFlex: 0,
      nextFlex: 0,
      showNextButton: false,
      showBackButton: false,
      showDoneButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: Icon(Icons.arrow_forward, color: Theme.of(context).colorScheme.onSurface),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,

      controlsPadding: kIsWeb ? const EdgeInsets.all(12.0) : const EdgeInsets.fromLTRB(8.0, 10, 8.0, 0),

      dotsDecorator: DotsDecorator(
        size: Size(10.0, 10.0),
        color: Theme.of(context).dividerColor,
        activeColor: Theme.of(context).colorScheme.primary,
        activeSize: Size(20, 10),
        activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
      ),
    );
  }
}
