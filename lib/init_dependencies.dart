import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pokemon_app_gravity/core/network/connection_checker.dart';
import 'package:pokemon_app_gravity/core/network/dio_client.dart';
import 'package:pokemon_app_gravity/data/datasources/pokemon_remote_datasource.dart';
import 'package:pokemon_app_gravity/data/repositories/pokemon_repository_impl.dart';
import 'package:pokemon_app_gravity/domain/repositories/pokemon_repository.dart';
import 'package:pokemon_app_gravity/domain/usecases/get_pokemon_cards_by_page.dart';
import 'package:pokemon_app_gravity/domain/usecases/get_pokemon_cards_by_query.dart';
import 'package:pokemon_app_gravity/presentation/controllers/pokemon_controller.dart';

final GetIt getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Register Dio instance for making HTTP requests
  final dio = Dio();
  final dioClient = DioClient(dio);
  getIt.registerLazySingleton(() => dioClient);

  // Register NetworkInfo (or InternetConnection) with GetIt
  getIt.registerFactory(() => InternetConnection());
  getIt
      .registerFactory<ConnectionChecker>(() => ConnectionCheckerImpl(getIt()));

  _initPokemon();
}

void _initPokemon() {
  // Register the remote data source
  getIt.registerFactory<PokemonRemoteDataSource>(
      () => PokemonRemoteDataSource(getIt()));

  // Register the PokemonRepository implementation
  getIt.registerFactory<PokemonRepository>(() => PokemonRepositoryImpl(
        getIt<PokemonRemoteDataSource>(),
        getIt<ConnectionChecker>(),
      ));

  // Register the use case
  getIt.registerLazySingleton(() => GetPokemonCardsByPageUseCase(getIt()));

  // Register the use case
  getIt.registerLazySingleton(() => GetPokemonCardsByQueryUseCase(getIt()));

  // Register the PokemonController using GetX's dependency injection
  Get.put(PokemonController(
    getIt<GetPokemonCardsByPageUseCase>(),
    getIt<GetPokemonCardsByQueryUseCase>(),
  )); // Register with Get.put() to make it available globally
}
