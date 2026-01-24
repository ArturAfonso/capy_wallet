import 'package:capy_wallet/app/data/models/wallet_info.dart';
import 'package:capy_wallet/app/data/services/wallet_storage_service.dart';
import 'package:capy_wallet/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final WalletStorageService _storage = Get.find();

  // ============= ESTADO =============
  final wallets = <WalletInfo>[].obs;
  final Rx<WalletInfo?> selectedWallet = Rx<WalletInfo?>(null);
  final isDropdownOpen = false.obs;
  final isPasswordVisible = false.obs;
  final isLoading = false.obs;
  final canLogin = false.obs; // Agora é observável

  // ============= CONTROLLERS =============
  final pinController = TextEditingController();

  // ============= GETTERS =============
  // Removido o getter não-reativo

  // ============= MÉTODOS =============

  @override
  void onInit() {
    super.onInit();
    loadWallets();
    
    // Adiciona listener para atualizar canLogin quando o texto mudar
    pinController.addListener(_updateCanLogin);
    
    // Observa mudanças no selectedWallet
    ever(selectedWallet, (_) => _updateCanLogin());
  }

  /// Atualiza o estado do botão de login
  void _updateCanLogin() {
    canLogin.value = selectedWallet.value != null && pinController.text.length >= 6;
  }

  /// Carrega a lista de wallets disponíveis
  Future<void> loadWallets() async {
    try {
      isLoading.value = true;
      final loadedWallets = await _storage.getWallets();
    /*   final loadedWallets = [WalletInfo(id: '1', name: 'Carteira Exemplo'), WalletInfo(id: '2', name: 'Outra Carteira'), 
      WalletInfo(id: '3', name: 'Terceira Carteira', mode: WalletMode.lightningEnabled), WalletInfo(id: '4', name: 'Quarta Carteira'), WalletInfo(id: '5', name: 'Quinta Carteira', mode: WalletMode.lightningEnabled)  
         ]; */ // Mock temporário
      wallets.value = loadedWallets;

      // Seleciona automaticamente a primeira wallet se houver
      if (loadedWallets.isNotEmpty) {
        selectedWallet.value = loadedWallets.first;
      }
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Falha ao carregar carteiras: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Seleciona uma wallet
  void selectWallet(WalletInfo wallet) {
    selectedWallet.value = wallet;
    isDropdownOpen.value = false;
    pinController.clear();
  }

  /// Toggle visibilidade do dropdown
  void toggleDropdown() {
    isDropdownOpen.value = !isDropdownOpen.value;
  }

  /// Toggle visibilidade da senha
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  /// Tenta fazer login
 Future<void> login() async {
    // 1. Validações básicas antes de chamar o serviço
    if (!canLogin.value || selectedWallet.value == null) return;

    try {
      isLoading.value = true;

      // 2. Chama o serviço para verificar o Hash
      // O serviço pega o Salt salvo na carteira, mistura com o texto digitado
      // gera o Hash e compara com o Hash salvo.
      final bool isValid = await _storage.verifyWalletPin(
        selectedWallet.value!.id,
        pinController.text,
      );

      if (isValid) {
        // --- SUCESSO ---
        // Redireciona baseado no modo da carteira
        if (selectedWallet.value!.mode == WalletMode.onChainOnly) {
          // Carteira On-Chain Only -> HomeOnchainView
          Get.offAllNamed(Routes.HOME_ONCHAIN, arguments: selectedWallet.value);
        } else {
          // Carteira Lightning Enabled -> HomeLightningView
          Get.offAllNamed(Routes.HOME_LIGHTNING, arguments: selectedWallet.value);
        }
        
        // Limpa a memória do controller local
      //  pinController.clear();
        
      } else {
        // --- SENHA INCORRETA ---
        Get.snackbar(
          'Acesso Negado',
          'PIN incorreto. Tente novamente.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.9),
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          borderRadius: 8,
          icon: const Icon(Icons.lock_person, color: Colors.white),
          duration: const Duration(seconds: 2),
        );
        
        // Opcional: Limpar o campo para forçar digitar de novo
        //$pinController.clear();
      }

    } catch (e) {
      Get.snackbar(
        'Erro',
        'Falha ao verificar credenciais: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Navega para tela de criar nova carteira
  void goToCreateWallet() {
    Get.toNamed(Routes.ONBOARDING_SCREEN);
  }

  @override
  void onClose() {
    pinController.dispose();
    super.onClose();
  }
}
