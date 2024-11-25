import 'package:pokemon_app_gravity/data/models/pokemon_card.dart';
import 'package:pokemon_app_gravity/domain/repositories/pokemon_repository.dart';

class GetPokemonCardsByQueryUseCase {
  final PokemonRepository repository;

  GetPokemonCardsByQueryUseCase(this.repository);

  Future<List<PokemonCard>> getPokemonCardsBySet(String setName) {
    return repository.getPokemonCardsBySet(setName);
  }

  Future<List<PokemonCard>> searchPokemonCards(String query) {
    return repository.searchPokemonCards(query);
  }
}
