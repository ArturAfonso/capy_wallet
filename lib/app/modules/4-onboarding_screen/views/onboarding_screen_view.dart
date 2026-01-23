import 'dart:ui';

import 'package:capy_wallet/app/data/shared/custom_button.dart';
import 'package:capy_wallet/app/data/theme/app_colors.dart';
import 'package:capy_wallet/app/data/theme/app_text_styles.dart';
import 'package:capy_wallet/app/modules/4-onboarding_screen/widgets/new_wallet_page.dart';
import 'package:capy_wallet/app/modules/4-onboarding_screen/widgets/seed_generated_page.dart';
import 'package:capy_wallet/app/modules/4-onboarding_screen/widgets/wallet_summary_page.dart';
import 'package:capy_wallet/app/routes/app_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../controllers/onboarding_screen_controller.dart';

class OnboardingScreenView extends GetView<OnboardingScreenController> {
  const OnboardingScreenView({super.key});

  
// Métodos auxiliares:
/* bool _canProceed() {
  switch (controller.actualPage.value) {
    case 0:
      // ✅ Agora usa a variável reativa que é atualizada pelo listener
      return controller.isWalletNameFilled.value;
    case 1:
      return controller.seedConfirmed.value;
    case 2:
      return true;
    default:
      return false;
  }
} */
 Future<void> _handleContinue() async {
  final currentPage = controller.actualPage.value;

  if (currentPage == 0) {
    // Não precisa mais de updateWalletConfigFromPage0, pois o draft já está sempre atualizado pelos listeners

    if (controller.isStandardConfig) {
      _proceedToNextPage();
    } else {
      _showAdvancedConfigDialog(
        isLightning: controller.draft.value.isLightningMode,
        isTestnet: controller.draft.value.isTestnet,
      );
    }
  } else if (currentPage == 1) {
    _proceedToNextPage();
  } else if (currentPage == 2) {
    final createdWallet = await controller.finalizeWallet();
    if (createdWallet != null) {
         // Passa o objeto REAL (com ID) para a tela de PIN
         Get.toNamed(Routes.PIN, arguments: createdWallet);
       }
  }
}

  @override
  Widget build(BuildContext context) {
    final pageDecoration = PageDecoration(
      titleTextStyle: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold, fontSize: 30),
      bodyTextStyle: AppTextStyles.bodyLarge.copyWith(
        fontWeight: FontWeight.normal,
        color: AppColors.lightForeground.withOpacity(0.7),
      ),
      bodyPadding: const EdgeInsets.symmetric(horizontal: 15),
      pageColor: Theme.of(context).scaffoldBackgroundColor,
      imagePadding: const EdgeInsets.only(top: 50),
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
      return GestureDetector(
        onTap: controller.printDraftInfo,
        child: Image.asset(assetName, width: width));
    }

        List<PageViewModel> pages = [
      buildNewWalletPage(context, controller, pageDecoration, buildImage),
      buildSeedPage(context, controller, pageDecoration),
      buildWalletSummaryPage(context, controller, pageDecoration, buildImage),
    ];


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
                    controller.actualPage.value = currentPage - 1;
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
      text: controller.actualPage.value == 2 
          ? 'Finalizar e Criar Pin' 
          : 'Continuar',
      textStyle: AppTextStyles.buttonLabel,
      onPressed: controller.canProceed ? () => _handleContinue() : null,
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
        size: const Size(10.0, 10.0),
        color: Theme.of(context).dividerColor,
        activeColor: Theme.of(context).colorScheme.primary,
        activeSize: const Size(20, 10),
        activeShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
      ),
    );
  }

  // Adicione este método no corpo da classe OnboardingScreenView (fora do build)
/* void _checkAndProceedFromPage0() {
  // Verificar se está usando configurações padrão LDK
  // Padrão LDK: Native SegWit + Mainnet + Sem customização de path
  bool isStandardLDK = controller.isOnChain.value == true && 
                       !controller.isTestnetSelected.value;
  
  // Verificar se é Lightning (sempre precisa de aviso sobre compatibilidade futura)
  bool isLightning = !controller.isOnChain.value;
  
  // Verificar se está em Testnet
  bool isTestnet = controller.isTestnetSelected.value;
  
  if (isStandardLDK && !isLightning) {
    // Caminho feliz: configuração padrão, pode prosseguir direto
    _proceedToNextPage();
  } else {
    // Mostrar dialog de aviso
    _showAdvancedConfigDialog(isLightning: isLightning, isTestnet: isTestnet);
  }
} */
 
 void _proceedToNextPage() {
  final currentPage = controller.introKey.currentState?.getCurrentPage() ?? 0;
  controller.actualPage.value = currentPage + 1;
  controller.introKey.currentState?.next();
}


void _showAdvancedConfigDialog({required bool isLightning, required bool isTestnet}) {
  final RxBool isConfirmed = false.obs;
  
  Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: isTestnet ? Colors.orange : Colors.red,
            size: 28,
          ),
          const SizedBox(width: 8),
           Expanded(
            child: Text(
              "Configuração Avançada",
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isTestnet) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "⚠️ Rede Testnet",
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Você está criando uma carteira na rede de testes (Testnet). "
                      "Esta carteira NÃO usa Bitcoin real e é apenas para desenvolvimento e aprendizado.",
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.orange.shade900,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
            
            if (isLightning) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.purple.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "⚡ Lightning Network",
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.purple.shade900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Carteiras Lightning exigem configurações específicas e gerenciamento de canais. "
                      "Esta é uma funcionalidade avançada.",
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.purple.shade900,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
            
            const Text(
              "Recomendações:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            _buildRecommendationItem("Use Native SegWit para compatibilidade máxima"),
            _buildRecommendationItem("Mainnet apenas para valores reais"),
            _buildRecommendationItem("Testnet é seguro para aprender"),
            
            const SizedBox(height: 16),
            Obx(
              () => CheckboxListTile(
                value: isConfirmed.value,
                onChanged: (v) => isConfirmed.value = v ?? false,
                title: const Text(
                  "Estou ciente e quero continuar com esta configuração",
                  style: TextStyle(fontSize: 14),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                dense: true,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); // Fecha o dialog
            // Opcionalmente, resetar para configurações padrão
            /* controller.isTestnetSelected.value */ 
            /* controller.isOnChain.value = true; */ 
          },
          child: Text(
            "Voltar e Alterar",
            style: TextStyle(color: AppColors.lightForeground.withOpacity(0.7)),
          ),
        ),
        Center(
          child: Obx(
            () => ElevatedButton(
              onPressed: isConfirmed.value
                  ? () {
                      Get.back(); // Fecha dialog
                      _proceedToNextPage(); // Avança para próxima página
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isTestnet ? Colors.orange : AppColors.lightPrimary,
                disabledBackgroundColor: Colors.grey.shade300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Criar Mesmo Assim",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    ),
    barrierDismissible: false, // Não permite fechar clicando fora
  );
}

Widget _buildRecommendationItem(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.check_circle_outline,
          color: AppColors.lightPrimary,
          size: 20,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodyMedium,
          ),
        ),
      ],
    ),
  );
}

}
