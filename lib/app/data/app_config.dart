

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
}