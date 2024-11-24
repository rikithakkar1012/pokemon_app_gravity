import 'dart:async';

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

  // Observable list to store the search results
  var searchResults = <PokemonCard>[].obs;
  var isSearching = false.obs;

  Timer? _debounceTimer;
  bool isThrottling = false;
  final Duration _debounceDuration =
      const Duration(milliseconds: 500); // 500ms debounce
  final Duration _throttleDuration =
      const Duration(milliseconds: 300); // 300ms throttle

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
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  Future<List<PokemonCard>> getPokemonCardsBySet(String query) async {
    try {
      return await getPokemonCardsUseCase.getPokemonCardsBySet(query);
    } catch (e) {
      errorMessage.value = e.toString();
      return [];
    }
  }

  void searchPokemonCards(String query) async {
    try {
      isSearching.value = true;
      final cards = await getPokemonCardsUseCase.searchPokemonCards(query);
      searchResults.clear();
      searchResults.value = cards;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isSearching.value = false;
    }
  }

  // This function will handle the debounce logic
  void debounceSearch(String query) {
    // Cancel the existing debounce timer if any
    _debounceTimer?.cancel();

    if (query.length >= 3) {
      // Start a new debounce timer
      _debounceTimer = Timer(_debounceDuration, () {
        if (!isThrottling) {
          throttleSearch(query); // Trigger throttled search
        }
      });
    }
  }

  // Throttling logic to ensure search is triggered at a controlled rate
  void throttleSearch(String query) {
    isThrottling = true; // Start throttling
    searchPokemonCards(query); // Trigger the search
    Future.delayed(_throttleDuration, () {
      isThrottling = false; // Stop throttling after the throttle period
    });
  }
}
