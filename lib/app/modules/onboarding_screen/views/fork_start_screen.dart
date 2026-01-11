

// ignore_for_file: deprecated_member_use

import 'package:capy_wallet/app/data/shared/custom_button.dart';
import 'package:capy_wallet/app/data/theme/app_colors.dart';
import 'package:capy_wallet/app/data/theme/app_text_styles.dart';
import 'package:capy_wallet/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/onboarding_screen_controller.dart';



class ForkStartScreen extends StatelessWidget {
  const ForkStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Imagem centralizada
                  Image.asset(
                    'assets/Gemini_Generated_Image_q7aaokq7aaokq7aa.png',
                   //height: 140,
                  ),
                  const SizedBox(height: 32),
                  // Título
                  Text(
                    "Como você quer começar?",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  // Subtítulo
                  Text(
                    "Escolha uma opção para continuar",
                    style:AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.normal, color: AppColors.lightForeground.withOpacity(0.7)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  // Card: Criar Nova Carteira
                  _OptionCard(
                    icon: Icons.auto_awesome,
                    iconColor: AppColors.lightPrimary,
                    title: "Criar Nova Carteira",
                    description: "Gere novas palavras-chave (seed) e comece do zero",
                    onTap: () {
                      // Navegue para a tela de criar carteira
                       Get.toNamed(Routes.ONBOARDING_SCREEN); 
                    },
                  ),
                  const SizedBox(height: 16),
                  // Card: Recuperar Carteira
                  _OptionCard(
                    icon: Icons.sync,
                    iconColor: AppColors.lightSecondary,
                    title: "Recuperar Carteira",
                    description: "Use suas palavras-chave existentes para restaurar",
                    onTap: () {
                    
                     Get.toNamed(Routes.RECOVER_WALLET);
                    },
                  ),
                  const SizedBox(height: 32),
                  // Botão Voltar
                  TextButton(
                    onPressed: () => Get.back(),
                    child:  Text("← Voltar", style: AppTextStyles.bodyLarge.copyWith(color: AppColors.lightForeground.withOpacity(0.7)), )
                  ),
                 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OptionCard extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _OptionCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  State<_OptionCard> createState() => _OptionCardState();
}

class _OptionCardState extends State<_OptionCard> {
    final bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
        
          color: _isPressed
              ? widget.iconColor // Borda colorida ao pressionar
              : Theme.of(context).dividerColor, // Borda padrão
          width: 2,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: widget.iconColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(10),
                child: Icon(widget.icon, color: widget.iconColor, size: 28),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.lightForeground,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.description,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.lightForeground.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}