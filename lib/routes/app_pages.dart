import 'package:get/get.dart';
import 'package:honest/modules/auth/auth_binding.dart';
import 'package:honest/modules/auth/auth_view.dart';
import 'package:honest/modules/base/base_binding.dart';
import 'package:honest/modules/base/base_view.dart';
import 'package:honest/modules/splash/splash_binding.dart';
import 'package:honest/modules/splash/splash_view.dart';
import 'package:honest/routes/app_routes.dart';

class AppPages {
  AppPages._();
  static const initial = Routes.splash;
  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.signIn,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.base,
      page: () => const BaseView(),
      binding: BaseBinding(),
    ),
  ];
}