import 'package:get/get.dart';
import 'package:honest/modules/auth/auth_binding.dart';
import 'package:honest/modules/auth/auth_view.dart';
import 'package:honest/modules/home/home_binding.dart';
import 'package:honest/modules/home/home_view.dart';
import 'package:honest/modules/profile/profile_binding.dart';
import 'package:honest/modules/profile/profile_view.dart';
import 'package:honest/modules/splash/splash_binding.dart';
import 'package:honest/modules/splash/splash_view.dart';
import 'package:honest/routes/app_routes.dart';

class AppPages {
  AppPages._();

  static const inital = Routes.splash;

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
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),

  ];
}