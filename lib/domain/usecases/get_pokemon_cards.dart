import 'package:pokemon_app_gravity/core/common/app_constants.dart';
import 'package:pokemon_app_gravity/data/models/pokemon_card.dart';
import 'package:pokemon_app_gravity/domain/repositories/pokemon_repository.dart';

class GetPokemonCardsUseCase {
  final PokemonRepository repository;

  GetPokemonCardsUseCase(this.repository);

  Future<List<PokemonCard>> execute({
    int page = 1,
    int pageSize = AppConstants.pageSize,
  }) {
    return repository.fetchPokemonCards(page, pageSize);
  }

  Future<List<PokemonCard>> getPokemonCardsBySet(String setName) {
    return repository.getPokemonCardsBySet(setName);
  }

  Future<List<PokemonCard>> searchPokemonCards(String query) {
    return repository.searchPokemonCards(query);
  }
}
