import 'package:capy_wallet/app/data/services/wallet_storage_service.dart';
import 'package:capy_wallet/app/data/theme/app_theme.dart';
import 'package:capy_wallet/app/data/theme/theme_controller.dart';
import 'package:capy_wallet/app/data/app_config.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Carrega o ambiente (true = dev, false = prod)
  const isDev = bool.fromEnvironment('DEV', defaultValue: true);
  await AppConfig.load(isDev: isDev);
  // Inicializa o Storage Service como GLOBAL
  await Get.putAsync(() => WalletStorageService().init());
  Get.put(ThemeController());

  runApp(
    GetMaterialApp(
      title: "CapyWallet",
      initialRoute: AppPages.INITIAL,
       theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: AppConfig.isDevelopment,
      getPages: AppPages.routes,
    ),
  );
}
