import 'package:get/get.dart';

import '../modules/1-splash/bindings/splash_binding.dart';
import '../modules/1-splash/views/splash_view.dart';
import '../modules/4-onboarding_screen/bindings/onboarding_screen_binding.dart';
import '../modules/4-onboarding_screen/views/fork_start_screen.dart';
import '../modules/4-onboarding_screen/views/onboarding_screen_view.dart';
import '../modules/4-onboarding_screen/views/pre_onboarding_screen.dart';
import '../modules/3-auth/pin/bindings/pin_binding.dart';
import '../modules/3-auth/pin/views/pin_view.dart';
import '../modules/3-auth/recoverWallet/bindings/recover_wallet_binding.dart';
import '../modules/3-auth/recoverWallet/views/recover_wallet_view.dart';
import '../modules/5-onchain_only/home_onchain/bindings/home_onchain_binding.dart';
import '../modules/5-onchain_only/home_onchain/views/home_onchain_view.dart';
import '../modules/6-lightning_onchain/home_lightning/bindings/home_lightning_binding.dart';
import '../modules/6-lightning_onchain/home_lightning/views/home_lightning_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/2-login/bindings/login_binding.dart';
import '../modules/2-login/views/login_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;
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
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.HOME_ONCHAIN,
      page: () => const HomeOnchainView(),
      binding: HomeOnchainBinding(),
    ),
    GetPage(
      name: _Paths.HOME_LIGHTNING,
      page: () => const HomeLightningView(),
      binding: HomeLightningBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
  ];
}
