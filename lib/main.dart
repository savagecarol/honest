import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:honest/core/themes/app_theme.dart';
import 'package:honest/routes/app_pages.dart';
import 'package:honest/routes/app_routes.dart';
import 'package:honest/services/auth_service.dart';
import 'package:honest/services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Get.put<AuthService>(AuthService(), permanent: true);
  Get.put<FirebaseService>(FirebaseService(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder:
          (context, child) => GetMaterialApp(
            title: 'honest',
            theme: AppTheme.theme,
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.splash,
            getPages: AppPages.routes,
          ),
    );
  }
}
