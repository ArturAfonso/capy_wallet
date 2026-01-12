

enum WalletMode {
  onChainOnly,      // Modo "Cofre"
  lightningEnabled  // Modo "Dia a Dia"
}

//  Tipos de endereço suportados pelo BDK
enum BitcoinAddressType {
  nativeSegwit, // bc1... (mainnet) ou tb1... - O Padrão LDK
  segwit,       // 3... (mainnet) ou 2... (testnet)    - Compatível Bip49
  legacy        // 1... (mainnet) ou m/n... (testnet)...    - Antigo Bip44
}

class WalletInfo {
  final String id;
  final String name;
  final WalletMode mode; 
  final String network;

  // NOVOS CAMPOS DE METADADOS
  final BitcoinAddressType addressType;
  final String? derivationPath; // Se null, assumimos o padrão daquele tipo

  WalletInfo({
    required this.id, 
    required this.name, 
    this.mode = WalletMode.onChainOnly, // Default
    this.network = 'testnet', // Default
    this.addressType = BitcoinAddressType.nativeSegwit, // Default moderno
    this.derivationPath,
  });


  // --- O CÉREBRO DA OPERAÇÃO ---
  // Esse getter define se o botão "Ativar Lightning" vai aparecer na tela Home
  bool get canUpgradeToLightning {
    // Regra 1: Tem que ser Native Segwit (LDK só gosta desse)
    if (addressType != BitcoinAddressType.nativeSegwit) return false;

    // Regra 2: Não pode ter caminho de derivação exótico manual
    // Se for null (padrão) ou igual aos padrões conhecidos, é compatível.
    if (derivationPath != null && derivationPath!.isNotEmpty) {
       // Aqui você pode validar se é o padrão m/84'/0'/0' ou m/84'/1'/0'
       // Se o usuário digitou algo maluco, retornamos false.
       // Para simplificar: Se o usuário customizou o path, bloqueamos o Lightning automático.
       return false; 
    }

    return true;
  }

  Map<String, dynamic> toJson() => {
    'id': id, 
    'name': name,
    'mode': mode.toString(), // Salva "WalletMode.onChainOnly"
    'network': network,
    'addressType': addressType.toString(),
    'derivationPath': derivationPath,
  };

  factory WalletInfo.fromJson(Map<String, dynamic> json) {
    return WalletInfo(
      id: json['id'],
      name: json['name'],
      // Lógica para converter String -> Enum com segurança
      mode: json['mode'] != null 
          ? WalletMode.values.firstWhere(
              (e) => e.toString() == json['mode'], 
              orElse: () => WalletMode.onChainOnly
            )
          : WalletMode.onChainOnly,
      network: json['network'] ?? 'testnet',
      // Recupera o Tipo
      addressType: json['addressType'] != null
          ? BitcoinAddressType.values.firstWhere((e) => e.toString() == json['addressType'], orElse: () => BitcoinAddressType.nativeSegwit)
          : BitcoinAddressType.nativeSegwit,
      
      // Recupera o Path
      derivationPath: json['derivationPath'],
    );
  }
}