import 'package:capy_wallet/app/data/theme/app_colors.dart';
import 'package:capy_wallet/app/data/theme/app_text_styles.dart';
import 'package:capy_wallet/app/modules/5-onchain_only/home_onchain/controllers/home_onchain_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TransactionDetailView extends GetView<HomeOnchainController> {
  const TransactionDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    // Recebe a transação passada como argumento
    final tx = Get.arguments as Map<String, dynamic>;
    final isReceived = tx['type'] == 'received';

    return WillPopScope(
      onWillPop: () async {
        // Garante que ao voltar, vai para a tab Início (índice 0)
        controller.changeTab(0);
        Get.back();
        return false;
      },
      child: Scaffold(
       
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () {
              controller.changeTab(0);
              Get.back();
            },
          ),
          title: Text(
            'Detalhes da Transação',
            style: AppTextStyles.headingMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Card superior com resumo da transação
                _buildSummaryCard(tx, isReceived, context),

                const SizedBox(height: 16),

                // Card com detalhes completos
                _buildDetailsCard(tx, isReceived),

                const SizedBox(height: 16),

                // Botão "Ver no Explorador"
                _buildExplorerButton(tx),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Card superior com resumo visual
  Widget _buildSummaryCard(Map<String, dynamic> tx, bool isReceived, BuildContext context) {
    return Container(
      width: Get.size.width,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
       /*  border: Border.all(
                    color: AppColors.lightCardForeground.withOpacity(0.2),
                    width: 1,
                  ), */
        boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.07),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
      ),
      child: Column(
        children: [
          // Ícone QR centralizado
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFE8E4D9),
              borderRadius: BorderRadius.circular(40),
            ),
            child: const Icon(
              Icons.qr_code_2,
              size: 40,
              color: Colors.brown,
            ),
          ),

          const SizedBox(height: 16),

          // Tipo de transação
          Text(
            isReceived ? 'Bitcoin Recebido' : 'Bitcoin Enviado',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.lightForeground.withOpacity(0.6),
              fontSize: 16
            ),
          ),

          const SizedBox(height: 8),

          // Valor
          Text(
            '${isReceived ? '+' : '-'}${(tx['amount'] / 100).toStringAsFixed(3).replaceAll('.', '.')} sats',
            style: AppTextStyles.displayLarge.copyWith(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: isReceived ? AppColors.lightSecondary : AppColors.lightForeground,
            ),
          ),

          const SizedBox(height: 8),

          // Status
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(

              color: _getStatusColor(tx['confirmations']).withOpacity(0.1),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              _getStatusText(tx['confirmations']),
              style: AppTextStyles.bodyMedium.copyWith(
                color: _getStatusColor(tx['confirmations']),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 5),

          // Data
          Text(
            tx['date'],
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.lightForeground.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  /// Card com detalhes completos
  Widget _buildDetailsCard(Map<String, dynamic> tx, bool isReceived) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detalhes da Transação',
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          // ID da Transação
          _buildDetailRow(
            icon: Icons.tag,
            label: 'ID da Transação',
            value: tx['txid'],
            copyable: true,
          ),

           const Divider(height: 32, color: Colors.transparent,),

          // Confirmações
          _buildDetailRow(
            icon: Icons.access_time,
            label: 'Confirmações',
            value: '${tx['confirmations']} confirmações',
            copyable: false,
          ),

         const Divider(height: 32, color: Colors.transparent,),

          // Data de Confirmação
          _buildDetailRow(
            icon: Icons.calendar_today,
            label: 'Data de Confirmação',
            value: tx['date'],
            copyable: false,
          ),

        const Divider(height: 32, color: Colors.transparent,),

          // Carteira
          _buildDetailRow(
            icon: Icons.account_balance_wallet,
            label: 'Carteira',
            value: controller.wallet.name,
            copyable: false,
          ),

          if (tx['description'] != null && tx['description'].toString().isNotEmpty) ...[
           Divider(height: 32, color: AppColors.lightForeground.withOpacity(0.1),),

            // Descrição
            _buildDetailRow(
              icon: Icons.description,
              label: 'Descrição',
              value: tx['description'],
              copyable: false,
            ),
          ],
        ],
      ),
    );
  }

  /// Linha de detalhe com ícone, label e valor
  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    required bool copyable,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Ícone
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F0),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            icon,
            size: 20,
            color: Colors.brown.shade700,
          ),
        ),

        const SizedBox(width: 12),

        // Label e Valor
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 18,
                  color: AppColors.lightForeground.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        // Botões de ação (copiar/abrir)
        if (copyable) ...[
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.copy, size: 20),
            onPressed: () => _copyToClipboard(value),
            color: AppColors.lightPrimary,
          ),
         
        ],
      ],
    );
  }

  /// Botão "Ver no Explorador"
  Widget _buildExplorerButton(Map<String, dynamic> tx) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
         boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ], 
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: ElevatedButton.icon(
        
        onPressed: () => _openInExplorer(tx['txid']),
        icon: const Icon(Icons.open_in_new, size: 20),
        label: const Text('Ver no Explorador'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE8E4D9),
          foregroundColor: Colors.brown.shade700,
          padding: const EdgeInsets.symmetric(vertical: 16),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
    );
  }

  /// Obtém a cor do status baseado nas confirmações
  Color _getStatusColor(int confirmations) {
    if (confirmations >= 6) {
      return AppColors.lightSecondary;
    } else if (confirmations >= 1) {
      return AppColors.lightPrimary;
    } else {
      return Colors.grey;
    }
  }

  /// Obtém o texto do status baseado nas confirmações
  String _getStatusText(int confirmations) {
    if (confirmations >= 6) {
      return 'Confirmada';
    } else if (confirmations >= 1) {
      return 'Confirmando...';
    } else {
      return 'Não Confirmada';
    }
  }

  /// Copia texto para área de transferência
  Future<void> _copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    Get.snackbar(
      'Copiado',
      'Copiado para área de transferência',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black87,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
    );
  }

  /// Abre transação no explorador blockchain
  Future<void> _openInExplorer(String txid) async {
    // TODO: Abrir URL do explorador
    // Por exemplo: https://mempool.space/tx/{txid}
    Get.snackbar(
      'Explorador',
      'Abrindo explorador blockchain...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.lightPrimary,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
    );
  }
}
