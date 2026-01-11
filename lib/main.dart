import 'package:capy_wallet/app/data/theme/app_theme.dart';
import 'package:capy_wallet/app/data/theme/theme_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  Get.put(ThemeController());
  runApp(
    GetMaterialApp(
      title: "CapyWallet",
      initialRoute: AppPages.HOME,
       theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
         debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
    ),
  );
}
