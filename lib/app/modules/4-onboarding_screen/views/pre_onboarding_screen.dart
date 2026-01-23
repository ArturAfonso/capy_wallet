

// ignore_for_file: deprecated_member_use

import 'package:capy_wallet/app/data/shared/custom_button.dart';
import 'package:capy_wallet/app/data/theme/app_colors.dart';
import 'package:capy_wallet/app/data/theme/app_text_styles.dart';
import 'package:capy_wallet/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';


class PreOnboardingScreenView extends StatelessWidget {
  const PreOnboardingScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            
              
          Image.asset('assets/Tela de Boas-vindas (A Capy Zen).png'),
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
          
             
              Text("Bem-vindo a", style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold)),
               SizedBox(width: 10),
               Text("Capy", 
               style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
                ),
               
               ),
              ],
              
              ),
              Text("Seu Bitcoin seguro e tranquilo.", 
              style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.normal, color: AppColors.lightForeground.withOpacity(0.7)
             
              )),
              Text("Sem estresse, sem custódia", style:AppTextStyles.bodyLarge.copyWith(
                color: AppColors.lightForeground.withOpacity(0.7),
                fontWeight: FontWeight.normal, 
             
              )),
              const SizedBox(height: 20),
            
            ],
          
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             CustomButton(
              text: 'Vamos lá',
              textStyle: AppTextStyles.buttonLabel,
             onPressed: () => Get.toNamed(Routes.FORKSTART_SCREEN),
              ),
              const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("100% não-custodial. ", style: Theme.of(context).textTheme.bodyMedium),
                Text('Suas chaves, seus bitcoins', style: Theme.of(context).textTheme.bodyMedium /* TextStyle(color: MealMSettings().textColorTertiaryLight), */),
              ],
            ),
          ],
        ),
      ) 
    );
  }



}



class CapyImageBlended extends StatelessWidget {
  final String imagePath;
  final double height;

  const CapyImageBlended({
    super.key,
    required this.imagePath,
    this.height = 450,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        // Cria um gradiente radial que vai do centro para as bordas
        return const RadialGradient(
          center: Alignment.center,
          // O raio define até onde a imagem é sólida.
          // 0.6 significa que 60% do centro é sólido, depois começa a sumir.
          radius: 0.7, 
          colors: [
            Colors.black, // Cor sólida (mantém a imagem)
            Colors.transparent, // Cor transparente (faz a imagem sumir)
          ],
          // Define onde a transição começa e termina.
          // [0.5, 1.0] significa: sólido até 50% do raio, e suaviza até 100%.
          stops: [0.6, 1.0], 
        ).createShader(bounds);
      },
      // BlendMode.dstIn diz: "Mantenha a imagem apenas onde a máscara NÃO é transparente"
      blendMode: BlendMode.dstIn,
      child: Image.asset(
        imagePath,
        height: height,
        fit: BoxFit.contain,
      ),
    );
  }
}
