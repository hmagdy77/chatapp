import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'core/constants/app_theme.dart';
import 'core/service/services.dart';
import 'firebase_options.dart';
import 'my_bindings.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';

import 'routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialService();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ],
    );
    return GetMaterialApp(
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('ar'),
      ],
      locale: const Locale('ar'), //controller.language,
      debugShowCheckedModeBanner: false,
      title: 'Right Business Solutions',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      // themeMode: ThemeController().getThemeMode,
      initialBinding: AppBindings(),
      getPages: getRoutes!,
    );
  }
}
