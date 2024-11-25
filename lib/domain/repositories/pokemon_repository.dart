import 'package:pokemon_app_gravity/data/models/pokemon_card.dart';

abstract class PokemonRepository {
  Future<List<PokemonCard>> getPokemonCardsByPage(int page, int pageSize);

  Future<List<PokemonCard>> searchPokemonCards(String query);

  Future<List<PokemonCard>> getPokemonCardsBySet(String setName);
}
