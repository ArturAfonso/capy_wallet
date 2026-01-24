import 'package:capy_wallet/app/data/theme/app_colors.dart';
import 'package:capy_wallet/app/modules/5-onchain_only/home_onchain/views/widgets/inicio_tab.dart';
import 'package:capy_wallet/app/modules/5-onchain_only/home_onchain/views/widgets/carteiras_tab.dart';
import 'package:capy_wallet/app/modules/5-onchain_only/home_onchain/views/widgets/enviar_tab.dart';
import 'package:capy_wallet/app/modules/5-onchain_only/home_onchain/views/widgets/receber_tab.dart';
import 'package:capy_wallet/app/modules/5-onchain_only/home_onchain/views/widgets/config_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_onchain_controller.dart';

class HomeOnchainView extends GetView<HomeOnchainController> {
  const HomeOnchainView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: const Color(0xFFF5F5F0),
      body: _buildCurrentTab(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    ));
  }
  
  /// Retorna a tab atual baseada no índice
  Widget _buildCurrentTab() {
    switch (controller.currentTabIndex.value) {
      case 0:
        return const InicioTab();
      case 1:
        return const CarteirasTab();
      case 2:
        return const EnviarTab();
      case 3:
        return const ReceberTab();
      case 4:
        return const ConfigTab();
      default:
        return const InicioTab();
    }
  }
  
  /// Bottom Navigation Bar
  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: controller.currentTabIndex.value,
        onTap: controller.changeTab,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.lightPrimary,
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        items:  [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 30,),
            activeIcon: Icon(Icons.home, size: 35,),
            label: 'Início',
          ),
          const BottomNavigationBarItem(
            
            icon: Icon(Icons.account_balance_wallet_outlined, size: 30,),
            activeIcon: Icon(Icons.account_balance_wallet, size: 35,),
            label: 'Carteiras',
          ),
          BottomNavigationBarItem(
            icon:  Transform.rotate(
                    angle: -45 * 3.1415927 / 180,child: const Icon(Icons.send_outlined, size: 30,)),
            activeIcon:  Transform.rotate(
                    angle: -45 * 3.1415927 / 180,child: const Icon(Icons.send, size: 35,)),
            label: 'Enviar',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_outlined, size: 30,),
            activeIcon: Icon(Icons.qr_code, size: 35,),
            label: 'Receber',
            
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined, size: 30,),
            activeIcon: Icon(Icons.settings, size: 35,),
            label: 'Config',
          ),
        ],
      ),
    );
  }
}
