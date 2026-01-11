

enum WalletMode {
  onChainOnly,      // Modo "Cofre"
  lightningEnabled  // Modo "Dia a Dia"
}

class WalletInfo {
  final String id;
  final String name;
  final WalletMode mode; 
  final String network;

  WalletInfo({
    required this.id, 
    required this.name, 
    this.mode = WalletMode.onChainOnly, // Default
    this.network = 'testnet', // Default
  });

  Map<String, dynamic> toJson() => {
    'id': id, 
    'name': name,
    'mode': mode.toString(), // Salva "WalletMode.onChainOnly"
    'network': network,
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
    );
  }
}