import 'package:capy_wallet/app/data/app_config.dart';
import 'package:capy_wallet/app/data/models/wallet_creation_draft.dart';
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

  // ============= DRAFT OBJECT (ESTADO CENTRALIZADO) =============
  final draft = WalletCreationDraft().obs;

  // ============= TEXT CONTROLLERS =============
  final walletNameController = TextEditingController();
  final extensionPhraseController = TextEditingController();

  // ============= UI STATE =============
  RxBool isAdvancedOptionsExpanded = false.obs;
  RxBool obscure = true.obs; // Para blur da seed na Page 1

  // ============= HELPERS =============

  /// Converte string de addressType para o enum BitcoinAddressType
  static BitcoinAddressType _stringToAddressType(String addressType) {
    switch (addressType) {
      case 'native_segwit':
        return BitcoinAddressType.nativeSegwit;
      case 'segwit_compatible':
      case 'segwit':
        return BitcoinAddressType.segwit;
      case 'legacy':
        return BitcoinAddressType.legacy;
      default:
        return BitcoinAddressType.nativeSegwit; // Padrão seguro
    }
  }

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

  /// Lista de palavras da seed para exibição em grid
  List<String> get seedWords => 
    draft.value.generatedMnemonic.isEmpty 
      ? [] 
      : draft.value.generatedMnemonic.split(' ');

  // ============= VALIDAÇÃO DE AVANÇO (BOTÃO NEXT) =============
  
  /// Verifica se pode avançar para a próxima página
  bool get canProceed {
    switch (actualPage.value) {
      case 0: // Página de configuração
        return draft.value.name.trim().isNotEmpty;
      
      case 1: // Página de seed
        return draft.value.isSeedBackedUp;
      
      case 2: // Página de resumo (último passo antes de finalizar)
        return true; // Sempre pode finalizar se chegou aqui
      
      default:
        return false;
    }
  }

  // ============= MÉTODOS DA PAGE 0 =============
  
  /// Atualiza o modo da carteira (On-chain ou Lightning)
  void setWalletMode(bool isOnChain) {
    draft.value = draft.value.copyWith(
      isLightningMode: !isOnChain,
    );
  }

  /// Atualiza a rede (Testnet ou Mainnet)
  void setNetwork(bool isTestnet) {
    draft.value = draft.value.copyWith(
      isTestnet: isTestnet,
      derivationPath: AppConfig.getDerivationPath(
        draft.value.addressType,
        isTestnet,
      ),
    );
  }

  /// Atualiza o tipo de endereço e recalcula derivation path
  void setAddressType(String addressType) {
    draft.value = draft.value.copyWith(
      addressType: addressType,
      derivationPath: AppConfig.getDerivationPath(
        addressType,
        draft.value.isTestnet,
      ),
    );
  }

  /// Atualiza o tamanho da seed (12 ou 24 palavras)
  void setSeedLength(int length) {
    draft.value = draft.value.copyWith(seedLength: length);
  }

  /// Atualiza derivation path customizado (se usuário digitar manualmente)
  void setCustomDerivationPath(String path) {
    draft.value = draft.value.copyWith(derivationPath: path);
  }

  /// Verifica se é configuração padrão (sem avisos necessários)
  bool get isStandardConfig {
    return !draft.value.isLightningMode && !draft.value.isTestnet;
  }

        /// Imprime todas as informações atuais do draft no console
        void printDraftInfo() {
          final d = draft.value;
          print('--- Wallet Draft Info ---');
          print('Nome: ${d.name}');
          print('Modo Lightning: ${d.isLightningMode}');
          print('Testnet: ${d.isTestnet}');
          print('Seed Length: ${d.seedLength}');
          print('Frase de extensão habilitada: ${d.extensionPhraseEnabled}');
          print('Frase de extensão: ${d.passphrase}');
          print('Tipo de endereço: ${d.addressType}');
          print('Derivation Path: ${d.derivationPath}');
          print('Mnemonic gerado: ${d.generatedMnemonic}');
          print('Seed backup confirmada: ${d.isSeedBackedUp}');
          print('-------------------------');
        }
  // ============= MÉTODOS DA PAGE 1 =============
  
  /// Gera a seed phrase usando BDK
  Future<void> generateSeedPhrase() async {
    /* TODO: Implementar com BDK
    try {
      final wordCount = draft.value.seedLength == 12 
          ? WordCount.words12 
          : WordCount.words24;
      
      final mnemonic = await Mnemonic.create(wordCount);
      draft.value = draft.value.copyWith(
        generatedMnemonic: mnemonic.asString(),
      );
    } catch (e) {
      Get.snackbar('Erro', 'Falha ao gerar seed: $e');
    }
    */
    
    // Mock para desenvolvimento
    final words = List.generate(
      draft.value.seedLength,
      (i) => 'palavra${i + 1}',
    ).join(' ');
    
    draft.value = draft.value.copyWith(generatedMnemonic: words);
  }

  /// Copia a seed para clipboard
  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: draft.value.generatedMnemonic));
    Get.snackbar(
      'Copiado!',
      'Palavras copiadas para a área de transferência',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  /// Marca que o usuário confirmou ter feito backup da seed
  void toggleSeedBackup(bool? value) {
    draft.value = draft.value.copyWith(
      isSeedBackedUp: value ?? false,
    );
  }

  // ============= MÉTODOS DA PAGE 2 =============
  
  /// Resumo da carteira para exibição
  String get walletSummary {
    final mode = draft.value.finalMode;
    final modeText = mode == WalletMode.onChainOnly ? 'On-chain' : 'Lightning';
    final networkText = draft.value.isTestnet ? 'Testnet' : 'Mainnet';
    
    return '''
Nome: ${draft.value.name}
Tipo: $modeText
Rede: $networkText
Endereço: ${draft.value.addressType}
Derivação: ${draft.value.derivationPath}
''';
  }

  /// Salva a carteira final
  Future<WalletInfo?> finalizeWallet() async {
    try {
      if (draft.value.name.isEmpty || draft.value.generatedMnemonic.isEmpty) {
        throw Exception('Dados incompletos');
      }

      // 1. Salva e recupera o objeto com ID gerado
      final newWallet = await _storage.saveNewWallet(
        name: draft.value.name,
        mnemonic: draft.value.generatedMnemonic,
        mode: draft.value.finalMode,
        addressType: _stringToAddressType(draft.value.addressType),
        derivationPath: draft.value.derivationPath,
      );

      Get.snackbar('Sucesso!', 'Carteira criada!');
      
      // 2. Retorna a carteira para quem chamou
      return newWallet; 
      
    } catch (e) {
      Get.snackbar('Erro', 'Falha ao salvar carteira: $e');
      return null;
    }
  }

  // ============= CICLO DE VIDA =============
  
  @override
  void onInit() {
    super.onInit();
    
    // Listeners para atualizar draft automaticamente
    walletNameController.addListener(() {
      draft.value = draft.value.copyWith(
        name: walletNameController.text.trim(),
      );
    });

    extensionPhraseController.addListener(() {
      draft.value = draft.value.copyWith(
        passphrase: extensionPhraseController.text,
      );
    });

    // Gerar seed automaticamente ao iniciar
    generateSeedPhrase();
    
    // Definir derivation path inicial
    draft.value = draft.value.copyWith(
      derivationPath: AppConfig.getDerivationPath(
        draft.value.addressType,
        draft.value.isTestnet,
      ),
    );
  }

  @override
  void onClose() {
    walletNameController.dispose();
    extensionPhraseController.dispose();
    super.onClose();
  }
}