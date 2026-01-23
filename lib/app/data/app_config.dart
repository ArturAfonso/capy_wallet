

import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get appMode => dotenv.env['APP_MODE'] ?? 'development';
  static String get network => dotenv.env['NETWORK'] ?? 'testnet';
  static String get bitcoinApiUrl => dotenv.env['BITCOIN_API_URL'] ?? '';
  static String get lightningNodeUrl => dotenv.env['LIGHTNING_NODE_URL'] ?? '';

  static bool get isDevelopment => appMode == 'development';
  static bool get isProduction => appMode == 'production';
  static bool get isTestnet => network == 'testnet';
  static bool get isMainnet => network == 'mainnet';

  static Future<void> load({bool isDev = true}) async {
    final envFile = isDev ? '.env.dev' : '.env.prod';
    await dotenv.load(fileName: envFile);
  }

   /// Retorna true se deve usar testnet (considera ambiente e escolha do usuário)
  static bool shouldUseTestnet(bool userSelectedTestnet) {
    // Em desenvolvimento, sempre testnet
    if (isDevelopment) return true;
    
    // Em produção, respeita a escolha do usuário
    return userSelectedTestnet;
  }
 /// Retorna o derivation path baseado no tipo e rede
  static String getDerivationPath(String addressType, bool userSelectedTestnet) {
    final isTestnet = shouldUseTestnet(userSelectedTestnet);
    
    switch (addressType) {
      case 'native_segwit':
        return isTestnet ? "m/84'/1'/0'" : "m/84'/0'/0'"; // BIP-84
      case 'segwit_compatible':
        return isTestnet ? "m/49'/1'/0'" : "m/49'/0'/0'"; // BIP-49
      case 'legacy':
        return isTestnet ? "m/44'/1'/0'" : "m/44'/0'/0'"; // BIP-44
      default:
        return isTestnet ? "m/84'/1'/0'" : "m/84'/0'/0'"; // Padrão: Native SegWit
    }
  }

}