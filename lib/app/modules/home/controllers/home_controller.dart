import 'package:get/get.dart';

class HomeController extends GetxController {
  // Índice da aba selecionada
  final currentIndex = 0.obs;
  
  // Dados da carteira principal
  final walletName = 'Capy'.obs;
  final network = 'Mainnet'.obs;
  final totalBalance = 0.15734567.obs;
  final balanceVisible = true.obs;
  
  // Lista de carteiras
  final wallets = <WalletItem>[
    WalletItem(
      name: 'Carteira Principal',
      balance: 0.15234567,
      address: 'bc1qxy2kgdyjrsqtzq2n0yrf2493p83kkf3hxw8lh',
      type: WalletType.onChain,
      network: 'mainnet',
    ),
    WalletItem(
      name: 'Lightning Diária',
      balance: 0.00500000,
      address: 'lnbc1pvjluezpp5...',
      type: WalletType.lightning,
      network: 'mainnet',
    ),
  ].obs;

  // Dados para tela de enviar
  final selectedWalletToSend = 'Selecione uma carteira'.obs;
  final sendAddress = ''.obs;
  final sendAmount = ''.obs;
  final sendUnit = 'sats'.obs;

  // Dados para tela de receber
  final selectedWalletToReceive = 'Carteira Principal'.obs;
  final receiveTab = 0.obs; // 0 = Endereço, 1 = Valor

  // Dados para configurações
  final isDarkMode = false.obs;
  final selectedCurrency = 'BRL'.obs;
  final balanceFormat = 'BTC'.obs;
  final isMainnet = true.obs;
  final isLightningEnabled = true.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }

  void toggleBalanceVisibility() {
    balanceVisible.value = !balanceVisible.value;
  }

  void goToSend() {
    currentIndex.value = 2;
  }

  void goToReceive() {
    currentIndex.value = 3;
  }

  void goToWallets() {
    currentIndex.value = 1;
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }

  void toggleLightning() {
    isLightningEnabled.value = !isLightningEnabled.value;
  }

  void toggleNetwork() {
    isMainnet.value = !isMainnet.value;
  }
}

enum WalletType { onChain, lightning }

class WalletItem {
  final String name;
  final double balance;
  final String address;
  final WalletType type;
  final String network;

  WalletItem({
    required this.name,
    required this.balance,
    required this.address,
    required this.type,
    required this.network,
  });
}