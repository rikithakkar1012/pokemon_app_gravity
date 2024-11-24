import 'package:pokemon_app_gravity/core/common/app_strings.dart';
import 'package:pokemon_app_gravity/core/common/app_constants.dart';
import 'package:pokemon_app_gravity/core/network/connection_checker.dart';
import 'package:pokemon_app_gravity/data/datasources/pokemon_remote_datasource.dart';
import 'package:pokemon_app_gravity/domain/repositories/pokemon_repository.dart';

import '../models/pokemon_card.dart';

class PokemonRepositoryImpl extends PokemonRepository {
  final PokemonRemoteDataSource apiService;
  final ConnectionChecker connectionChecker;

  PokemonRepositoryImpl(this.apiService, this.connectionChecker);

  @override
  Future<List<PokemonCard>> fetchPokemonCards(int page, int pageSize) async {
    if (await connectionChecker.isConnected) {
      // If connected to the internet, make the API call
      try {
        return await apiService.fetchPokemonCards(page, pageSize);
      } catch (e) {
        throw Exception("Error fetching data: $e");
      }
    } else {
      // If no internet, throw a custom error or return cached data
      throw Exception(AppStrings.networkError);
    }
  }

  @override
  Future<List<PokemonCard>> getPokemonCardsBySet(String setName) async {
    if (await connectionChecker.isConnected) {
      // If connected to the internet, make the API call
      try {
        return apiService.fetchPokemonCardsBySet(Uri.encodeComponent(setName));
      } catch (e) {
        throw Exception("Error fetching data: $e");
      }
    } else {
      // If no internet, throw a custom error or return cached data
      throw Exception(AppStrings.networkError);
    }
  }

  @override
  Future<List<PokemonCard>> searchPokemonCards(String query) async {
    if (await connectionChecker.isConnected) {
      // If connected to the internet, make the API call
      try {
        return apiService.searchPokemonCards(Uri.encodeComponent(query));
      } catch (e) {
        throw Exception("Error fetching data: $e");
      }
    } else {
      // If no internet, throw a custom error or return cached data
      throw Exception(AppStrings.networkError);
    }
  }
}
