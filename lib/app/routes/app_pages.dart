import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/onboarding_screen/bindings/onboarding_screen_binding.dart';
import '../modules/onboarding_screen/views/fork_start_screen.dart';
import '../modules/onboarding_screen/views/onboarding_screen_view.dart';
import '../modules/onboarding_screen/views/pre_onboarding_screen.dart';
import '../modules/pin/bindings/pin_binding.dart';
import '../modules/pin/views/pin_view.dart';
import '../modules/recoverWallet/bindings/recover_wallet_binding.dart';
import '../modules/recoverWallet/views/recover_wallet_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.PREONBOARDING_SCREEN;
  static const HOME = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PREONBOARDING_SCREEN,
      page: () => const PreOnboardingScreenView(),
      binding: OnboardingScreenBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING_SCREEN,
      page: () => const OnboardingScreenView(),
      binding: OnboardingScreenBinding(),
    ),
    GetPage(
      name: _Paths.FORKSTART_SCREEN,
      page: () => const ForkStartScreen(),
      binding: OnboardingScreenBinding(),
    ),
    GetPage(
      name: _Paths.RECOVER_WALLET,
      page: () => const RecoverWalletView(),
      binding: RecoverWalletBinding(),
    ),
    GetPage(
      name: _Paths.PIN,
      page: () => const PinView(),
      binding: PinBinding(),
    ),
  ];
}
