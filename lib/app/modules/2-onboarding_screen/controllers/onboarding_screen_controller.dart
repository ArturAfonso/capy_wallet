import 'package:capy_wallet/app/data/app_config.dart';
import 'package:capy_wallet/app/data/models/wallet_info.dart';
import 'package:capy_wallet/app/data/services/wallet_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';


class OnboardingScreenController extends GetxController {
  final WalletStorageService _storage = Get.find();
  
    // ============= NAVEGAÇÃO =============
  final introKey = GlobalKey<IntroductionScreenState>();
  RxInt actualPage = 0.obs;

  // ============= WALLET INFO EM CONSTRUÇÃO =============
  Rx<WalletInfo?> walletInProgress = Rx<WalletInfo?>(null);
  RxString generatedMnemonic = ''.obs;
  RxInt seedLength = 12.obs;



  // ============= PAGE 0: CONFIGURAÇÃO INICIAL =============
  final walletNameController = TextEditingController();
  RxBool isOnChain = true.obs;
  RxBool isAdvancedOptionsExpanded = false.obs;
  RxString addressType = 'native_segwit'.obs; // Padrão
  RxBool isTestnetSelected = true.obs; // Seleção do usuário no switch
  RxBool isExtensionPhraseEnabled = false.obs;
  final extensionPhraseController = TextEditingController();
  
  // Getter para derivation path
String get derivationPath => AppConfig.getDerivationPath(
  addressType.value,
  isTestnetSelected.value,
);

 /// Retorna a descrição do tipo de endereço
  static String getAddressTypeDescription(String addressType) {
    switch (addressType) {
      case 'native_segwit':
        return 'Caminho de derivação da carteira (BIP-84)';
      case 'segwit_compatible':
        return 'Caminho de derivação da carteira (BIP-49)';
      case 'legacy':
        return 'Caminho de derivação da carteira (BIP-44)';
      default:
        return 'Caminho de derivação da carteira (BIP-84)';
    }
  }

  // ✅ CORREÇÃO: Variável reativa em vez de getter
  RxBool isWalletNameFilled = false.obs;




  // ============= PAGE 1: SEED PHRASE =============
  RxBool obscure = true.obs;
  RxBool seedConfirmed = false.obs;
  RxList<String> seedWords = <String>[].obs;

  // ============= PAGE 2: RESUMO =============
  RxBool confirmed = false.obs;

  // ============= MÉTODOS DA PAGE 0 =============
  
  /// Atualiza o objeto WalletInfo com os dados da página 0
  void updateWalletConfigFromPage0() {
    final mode = isOnChain.value 
        ? WalletMode.onChainOnly 
        : WalletMode.lightningEnabled;
    
    final network = isTestnetSelected.value ? 'testnet' : 'mainnet';
    
    walletInProgress.value = WalletInfo(
      id: '', // Será gerado ao salvar
      name: walletNameController.text.trim(),
      mode: mode,
      network: network,
      addressType: BitcoinAddressType.nativeSegwit, // Padrão
    );
  }

  /// Valida se pode avançar da página 0
  bool canProceedFromPage0() {
    return walletNameController.text.trim().isNotEmpty;
  }

  /// Verifica se é configuração padrão (sem avisos)
  bool isStandardConfig() {
    return isOnChain.value && !isTestnetSelected.value;
  }

  // ============= MÉTODOS DA PAGE 1 =============
  
  /// Gera a seed phrase usando BDK
  Future<void> generateSeedPhrase() async {
   /*  try {
      final mnemonic = await Mnemonic.create(WordCount.words12);
      generatedMnemonic.value = mnemonic.asString();
      seedWords.value = generatedMnemonic.value.split(' ');
    } catch (e) {
      Get.snackbar('Erro', 'Falha ao gerar seed: $e');
    } */
  }

  /// Copia a seed para clipboard
  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: generatedMnemonic.value));
    Get.snackbar(
      'Copiado!',
      'Palavras copiadas para a área de transferência',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  /// Valida se pode avançar da página 1
  bool canProceedFromPage1() {
    return seedConfirmed.value;
  }

  // ============= MÉTODOS DA PAGE 2 =============
  
  /// Resumo da carteira para exibição
  String get walletSummary {
    final wallet = walletInProgress.value;
    if (wallet == null) return 'Nenhuma carteira em configuração';
    
    return '''
Nome: ${wallet.name}
Tipo: ${wallet.mode == WalletMode.onChainOnly ? 'On-chain' : 'Lightning'}
Rede: ${wallet.network == 'testnet' ? 'Testnet' : 'Mainnet'}
Endereço: ${wallet.addressType.toString().split('.').last}
''';
  }

  /// Salva a carteira final
  Future<void> finalizeWallet() async {
    try {
      final wallet = walletInProgress.value;
      if (wallet == null || generatedMnemonic.value.isEmpty) {
        throw Exception('Dados incompletos');
      }

      final mode = wallet.mode == WalletMode.onChainOnly 
          ? WalletMode.onChainOnly 
          : WalletMode.lightningEnabled;

      await _storage.saveNewWallet(
        name: wallet.name,
        mnemonic: generatedMnemonic.value,
        mode: mode,
        addressType: wallet.addressType,
        derivationPath: wallet.derivationPath,
      );

      Get.snackbar(
        'Sucesso!',
        'Carteira "${wallet.name}" criada com sucesso',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar('Erro', 'Falha ao salvar carteira: $e');
    }
  }

  // ============= CICLO DE VIDA =============
  
  @override
  void onInit() {
    super.onInit();
    
    // ✅ CORREÇÃO: Listener para atualizar isWalletNameFilled
    walletNameController.addListener(() {
      isWalletNameFilled.value = walletNameController.text.trim().isNotEmpty;
    });

    // Gerar seed automaticamente ao iniciar
    generateSeedPhrase();
  }

    @override
  void onClose() {
    walletNameController.dispose();
    super.onClose();
  }

}