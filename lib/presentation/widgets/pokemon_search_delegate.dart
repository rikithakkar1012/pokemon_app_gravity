import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemon_app_gravity/core/common/app_strings.dart';
import 'package:pokemon_app_gravity/core/common/widgets/loader.dart';
import 'package:pokemon_app_gravity/core/theme/text_theme.dart';
import 'package:pokemon_app_gravity/presentation/controllers/pokemon_controller.dart';
import 'package:pokemon_app_gravity/presentation/widgets/pokemon_card_widget.dart';

class PokemonSearchDelegate extends SearchDelegate {
  final _debounceDuration =
      const Duration(milliseconds: 500); // Adjust debounce interval
  Timer? _debounceTimer;
  bool _isThrottling = false; // Variable to handle throttling
  final int _throttleDuration = 1000; // Throttle interval (1 second)

  final PokemonController controller = Get.find<PokemonController>();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      // Clear button to reset the search query
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Reset the query when the clear icon is pressed
        },
      ),
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    // Perform the search and show the results
    return FutureBuilder(
      future: controller.getPokemonCardsBySet(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
              child: Text(
            AppStrings.noResultsFound,
            style: customTextTheme.displaySmall,
          ));
        }

        final cards = snapshot.data!;

        debugPrint("ItemCount: ${cards.length}");

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            //for web make crossAxisCount 4 by adding a condition of: if (constraints.maxWidth >= 1200)
            crossAxisSpacing: 3,
            mainAxisSpacing: 3,
            // width / height: fixed for *all* items
            childAspectRatio: 0.66,
          ),
          itemCount: cards.length,
          itemBuilder: (context, index) {
            return PokemonCardWidget(card: cards[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show search suggestions (optional)

    // // 1. Debounce: Cancel previous debounce timer
    // if (_debounceTimer?.isActive ?? false) {
    //   _debounceTimer?.cancel();
    // }
    //
    // // 2. Throttle: Prevent search until throttle duration has passed
    // if (_isThrottling) {
    //   return const Center(
    //       child: CircularProgressIndicator()); // Show loading if throttled
    // }
    //
    // //3. Start new debounce timer
    // if (query.length >= 3) {
    //   _debounceTimer = Timer(_debounceDuration, () {
    //     if (!_isThrottling) {
    //       print("Search for query: $query");
    //       _throttleSearch(query);
    //     }
    //   });
    // }

    return FutureBuilder(
      future: controller.searchPokemonCards(query),
      // You can modify this to show filtered suggestions
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
              child: Text(
            AppStrings.noSuggestion,
            style: customTextTheme.displaySmall,
          ));
        }

        final cardsList = snapshot.data!;

        // Used Set to avoid duplication in values
        // Create a Set to hold unique set names or identifiers.
        Set<String> uniqueSets = {};

        // Extract unique set values from all the cards
        for (var singleCard in cardsList) {
          uniqueSets.add(
              singleCard.set); // Assuming `card.set` is a string or identifier
        }

        return ListView.builder(
          itemCount: uniqueSets.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(uniqueSets.elementAt(index)),
              onTap: () {
                query = uniqueSets
                    .elementAt(index); // Set query to the selected suggestion
                showResults(context); // Show results after tapping a suggestion

                controller.getPokemonCardsBySet(query);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // The leading widget is the back button when the search is active
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context,
            null); // Close the search bar when the back button is pressed
      },
    );
  }

  // Throttling logic to ensure the search query is triggered at a controlled rate
  void _throttleSearch(String query) {
    _isThrottling = true; // Start throttling
    controller.searchPokemonCards(query); // Trigger the search
    // Stop throttling after the throttle duration
    Future.delayed(Duration(milliseconds: _throttleDuration), () {
      _isThrottling = false; // Allow the next search after throttle period
    });
  }
}
