import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pokemon_app_gravity/core/common/app_strings.dart';
import 'package:pokemon_app_gravity/core/theme/app_palette.dart';
import 'package:pokemon_app_gravity/core/theme/theme.dart';
import 'package:pokemon_app_gravity/init_dependencies.dart';
import 'presentation/pages/home_page.dart';

Future<void> main() async {
  // Lock to portrait mode
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  WidgetsFlutterBinding
      .ensureInitialized(); // As a precautionary measure. Do this always

  await initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false, // Disable the debug banner
      theme: AppTheme.lightThemeMode
          .copyWith(scaffoldBackgroundColor: AppPalette.backgroundColor),
      home: HomePage(), // Start the app with the HomePage
    );
  }
}
