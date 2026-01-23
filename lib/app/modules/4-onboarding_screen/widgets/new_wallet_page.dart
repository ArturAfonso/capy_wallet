import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:capy_wallet/app/data/theme/app_colors.dart';
import 'package:capy_wallet/app/data/theme/app_text_styles.dart';
import '../controllers/onboarding_screen_controller.dart';

PageViewModel buildNewWalletPage(
  BuildContext context,
  OnboardingScreenController controller,
  PageDecoration pageDecoration,
  Widget Function(String, [double]) buildImage,
) {
  return PageViewModel(
    titleWidget: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Nova Carteira',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
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
    image: buildImage('assets/Gemini_Generated_Image_smwc3rsmwc3rsmwc.png'),
    decoration: pageDecoration,
    bodyWidget: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 32),

        // Nome da Carteira
        Text(
          "Nome da Carteira",
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.lightForeground,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller.walletNameController,
          decoration: InputDecoration(
            hintText: "Ex: Carteira Principal",
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 0.8,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        color: AppColors.lightPrimary,
        width: 0.8,
      ),
    ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Tipo de Carteira
        Text(
          "Tipo de Carteira",
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.lightForeground,
          ),
        ),
        const SizedBox(height: 8),

        Row(
          children: [
            // On-chain
            Obx(() => _buildWalletTypeOption(
                  context: context,
                  title: "On-chain",
                  subtitle: "Blockchain",
                  icon: Icons.link,
                  isSelected: !controller.draft.value.isLightningMode,//controller.isOnChain.value,
                  onTap: () => controller.draft.value.isLightningMode = false,
                  primaryColor: AppColors.lightPrimary,
                  angle: -45 * 3.1415927 / 180,
                )),

            const SizedBox(width: 12),

            // Lightning
            Obx(() => _buildWalletTypeOption(
                  context: context,
                  title: "Lightning",
                  subtitle: "Pagamentos rápidos",
                  icon: MdiIcons.flashOutline,
                  isSelected: controller.draft.value.isLightningMode,
                  onTap: () => controller.draft.value.isLightningMode = true,
                  primaryColor: Colors.deepPurpleAccent,
                  angle: 45 * 3.1415927 / 220,
                )),

                
          ],
        ),

        const SizedBox(height: 24),
        

        // Configurações Avançadas (Expansível)
        // Obx(() => _buildAdvancedOptions(controller)),
        SizedBox(
          width: Get.size.width,
          child: ExpansionTile(
            title: const Text("Configurações avançadas"),
            leading: const Icon(Icons.settings),
            children: [
               // Checkbox e campo de texto
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Obx(() => CheckboxListTile(
  contentPadding: EdgeInsets.zero,
  title: Text(
    "Adicionar frase de extensão",
    style: AppTextStyles.bodyMedium.copyWith(
      color: AppColors.lightForeground,
      fontWeight: FontWeight.w500,
    ),
  ),
  value: controller.draft.value.extensionPhraseEnabled,
  onChanged: (v) => controller.draft.value = controller.draft.value.copyWith(
    extensionPhraseEnabled: v ?? false,
  ),
  controlAffinity: ListTileControlAffinity.trailing,
  activeColor: AppColors.lightPrimary,
)),
    ),
    Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
      child: Obx(() => controller.draft.value.extensionPhraseEnabled
          ? Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: TextFormField(
                controller: controller.extensionPhraseController,
                decoration: InputDecoration(
                  labelText: "Frase de extensão",
                  hintText: "Digite sua frase de extensão",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.grey, width: 0.8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: AppColors.lightPrimary,
                      width: 1.2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                ),
              ),
            )
          : const SizedBox.shrink()),
    ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.grey,
                    width: 0.7,
                  ),
                ),
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
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.lightForeground.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => Switch(
                        value: controller.draft.value.isTestnet,
                        onChanged: (v) => controller.draft.value = controller.draft.value.copyWith(isTestnet: v),
                        activeColor: AppColors.lightPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Obx(() => !controller.draft.value.isLightningMode ? buildSeedLengthSelector(
    selected: controller.draft.value.seedLength,
    onChanged: (v) => controller.draft.value = controller.draft.value.copyWith(seedLength: v),
    primaryColor: AppColors.lightPrimary,
  ) : const SizedBox.shrink()),
   const SizedBox(height: 10),
            Obx(() => buildTypeAddressSelector(
  selected: controller.draft.value.addressType,
  onChanged: (v) => controller.setAddressType(v),
  primaryColor: AppColors.lightPrimary,
)),
const SizedBox(height: 10),

// Widget de exibição do Derivation Path
Obx(() => buildDerivationPathDisplay(
  derivationPath: controller.draft.value.derivationPath ?? '',
  addressType: controller.draft.value.addressType,
  primaryColor: AppColors.lightPrimary,
)),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    ),
  );
}

