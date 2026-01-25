import 'package:capy_wallet/app/data/models/wallet_info.dart';
import 'package:capy_wallet/app/data/theme/app_colors.dart';
import 'package:capy_wallet/app/data/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Obx(() => Stack(
          children: [
            // Conteúdo principal
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo da Capy
                    _buildLogo(),
                    
                    const SizedBox(height: 15),
                    
                    // Título
                    Text(
                      'Capy Wallet',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Subtítulo
                    Text(
                      'Seu Bitcoin, sua tranquilidade',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.lightForeground.withOpacity(0.7),
                      ),
                    ),
                    
                    const SizedBox(height: 28),
                    
                    // Card principal
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppColors.lightBorder),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Seletor de carteira
                          _buildWalletSelector(),
                          
                          const SizedBox(height: 24),
                          
                          // Campo de senha (PIN)
                          _buildPasswordField(),
                          
                          const SizedBox(height: 24),
                          
                          // Botão Entrar
                          _buildLoginButton(),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Usar biometria
                    _buildBiometricButton(),
                    
                    const SizedBox(height: 16),
                    
                    // Divisor "ou"
                    Row(
                      children: [
                        Expanded(child: Divider(color: AppColors.lightBorder)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'ou',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.lightForeground.withOpacity(0.6),
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: AppColors.lightBorder)),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Criar nova carteira
                    _buildCreateWalletButton(),
                    
                    const SizedBox(height: 24),
                    
                    // Footer
                    Text(
                      '100% não-custodial • Suas chaves, seus Bitcoin',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.lightForeground.withOpacity(0.6),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            
            // Overlay do dropdown (aparece acima de tudo)
            if (controller.isDropdownOpen.value)
              _buildDropdownOverlay(context),
          ],
        )),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(60),
      ),
      child: Center(
        child: Image.asset(
          'assets/Gemini_Generated_Image_smwc3rsmwc3rsmwc.png',
          width: 100,
          height: 100,
        ),
      ),
    );
  }

  Widget _buildWalletSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
             MdiIcons.walletOutline,
              color: AppColors.lightPrimary,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Selecione sua carteira',
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.lightForeground,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        
        // Botão dropdown
        Obx(() {
          if (controller.wallets.isEmpty) {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.lightInput,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.lightBorder),
              ),
              child: Text(
                'Nenhuma carteira encontrada',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.lightForeground.withOpacity(0.6),
                ),
              ),
            );
          }

          return GestureDetector(
            onTap: controller.toggleDropdown,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.lightInput,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: controller.isDropdownOpen.value 
                    ? AppColors.lightPrimary 
                    : AppColors.lightBorder,
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: controller.selectedWallet.value != null
                      ? _buildWalletItemCompact(controller.selectedWallet.value!)
                      : Text(
                          'Selecione uma carteira',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.lightForeground.withOpacity(0.6),
                          ),
                        ),
                  ),
                  Icon(
                    controller.isDropdownOpen.value 
                      ? Icons.keyboard_arrow_up 
                      : Icons.keyboard_arrow_down,
                    color: AppColors.lightForeground.withOpacity(0.6),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildDropdownOverlay(BuildContext context) {
    return GestureDetector(
      onTap: controller.toggleDropdown,
      behavior: HitTestBehavior.opaque,
      child: Container(
        color: Colors.black.withOpacity(0.3),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Espaço antes (para alinhar com a posição do botão)
                const SizedBox(height: 100),
                
                // Container com a lista de carteiras
                GestureDetector(
                  onTap: () {}, // Impede que o tap feche o overlay
                  child: Container(
                    constraints: const BoxConstraints(
                      maxHeight: 300,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppColors.lightBorder),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shrinkWrap: true,
                          itemCount: controller.wallets.length,
                          separatorBuilder: (context, index) => Divider(
                            height: 1,
                            color: AppColors.lightBorder.withOpacity(0.5),
                          ),
                          itemBuilder: (context, index) {
                            final wallet = controller.wallets[index];
                            final isSelected = controller.selectedWallet.value?.id == wallet.id;
                            
                            return InkWell(
                              onTap: () => controller.selectWallet(wallet),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                decoration: BoxDecoration(
                                  color: isSelected 
                                    ? AppColors.lightPrimary.withOpacity(0.1) 
                                    : Colors.transparent,
                                ),
                                child: _buildWalletItem(wallet, isSelected),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWalletItemCompact(WalletInfo wallet) {
    return Row(
      children: [
        Expanded(
          child: Text(
            wallet.name,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.lightForeground,
            ),
          ),
        ),
        
        // Badge do tipo
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: wallet.mode == WalletMode.lightningEnabled
              ? Colors.deepPurpleAccent.withOpacity(0.1)
              : AppColors.lightPrimary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                wallet.mode == WalletMode.lightningEnabled
                  ? Icons.flash_on
                  : Icons.link,
                size: 14,
                color: wallet.mode == WalletMode.lightningEnabled
                  ? Colors.deepPurpleAccent
                  : AppColors.lightPrimary,
              ),
              const SizedBox(width: 4),
              Text(
                wallet.mode == WalletMode.lightningEnabled ? 'Lightning' : 'On-Chain',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: wallet.mode == WalletMode.lightningEnabled
                    ? Colors.deepPurpleAccent
                    : AppColors.lightPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWalletItem(WalletInfo wallet, bool isSelected) {
    return Row(
      children: [
        if (isSelected)
          Icon(
            Icons.check_circle,
            color: AppColors.lightPrimary,
            size: 20,
          ),
        if (isSelected) const SizedBox(width: 8),
        
        Expanded(
          child: Text(
            wallet.name,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              color: AppColors.lightForeground,
            ),
          ),
        ),
        
        // Badge do tipo
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: wallet.mode == WalletMode.lightningEnabled
              ? Colors.deepPurpleAccent.withOpacity(0.1)
              : AppColors.lightPrimary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                wallet.mode == WalletMode.lightningEnabled
                  ? Icons.flash_on
                  : Icons.link,
                size: 14,
                color: wallet.mode == WalletMode.lightningEnabled
                  ? Colors.deepPurpleAccent
                  : AppColors.lightPrimary,
              ),
              const SizedBox(width: 4),
              Text(
                wallet.mode == WalletMode.lightningEnabled ? 'Lightning' : 'On-Chain',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: wallet.mode == WalletMode.lightningEnabled
                    ? Colors.deepPurpleAccent
                    : AppColors.lightPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.lock_outline,
              color: AppColors.lightPrimary,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Senha',
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.lightForeground,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        
        Obx(() => TextField(
          controller: controller.pinController,
          obscureText: !controller.isPasswordVisible.value,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: 'Digite sua senha',
            filled: true,
            fillColor: AppColors.lightInput,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: AppColors.lightBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: AppColors.lightBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: AppColors.lightPrimary, width: 1.5),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                controller.isPasswordVisible.value
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
                color: AppColors.lightForeground.withOpacity(0.6),
              ),
              onPressed: controller.togglePasswordVisibility,
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Obx(() => SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: controller.canLogin.value && !controller.isLoading.value
          ? controller.login
          : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightPrimary,
          disabledBackgroundColor: AppColors.lightPrimary.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 0,
        ),
        child: controller.isLoading.value
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : Text(
              'Entrar',
              style: AppTextStyles.buttonLabel.copyWith(
                color: Colors.white,
              ),
            ),
      ),
    ));
  }

  Widget _buildBiometricButton() {
    return TextButton.icon(
      onPressed: () {
        // TODO: Implementar autenticação biométrica
        Get.snackbar(
          'Em breve',
          'Autenticação biométrica será implementada em breve',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      icon: Icon(
        Icons.fingerprint,
        color: AppColors.lightForeground.withOpacity(0.7),
      ),
      label: Text(
        'Usar biometria',
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.lightForeground.withOpacity(0.7),
        ),
      ),
    );
  }

  Widget _buildCreateWalletButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        onPressed: controller.goToCreateWallet,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.lightPrimary.withOpacity(0.05),
          side: BorderSide(color: AppColors.lightPrimary.withOpacity(0.3)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline,
              color: AppColors.lightPrimary,
            ),
            const SizedBox(width: 8),
            Text(
              'Criar nova carteira',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.lightPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
