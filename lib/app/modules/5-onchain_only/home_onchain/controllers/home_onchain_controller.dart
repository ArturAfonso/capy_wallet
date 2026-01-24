import 'package:capy_wallet/app/data/models/wallet_info.dart';
import 'package:get/get.dart';

class HomeOnchainController extends GetxController {
  // ============= DADOS DA CARTEIRA =============
  late final WalletInfo wallet; // Recebida do login
  
  // ============= NAVEGAÇÃO DAS TABS =============
  final currentTabIndex = 0.obs;
  
  // ============= TAB INÍCIO - HISTÓRICO/DETALHES =============
  final inicioSubTab = 0.obs; // 0 = Histórico, 1 = Detalhes
  final balance = 15500000.obs; // Saldo em sats (mock)
  final pendingBalance = 500000.obs; // Saldo pendente em sats
  final balanceVisible = true.obs;
  
  // Histórico de transações (mock)
  final transactions = <Map<String, dynamic>>[
    {
      'type': 'received',
      'amount': 5000000,
      'date': '12/01/2024',
      'confirmations': 2342455345342345657,
      'txid': '3abc123def456789...',
      'description': 'Depósito',
    },
  ].obs;
  
  // ============= TAB ENVIAR =============
  final sendAddress = ''.obs;
  final sendAmount = ''.obs;
  final sendDescription = ''.obs;
  final sendUnit = 'BTC'.obs; // 'BTC' ou 'R$'
  final btcToFiatRate = 350000.0.obs; // Taxa de conversão BTC->BRL (mock)
  
  // ============= TAB RECEBER =============
  final selectedAddressIndex = 0.obs;
  final receiveAmount = ''.obs;
  final receiveDescription = ''.obs;
  final receiveUnit = 'BTC'.obs; // 'BTC' ou 'R$'
  
  // Lista de endereços (mock)
  final addresses = <String>[
    'bc1q71w86orhtm9yoj5foxyenj0',
    'bc1q1ses1f6dc6007d591exdeq2',
    'bc1q1zhk20p6o97at5owmbmvkn3',
    'bc1q0d6kzxjux13f9yw83gr5oc4',
    'bc1q40ug58fcdqylb8jnzr0htq5',
  ].obs;
  
  // ============= TAB CONFIG =============
  final isDarkMode = false.obs;
  final selectedCurrency = 'BRL'.obs;
  final balanceFormat = 'sats'.obs; // 'sats' ou 'BTC'
  final isMainnet = false.obs; // true = Main, false = Test
  
  // ============= MÉTODOS =============
  
  @override
  void onInit() {
    super.onInit();
    // Recebe a carteira do login
    wallet = Get.arguments as WalletInfo;
    loadWalletData();
  }
  
  /// Carrega dados da carteira
  Future<void> loadWalletData() async {
    // TODO: Carregar saldo, transações, endereços do BDK
    // Por enquanto usando mocks
  }
  
  /// Muda de tab principal
  void changeTab(int index) {
    currentTabIndex.value = index;
  }
  
  /// Muda sub-tab da tela Início
  void changeInicioSubTab(int index) {
    inicioSubTab.value = index;
  }
  
  /// Toggle visibilidade do saldo
  void toggleBalanceVisibility() {
    balanceVisible.value = !balanceVisible.value;
  }
  
  /// Navega para detalhes da transação
  void goToTransactionDetails(Map<String, dynamic> transaction) {
    Get.toNamed('/transaction-details', arguments: transaction);
  }
  
  /// ========== TAB ENVIAR ==========
  
  /// Calcula o valor equivalente em outra moeda
  String getConvertedSendAmount() {
    if (sendAmount.value.isEmpty) return '≈ 0';
    
    try {
      final amount = double.parse(sendAmount.value.replaceAll(',', '.'));
      
      if (sendUnit.value == 'BTC') {
        // BTC -> R$
        final fiatValue = amount * btcToFiatRate.value;
        return '≈ R\$ ${fiatValue.toStringAsFixed(2)}';
      } else {
        // R$ -> BTC
        final btcValue = amount / btcToFiatRate.value;
        return '≈ ${btcValue.toStringAsFixed(8)} BTC';
      }
    } catch (e) {
      return '≈ 0';
    }
  }
  
  /// Toggle unidade de envio
  void toggleSendUnit() {
    sendUnit.value = sendUnit.value == 'BTC' ? 'R\$' : 'BTC';
  }
  
  /// Cola endereço da área de transferência
  Future<void> pasteAddress() async {
    // TODO: Implementar clipboard
    sendAddress.value = 'bc1...endereço_colado';
  }
  
  /// Abre câmera para escanear QR Code
  Future<void> scanQRCode() async {
    // TODO: Implementar scanner QR
    Get.snackbar('QR Scanner', 'Funcionalidade em desenvolvimento');
  }
  
  /// Envia Bitcoin
  Future<void> sendBitcoin() async {
    // TODO: Implementar envio usando BDK
    Get.snackbar('Enviando', 'Transação sendo processada...');
  }
  
  /// ========== TAB RECEBER ==========
  
  /// Obtém endereço atual selecionado
  String get currentAddress => addresses[selectedAddressIndex.value];
  
  /// Muda endereço selecionado
  void selectAddress(int index) {
    selectedAddressIndex.value = index;
  }
  
  /// Toggle unidade de recebimento
  void toggleReceiveUnit() {
    receiveUnit.value = receiveUnit.value == 'BTC' ? 'R\$' : 'BTC';
  }
  
  /// Copia endereço para área de transferência
  Future<void> copyAddress() async {
    // TODO: Implementar clipboard
    Get.snackbar('Copiado', 'Endereço copiado para área de transferência');
  }
  
  /// Compartilha QR Code
  Future<void> shareQRCode() async {
    // TODO: Implementar share
    Get.snackbar('Compartilhar', 'Funcionalidade em desenvolvimento');
  }
  
  /// ========== TAB CONFIG ==========
  
  /// Toggle tema
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    // TODO: Aplicar tema
  }
  
  /// Altera moeda fiat
  void changeCurrency(String currency) {
    selectedCurrency.value = currency;
  }
  
  /// Altera formato de saldo
  void changeBalanceFormat(String format) {
    balanceFormat.value = format;
  }
  
  /// Toggle rede (Main/Test)
  void toggleNetwork() {
    isMainnet.value = !isMainnet.value;
  }
  
  /// Ativar Lightning Network
  Future<void> activateLightning() async {
    if (wallet.canUpgradeToLightning) {
      // TODO: Implementar upgrade para Lightning
      Get.snackbar('Lightning', 'Ativando Lightning Network...');
    } else {
      Get.snackbar(
        'Não Compatível',
        'Esta carteira não é compatível com Lightning Network',
      );
    }
  }
  
  /// Navegar para alterar PIN
  void goToChangePin() {
    Get.toNamed('/change-pin');
  }
  
  /// Navegar para backup de seeds
  void goToBackupSeeds() {
    Get.toNamed('/backup-seeds', arguments: wallet);
  }
  
  /// Apagar carteira
  Future<void> deleteWallet() async {
    // TODO: Confirmar e deletar
    Get.snackbar('Deletar', 'Funcionalidade em desenvolvimento');
  }
  
  /// Sair/Bloquear
  void logout() {
    Get.offAllNamed('/login');
  }
  
  @override
  void onClose() {
    // Limpar recursos se necessário
    super.onClose();
  }
}
