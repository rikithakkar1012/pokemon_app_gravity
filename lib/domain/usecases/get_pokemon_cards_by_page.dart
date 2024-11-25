import 'package:pokemon_app_gravity/core/common/app_constants.dart';
import 'package:pokemon_app_gravity/data/models/pokemon_card.dart';
import 'package:pokemon_app_gravity/domain/repositories/pokemon_repository.dart';

class GetPokemonCardsByPageUseCase {
  final PokemonRepository repository;

  GetPokemonCardsByPageUseCase(this.repository);

  Future<List<PokemonCard>> getPokemonCardsByPage({
    int page = 1,
    int pageSize = AppConstants.pageSize,
  }) {
    return repository.getPokemonCardsByPage(page, pageSize);
  }
}
