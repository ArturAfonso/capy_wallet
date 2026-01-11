//(Gerencia CRUD de carteiras)

import 'dart:convert';
import 'package:capy_wallet/app_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';
import '../models/wallet_info.dart'; // Importe o modelo acima
import 'package:get/get.dart';


class WalletStorageService extends GetxService {
  final _storage = const FlutterSecureStorage();
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
    required WalletMode mode // <--- Obrigatório definir o modo na criação
  }) async {
    final id = _uuid.v4();
    
    // Cria o objeto com o modo escolhido
    final newWallet = WalletInfo(
      id: id, 
      name: name,
       mode: mode,
       network: AppConfig.network,
       );
    
    // Salva a seed (segredo)
    await _storage.write(key: 'mnemonic_$id', value: mnemonic);
    
    // Salva os metadados na lista pública
    final list = await getWallets();
    list.add(newWallet);
    await _saveWalletsList(list);
    
    return newWallet;
  }

  /// Recupera Seed
  Future<String?> getMnemonic(String walletId) async {
    return await _storage.read(key: 'mnemonic_$walletId');
  }

  /// Lista apenas as carteiras DA REDE ATUAL
  Future<List<WalletInfo>> getWallets() async {
    final String? data = await _storage.read(key: _walletsKey);
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
    await _storage.write(key: _walletsKey, value: data);
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
}