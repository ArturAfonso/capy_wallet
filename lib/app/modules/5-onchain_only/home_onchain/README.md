# HomeOnchain - Documentação

## 📁 Estrutura

```
lib/app/modules/5-onchain_only/home_onchain/
├── controllers/
│   └── home_onchain_controller.dart  # Controller centralizado
├── bindings/
│   └── home_onchain_binding.dart
├── views/
│   ├── home_onchain_view.dart        # View principal com BottomNav
│   └── widgets/
│       ├── inicio_tab.dart           # Tab Início (Histórico/Detalhes)
│       ├── carteiras_tab.dart        # Tab Carteiras (Placeholder)
│       ├── enviar_tab.dart           # Tab Enviar Bitcoin
│       ├── receber_tab.dart          # Tab Receber Bitcoin
│       └── config_tab.dart           # Tab Configurações
```

## 🎯 Arquitetura

- **Padrão GetX**: Widgets stateless + Controller reativo centralizado
- **5 Tabs**: Início, Carteiras, Enviar, Receber, Config
- **Bottom Navigation Bar**: Navegação entre tabs
- **Estado Compartilhado**: Todas as tabs acessam o mesmo controller

## 🚀 Funcionalidades Implementadas

### 1️⃣ Tab Início
- ✅ Header com nome da carteira e rede
- ✅ Card de saldo com toggle de visibilidade
- ✅ Botões Enviar/Receber
- ✅ Toggle Histórico/Detalhes
- ✅ Lista de transações (mock)
- ✅ Detalhes da carteira

### 2️⃣ Tab Carteiras
- ⏳ Placeholder "Será implementado no futuro"

### 3️⃣ Tab Enviar
- ✅ Exibição do saldo disponível
- ✅ Campo de endereço com botões:
  - Colar da área de transferência
  - Escanear QR Code
- ✅ Campo de descrição opcional
- ✅ Campo de valor com:
  - Toggle BTC/R$
  - Conversão automática
  - Botão "Máximo"
- ✅ Botão Enviar (habilitado quando campos preenchidos)

### 4️⃣ Tab Receber
- ✅ QR Code gerado com endereço
- ✅ Exibição do endereço (clique para copiar)
- ✅ Seleção de endereço (dropdown no AppBar)
- ✅ Campo de quantia com toggle BTC/R$
- ✅ Campo de descrição opcional
- ✅ Botões:
  - Copiar endereço
  - Compartilhar QR Code

### 5️⃣ Tab Config
- ✅ Card informativo da carteira
- ✅ Card Lightning Network (se compatível)
- ✅ Seção Exibição:
  - Toggle tema (Dark/Light)
  - Seleção de moeda (BRL/USD/EUR)
  - Formato de saldo (sats/BTC)
- ✅ Seção Rede:
  - Toggle Main/Test
- ✅ Seção Segurança:
  - Alterar PIN
  - Backup das Seeds
- ✅ Zona de Perigo:
  - Apagar carteira
  - Sair/Bloquear

## 🔄 Fluxo de Login

```dart
LoginController → verifica WalletMode →
  - onChainOnly → Routes.HOME_ONCHAIN
  - lightningEnabled → Routes.HOME_LIGHTNING
```

## 📦 Variáveis Observáveis (Controller)

```dart
// Navegação
final currentTabIndex = 0.obs;
final inicioSubTab = 0.obs;

// Saldo
final balance = 15500000.obs;
final pendingBalance = 500000.obs;
final balanceVisible = true.obs;

// Transações
final transactions = <Map>[...].obs;

// Enviar
final sendAddress = ''.obs;
final sendAmount = ''.obs;
final sendUnit = 'BTC'.obs;

// Receber
final selectedAddressIndex = 0.obs;
final receiveAmount = ''.obs;
final receiveUnit = 'BTC'.obs;
final addresses = <String>[...].obs;

// Config
final isDarkMode = false.obs;
final selectedCurrency = 'BRL'.obs;
final balanceFormat = 'sats'.obs;
final isMainnet = false.obs;
```

## 🎨 Cores e Estilos

- Background: `#F5F5F0`
- Saldo Card: `#FFF8E1`
- Botão Primário: `AppColors.lightPrimary` (laranja)
- Botão Secundário: `AppColors.lightSecondary` (verde)
- Cards: `Colors.white`

## 🔧 Próximos Passos (TODOs)

1. **Integração BDK**:
   - [ ] Carregar saldo real
   - [ ] Carregar transações reais
   - [ ] Gerar endereços reais
   - [ ] Enviar transações
   - [ ] Assinar transações

2. **Funcionalidades Pendentes**:
   - [ ] Scanner QR Code (enviar)
   - [ ] Clipboard (colar/copiar)
   - [ ] Share (compartilhar QR)
   - [ ] Navegação para detalhes da transação
   - [ ] Alterar PIN
   - [ ] Backup de Seeds
   - [ ] Tema Dark Mode

3. **Tab Carteiras**:
   - [ ] Implementar listagem de carteiras On-Chain
   - [ ] Adicionar nova carteira
   - [ ] Gerenciar carteiras

## 📝 Notas Importantes

- **Wallet Info**: Recebida via `Get.arguments` do login
- **Mock Data**: Atualmente usando dados fictícios
- **Reatividade**: Todas as atualizações via `.obs` e `Obx()`
- **Sem setState**: 100% GetX pattern
- **Widgets Stateless**: Todas as tabs são `GetView<HomeOnchainController>`

## 🎯 Exemplo de Uso

```dart
// No LoginController (após verificação de PIN)
if (selectedWallet.value!.mode == WalletMode.onChainOnly) {
  Get.offAllNamed(Routes.HOME_ONCHAIN, arguments: selectedWallet.value);
}

// No HomeOnchainController (onInit)
wallet = Get.arguments as WalletInfo;
```
