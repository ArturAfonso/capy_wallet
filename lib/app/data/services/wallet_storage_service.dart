//(Gerencia CRUD de carteiras)

import 'dart:convert';
import 'package:capy_wallet/app/data/app_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';
import '../models/wallet_info.dart'; // Importe o modelo acima
import 'package:get/get.dart';
import 'dart:math'; // Para gerar o Salt
import 'package:crypto/crypto.dart'; // Para SHA-256


class WalletStorageService extends GetxService {
  final _secureStorage = const FlutterSecureStorage();
  final _uuid = const Uuid();
  static const _walletsKey = 'wallets_metadata';

  // Inicialização do Service (Padrão GetX)
  Future<WalletStorageService> init() async {
    // Você pode fazer inicializações específicas por ambiente aqui
    print('🔧 Wallet Service iniciado em modo: ${AppConfig.network}');
    return this;
  }

  /// 1. Salva Nova Carteira (Agora pede o MODO)
  Future<WalletInfo> saveNewWallet({
    required String name, 
    required String mnemonic, 
    required WalletMode mode, // <--- Obrigatório definir o modo na criação
    // Novos parâmetros opcionais (se não passar, assume padrão)
    BitcoinAddressType addressType = BitcoinAddressType.nativeSegwit,
    String? derivationPath,
  }) async {
    final id = _uuid.v4();
    
    // Cria o objeto com o modo escolhido
    final newWallet = WalletInfo(
      id: id, 
      name: name,
       mode: mode,
       network: AppConfig.network,
       addressType: addressType,    
      derivationPath: derivationPath 
       );
    
    // Salva a seed (segredo)
    await _secureStorage.write(key: 'mnemonic_$id', value: mnemonic);
    
    // Salva os metadados na lista pública
    final list = await getWallets();
    list.add(newWallet);
    await _saveWalletsList(list);
    
    return newWallet;
  }

  /// Recupera Seed
  Future<String?> getMnemonic(String walletId) async {
    return await _secureStorage.read(key: 'mnemonic_$walletId');
  }

  /// Lista apenas as carteiras DA REDE ATUAL
  Future<List<WalletInfo>> getWallets() async {
    final String? data = await _secureStorage.read(key: _walletsKey);
    if (data == null) return [];
    
    try {
      final List<dynamic> jsonList = jsonDecode(data);
      final allWallets = jsonList.map((e) => WalletInfo.fromJson(e)).toList();
      
      // FILTRO DE SEGURANÇA:
      // Só retorna carteiras que pertencem à rede que estamos rodando agora (mainnet ou testnet)
      return allWallets.where((w) => w.network == AppConfig.network).toList();
      
    } catch (e) {
      print("Erro ao ler carteiras: $e");
      return [];
    }
  }

  // Método auxiliar privado
  Future<void> _saveWalletsList(List<WalletInfo> list) async {
    final String data = jsonEncode(list.map((e) => e.toJson()).toList());
    await _secureStorage.write(key: _walletsKey, value: data);
  }

  // Upgrade de Carteira (Caso o usuário queira ativar Lightning depois)
  Future<void> upgradeWalletMode(String walletId) async {
    final list = await getWallets();
    final index = list.indexWhere((w) => w.id == walletId);
    
    if (index != -1) {
      final old = list[index];
      // Cria uma cópia atualizada
      final upgraded = WalletInfo(id: old.id, name: old.name, mode: WalletMode.lightningEnabled);
      
      list[index] = upgraded;
      await _saveWalletsList(list);
    }
  }

  // ... (Delete e DeleteAll iguais ao anterior) ...
  Future<void> deleteWallet(String id) async { /* código igual */ }

  // =========================================================
  //  SEGURANÇA DO PIN (Hash + Salt)
  // =========================================================

  /// Define/Atualiza o PIN de uma carteira
  /// NÃO salvamos o PIN. Salvamos: SHA256(PIN + Salt)
  Future<void> setWalletPin(String walletId, String rawPin) async {
    final list = await getWallets();
    final index = list.indexWhere((w) => w.id == walletId);

    if (index != -1) {
      // 1. Gera um Salt aleatório (32 chars)
      final salt = _generateRandomSalt();
      
      // 2. Calcula o Hash
      final hash = _hashPin(rawPin, salt);

      // 3. Atualiza a carteira
      final updatedWallet = list[index].copyWith(
        pinHash: hash,
        pinSalt: salt,
      );

      list[index] = updatedWallet;
      await _saveWalletsList(list);
    }
  }

  /// Verifica se o PIN digitado bate com o guardado
  Future<bool> verifyWalletPin(String walletId, String inputPin) async {
    final list = await getWallets();
    final wallet = list.firstWhereOrNull((w) => w.id == walletId);

    if (wallet == null || wallet.pinHash == null || wallet.pinSalt == null) {
      return false; // Carteira não existe ou não tem PIN configurado
    }

    // Recalcula o hash usando o Salt guardado e o PIN que o usuário acabou de digitar
    final inputHash = _hashPin(inputPin, wallet.pinSalt!);

    // Compara os Hashes
    return inputHash == wallet.pinHash;
  }

  /// Verifica se uma carteira possui PIN configurado
  Future<bool> hasPinConfigured(String walletId) async {
    final list = await getWallets();
    final wallet = list.firstWhereOrNull((w) => w.id == walletId);
    return wallet?.pinHash != null;
  }

  // --- HELPERS CRIPTOGRÁFICOS ---

  String _hashPin(String pin, String salt) {
    // Combina PIN + Salt
    final bytes = utf8.encode(pin + salt);
    // Aplica SHA-256
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  String _generateRandomSalt() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }
}