import 'package:pokemon_app_gravity/core/common/app_strings.dart';
import 'package:pokemon_app_gravity/core/common/app_constants.dart';
import 'package:pokemon_app_gravity/core/network/dio_client.dart';
import '../models/pokemon_card.dart';

class PokemonRemoteDataSource {
  final DioClient dio;

  PokemonRemoteDataSource(this.dio);

  Future<List<PokemonCard>> fetchPokemonCards(int page, int pageSize) async {
    final response = await dio.get(
      AppConstants.apiBaseUrl,
      queryParameters: {'page': page, 'pageSize': pageSize},
    );

    if (response.statusCode == 200) {
      return (response.data['data'] as List)
          .map((item) => PokemonCard.fromJson(item))
          .toList();
    } else {
      throw Exception(AppStrings.errorLoadingData);
    }
  }

  Future<List<PokemonCard>> fetchPokemonCardsBySet(String setName) async {
    final response = await dio.get(AppConstants.apiBaseUrl,
        queryParameters: {'q': 'set.name:$setName'});

    if (response.statusCode == 200) {
      final List data = response.data['data'];
      return data.map((card) => PokemonCard.fromJson(card)).toList();
    } else {
      throw Exception(AppStrings.errorLoadingData);
    }
  }

  Future<List<PokemonCard>> searchPokemonCards(String query) async {
    final response = await dio.get(
      AppConstants.apiBaseUrl,
      queryParameters: {'q': 'set.name:$query'},
    );

    if (response.statusCode == 200) {
      return (response.data['data'] as List)
          .map((item) => PokemonCard.fromJson(item))
          .toList();
    } else {
      throw Exception(AppStrings.errorLoadingData);
    }
  }
}