Widget buildSeedLengthSelector({
  required int selected,
  required void Function(int) onChanged,
  required Color primaryColor,
}) {
  final options = [12, 18, 24];

  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: Colors.grey,
        width: 0.7,
      ),
    ),
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tamanho da Seed",
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.lightForeground,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: options.map((value) {
         RxBool isSelected = (selected == value).obs;
            return Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: GestureDetector(
                onTap: () => onChanged(value),
                child: Row(
                  children: [
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: primaryColor,
                          width: 2,
                        ),
                        color: Colors.white,
                      ),
                      child: Center(
  child: Container(
    width: 10,
    height: 10,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: selected == value
        ? primaryColor
        : Colors.transparent,
    ),
  ),
)
                      ,
                    ),
                    const SizedBox(width: 6),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$value",
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.lightForeground.withOpacity(0.7),
                          ),
                        ),
                        Text(
                          "palavras",
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.lightForeground.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

Widget buildTypeAddressSelector({
  required String selected,
  required void Function(String) onChanged,
  required Color primaryColor,
}) {
  final options = [
    {'key': 'native_segwit', 'title': 'Native SegWit', 'subtitle': 'BIP-84, endereços iniciam com bc1/tb1 (recomendado)'},
    {'key': 'segwit_compatible', 'title': 'SegWit Compatível', 'subtitle': 'BIP-49, endereços iniciam com 3 (compatibilidade)'},
    {'key': 'legacy', 'title': 'Legacy', 'subtitle': 'BIP-44, endereços iniciam com 1 (antigo)'},
  ];

  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: Colors.grey,
        width: 0.7,
      ),
    ),
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tipo de endereço",
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.lightForeground,
          ),
        ),
        const SizedBox(height: 12),
        Column(
          children: options.map((option) {
            final key = option['key'] as String;
            final title = option['title'] as String;
            final subtitle = option['subtitle'] as String;
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: GestureDetector(
                onTap: () => onChanged(key),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: primaryColor,
                          width: 2,
                        ),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selected == key
                                ? primaryColor
                                : Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.lightForeground,
                            ),
                          ),
                          Text(
                            subtitle,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.lightForeground.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          
        ),
        // AVISO: só aparece se não for native_segwit
        if (selected != 'native_segwit')
          buildLegacyWarning(color: AppColors.lightPrimary),
    
      ],
    ),
  );
}

// Widget helper para tipo de carteira
Widget _buildWalletTypeOption({
  required BuildContext context,
  required String title,
  required String subtitle,
  required IconData icon,
  required bool isSelected,
  required VoidCallback onTap,
  required Color primaryColor,
  required double angle,
}) {
  return Flexible(
    child: GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1.4, // Mantém o card quadrado
        child: Stack(
          children: [
            // Fundo sempre branco
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? primaryColor : Colors.transparent,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.07),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
            // Overlay colorido só se selecionado
            if (isSelected)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.11),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            // Conteúdo do card
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Transform.rotate(
                    angle: angle,
                    child: Icon(icon, color: primaryColor),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.lightForeground,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.lightForeground.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildDerivationPathDisplay({
  required String derivationPath,
  required String addressType,
  required Color primaryColor,
}) {
  // Descrição baseada no tipo de endereço
  final description = addressType == 'native_segwit' 
      ? 'Caminho de derivação da carteira (BIP-84)'
      : addressType == 'segwit_compatible'
          ? 'Caminho de derivação da carteira (BIP-49)'
          : 'Caminho de derivação da carteira (BIP-44)';

  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: Colors.grey,
        width: 0.7,
      ),
    ),
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Derivation Path",
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.lightForeground,
          ),
        ),
        const SizedBox(height: 8),
        // Container de exibição (NÃO é TextField)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            derivationPath,
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
              color: primaryColor,
              fontFamily: 'Courier', // Fonte monoespaçada para código
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          description,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.lightForeground.withOpacity(0.6),
          ),
        ),
      ],
    ),
  );
}

Widget buildLegacyWarning({required Color color}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(
        color: color,
        width: 1,
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.warning_amber_rounded, color: color, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            "Carteiras Legacy ou SegWit Compatível não suportam atualização futura para Lightning Network.",
            style: AppTextStyles.bodyMedium.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}


// Widget de configurações avançadas
Widget _buildAdvancedOptions(OnboardingScreenController controller) {
  return GestureDetector(
    onTap: () => controller.isAdvancedOptionsExpanded.value = !controller.isAdvancedOptionsExpanded.value,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Configurações avançadas",
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightForeground,
                  ),
                ),
              ),
              Icon(
                controller.isAdvancedOptionsExpanded.value ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: controller.draft.value.isLightningMode ? Colors.deepPurpleAccent : AppColors.lightPrimary,
              ),
            ],
          ),

          // Conteúdo expansível
          if (controller.isAdvancedOptionsExpanded.value) ...[
            const SizedBox(height: 16),

            // Rede Testnet
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.grey, // Escolha a cor que destaca
                  width: 2, // Espessura da borda
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rede Testnet",
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.lightForeground,
                          ),
                        ),
                        Text(
                          "Para testes e desenvolvimento",
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.lightForeground.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => Switch(
                      value: controller.draft.value.isTestnet,
                      onChanged: (v) => controller.draft.value = controller.draft.value.copyWith(isTestnet: v),
                      activeColor: AppColors.lightPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    ),
  );
}
