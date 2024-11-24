import 'package:get/get.dart';
import 'package:pokemon_app_gravity/data/models/pokemon_card.dart';
import 'package:pokemon_app_gravity/domain/usecases/get_pokemon_cards.dart';

class PokemonController extends GetxController {
  final GetPokemonCardsUseCase getPokemonCardsUseCase;

  PokemonController(this.getPokemonCardsUseCase);

  var isLoading = false.obs;
  var pokemonCards = <PokemonCard>[].obs;
  var currentPage = 1.obs;
  var errorMessage = ''.obs; // Observable error message

  @override
  void onInit() {
    super.onInit();
    fetchPokemonCards();
  }

  Future<void> fetchPokemonCards({int page = 1}) async {
    try {
      isLoading.value = true; // Start loading

      final cards = await getPokemonCardsUseCase.execute(page: page);
      if (page == 1) {
        pokemonCards.value = cards;
      } else {
        pokemonCards.addAll(cards);
      }
      currentPage.value = page;
    } catch (e) {
      errorMessage.value = "Error: ${e.toString()}"; // Custom error message
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  Future<List<PokemonCard>> getPokemonCardsBySet(String query) async {
    try {
      return
          await getPokemonCardsUseCase.getPokemonCardsBySet(query);
    } catch (e) {
      errorMessage.value = "Error: ${e.toString()}"; // Custom error message
      return [];
    }
  }

  Future<List<PokemonCard>> searchPokemonCards(String query) async {
    return getPokemonCardsUseCase.searchPokemonCards(query);
  }
}
