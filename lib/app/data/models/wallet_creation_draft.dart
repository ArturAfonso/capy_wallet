import 'wallet_info.dart';

/// Classe simples (não reativa) que armazena temporariamente
/// os dados do formulário de criação de carteira durante o fluxo de onboarding.
/// 
/// Esta classe segue o padrão "Draft Object" (DTO - Data Transfer Object),
/// centralizando o estado do formulário em um único lugar.
class WalletCreationDraft {
  String name;
  bool isLightningMode;
  bool isTestnet;
  int seedLength;
  String passphrase;
  String addressType;
  String? derivationPath;
  String generatedMnemonic;
  bool isSeedBackedUp;
  final bool extensionPhraseEnabled;

  WalletCreationDraft({
    this.name = '',
    this.isLightningMode = false,
    this.isTestnet = false,
    this.seedLength = 12,
    this.passphrase = '',
    this.addressType = 'native_segwit',
    this.derivationPath,
    this.generatedMnemonic = '',
    this.isSeedBackedUp = false,
    this.extensionPhraseEnabled = false,
  });

  /// Retorna o modo final da carteira baseado na escolha do usuário
  WalletMode get finalMode {
    return isLightningMode 
        ? WalletMode.lightningEnabled 
        : WalletMode.onChainOnly;
  }

  /// Converte o addressType string para o Enum BitcoinAddressType
  BitcoinAddressType get addressTypeEnum {
    switch (addressType) {
      case 'native_segwit':
        return BitcoinAddressType.nativeSegwit;
      case 'segwit_compatible':
        return BitcoinAddressType.segwit;
      case 'legacy':
        return BitcoinAddressType.legacy;
      default:
        return BitcoinAddressType.nativeSegwit;
    }
  }

  /// Cria uma cópia do draft com valores atualizados
  WalletCreationDraft copyWith({
    String? name,
    bool? isLightningMode,
    bool? isTestnet,
    int? seedLength,
    String? passphrase,
    String? addressType,
    String? derivationPath,
    String? generatedMnemonic,
    bool? isSeedBackedUp,
    bool? extensionPhraseEnabled,
  }) {
    return WalletCreationDraft(
      name: name ?? this.name,
      isLightningMode: isLightningMode ?? this.isLightningMode,
      isTestnet: isTestnet ?? this.isTestnet,
      seedLength: seedLength ?? this.seedLength,
      passphrase: passphrase ?? this.passphrase,
      addressType: addressType ?? this.addressType,
      derivationPath: derivationPath ?? this.derivationPath,
      generatedMnemonic: generatedMnemonic ?? this.generatedMnemonic,
      isSeedBackedUp: isSeedBackedUp ?? this.isSeedBackedUp,
      extensionPhraseEnabled: extensionPhraseEnabled ?? this.extensionPhraseEnabled,
    );
  }

  @override
  String toString() {
    return 'WalletCreationDraft(name: $name, isLightningMode: $isLightningMode, '
        'isTestnet: $isTestnet, seedLength: $seedLength, addressType: $addressType)';
  }
}
