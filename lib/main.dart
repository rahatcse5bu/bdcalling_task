import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/APIs/api_helper.dart';
import 'app/APIs/api_helper_implementation.dart';
import 'app/APIs/auth_middleware/auth_middleware.dart';
import 'app/APIs/global-binding/global-binding.dart';
import 'app/common/themes/theme_controller.dart';
import 'app/constant/app_theme.dart';
import 'app/routes/app_pages.dart';
import 'app/storage/storage_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await AuthMiddleware.initialize(); // Pre-fetch token
  final isLoggedIn = await StorageHelper.hasToken(); // Check if token exists
  runApp(MainApp(isLoggedIn: isLoggedIn));

}

class MainApp extends StatelessWidget {
  final bool isLoggedIn;

  MainApp({required this.isLoggedIn});
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter GetX MVC',
        debugShowCheckedModeBanner: false,
        theme: themeController.currentTheme,
        darkTheme: ThemeData.dark(),
        themeMode: themeController.isDarkMode.value
            ? ThemeMode.dark
            : ThemeMode.light,
      initialRoute: isLoggedIn ? '/dashboard' : AppPages.initial,
      getPages: AppPages.routes,
      initialBinding: GlobalBinding(),
    );
  }
}
