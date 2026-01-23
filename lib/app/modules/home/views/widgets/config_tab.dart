import 'package:capy_wallet/app/data/theme/app_colors.dart';
import 'package:capy_wallet/app/data/theme/app_text_styles.dart';
import 'package:capy_wallet/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfigTab extends GetView<HomeController> {
  const ConfigTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => controller.changeTab(0),
        ),
        title: Text(
          'Configurações',
          style: AppTextStyles.headingMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Card de apresentação
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.lightCard,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/Gemini_Generated_Image_smwc3rsmwc3rsmwc.png',
                    height: 60,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Capy Wallet',
                          style: AppTextStyles.headingMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Sua carteira Bitcoin tranquila',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.lightForeground.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Exibição
            _SectionTitle(title: 'Exibição'),
            const SizedBox(height: 12),
            _SettingsCard(
              children: [
                Obx(() => _SettingsTile(
                      icon: Icons.brightness_6_outlined,
                      title: 'Tema',
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.wb_sunny_outlined,
                              color: !controller.isDarkMode.value
                                  ? AppColors.lightPrimary
                                  : Colors.grey),
                          const SizedBox(width: 8),
                          Switch(
                            value: controller.isDarkMode.value,
                            onChanged: (value) => controller.toggleTheme(),
                            activeColor: AppColors.lightPrimary,
                          ),
                          const SizedBox(width: 8),
                          Icon(Icons.nightlight_outlined,
                              color: controller.isDarkMode.value
                                  ? AppColors.lightPrimary
                                  : Colors.grey),
                        ],
                      ),
                    )),
                const Divider(),
                Obx(() => _SettingsTile(
                      icon: Icons.attach_money,
                      title: 'Moeda Fiat',
                      trailing: DropdownButton<String>(
                        value: controller.selectedCurrency.value,
                        underline: const SizedBox(),
                        items: const [
                          DropdownMenuItem(value: 'BRL', child: Text('BRL')),
                          DropdownMenuItem(value: 'USD', child: Text('USD')),
                          DropdownMenuItem(value: 'EUR', child: Text('EUR')),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            controller.selectedCurrency.value = value;
                          }
                        },
                      ),
                    )),
                const Divider(),
                Obx(() => _SettingsTile(
                      icon: Icons.phone_android,
                      title: 'Formato de Saldo',
                      trailing: DropdownButton<String>(
                        value: controller.balanceFormat.value,
                        underline: const SizedBox(),
                        items: const [
                          DropdownMenuItem(value: 'BTC', child: Text('BTC')),
                          DropdownMenuItem(value: 'SATS', child: Text('SATS')),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            controller.balanceFormat.value = value;
                          }
                        },
                      ),
                    )),
              ],
            ),
            const SizedBox(height: 24),
            // Rede
            _SectionTitle(title: 'Rede'),
            const SizedBox(height: 12),
            _SettingsCard(
              children: [
                Obx(() => _SettingsTile(
                      icon: Icons.link,
                      title: 'Rede Bitcoin',
                      subtitle: 'Bitcoin real',
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            controller.isMainnet.value ? 'Main' : 'Test',
                            style: TextStyle(
                              color: controller.isMainnet.value
                                  ? AppColors.lightPrimary
                                  : Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Switch(
                            value: !controller.isMainnet.value,
                            onChanged: (value) => controller.toggleNetwork(),
                            activeColor: Colors.orange,
                          ),
                        ],
                      ),
                    )),
                const Divider(),
                Obx(() => _SettingsTile(
                      icon: Icons.flash_on,
                      title: 'Lightning Network',
                      subtitle: 'Pagamentos instantâneos',
                      trailing: Switch(
                        value: controller.isLightningEnabled.value,
                        onChanged: (value) => controller.toggleLightning(),
                        activeColor: AppColors.lightPrimary,
                      ),
                    )),
              ],
            ),
            const SizedBox(height: 24),
            // Segurança
            _SectionTitle(title: 'Segurança'),
            const SizedBox(height: 12),
            _SettingsCard(
              children: [
                _SettingsTile(
                  icon: Icons.key_outlined,
                  title: 'Alterar PIN',
                  subtitle: 'Proteja seu acesso',
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // Navegar para alterar PIN
                  },
                ),
                const Divider(),
                _SettingsTile(
                  icon: Icons.shield_outlined,
                  title: 'Backup das Seeds',
                  subtitle: 'Visualize suas palavras-chave',
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // Navegar para visualizar seeds
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Zona de Perigo
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Zona de Perigo',
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _SettingsCard(
                    children: [
                      _SettingsTile(
                        icon: Icons.delete_outline,
                        title: 'Apagar Todas as Carteiras',
                        subtitle: 'Esta ação não pode ser desfeita',
                        titleColor: Colors.red,
                        trailing: const Icon(Icons.chevron_right, color: Colors.red),
                        onTap: () {
                          // Confirmar exclusão
                        },
                      ),
                      const Divider(),
                      _SettingsTile(
                        icon: Icons.exit_to_app,
                        title: 'Sair',
                        subtitle: 'Bloquear a carteira',
                        titleColor: Colors.red,
                        trailing: const Icon(Icons.chevron_right, color: Colors.red),
                        onTap: () {
                          // Sair
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Versão
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/Gemini_Generated_Image_smwc3rsmwc3rsmwc.png',
                    height: 40,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Capy Wallet v1.0.0',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.lightForeground.withOpacity(0.7),
                    ),
                  ),
                  Text(
                    '100% Não-custodial • Feito com 💚',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.lightForeground.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.headingMedium.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;

  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightBorder),
      ),
      child: Column(children: children),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? titleColor;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: titleColor),
      title: Text(
        title,
        style: AppTextStyles.bodyLarge.copyWith(
          fontWeight: FontWeight.bold,
          color: titleColor,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.lightForeground.withOpacity(0.6),
              ),
            )
          : null,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
