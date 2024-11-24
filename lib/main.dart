import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pokemon_app_gravity/core/common/app_strings.dart';
import 'package:pokemon_app_gravity/core/network/connection_checker.dart';
import 'package:pokemon_app_gravity/core/network/dio_client.dart';
import 'package:pokemon_app_gravity/core/theme/app_palette.dart';
import 'package:pokemon_app_gravity/core/theme/text_theme.dart';
import 'package:pokemon_app_gravity/core/theme/theme.dart';
import 'package:pokemon_app_gravity/domain/repositories/pokemon_repository.dart';
import 'data/datasources/pokemon_remote_datasource.dart';
import 'data/repositories/pokemon_repository.dart';
import 'domain/usecases/get_pokemon_cards.dart';
import 'presentation/controllers/pokemon_controller.dart';
import 'presentation/pages/home_page.dart';

void main() {
  // Lock to portrait mode
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  setup();
  runApp(const MyApp());
}

final GetIt getIt = GetIt.instance;

void setup() {
  // Register Dio instance for making HTTP requests
  final dio = Dio();
  final dioClient = DioClient(dio);
  getIt.registerLazySingleton(() => dioClient);

  // Register NetworkInfo (or InternetConnection) with GetIt
  getIt.registerFactory(() => InternetConnection());
  getIt
      .registerFactory<ConnectionChecker>(() => ConnectionCheckerImpl(getIt()));

  // Register the remote data source
  getIt.registerFactory<PokemonRemoteDataSource>(() => PokemonRemoteDataSource(getIt()));

  // Register the PokemonRepository implementation
  getIt.registerFactory<PokemonRepository>(() =>
      PokemonRepositoryImpl(
          getIt<PokemonRemoteDataSource>(), getIt<ConnectionChecker>()));

  // Register the use case
  getIt.registerLazySingleton(() => GetPokemonCardsUseCase(getIt()));

  // Register the PokemonController using GetX's dependency injection
  Get.put(PokemonController(
      getIt())); // Register with Get.put() to make it available globally
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
