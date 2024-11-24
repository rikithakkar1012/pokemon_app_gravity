import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemon_app_gravity/core/common/app_strings.dart';
import 'package:pokemon_app_gravity/core/common/widgets/loader.dart';
import 'package:pokemon_app_gravity/core/theme/text_theme.dart';
import 'package:pokemon_app_gravity/core/utils/show_snackbar.dart';
import 'package:pokemon_app_gravity/presentation/controllers/pokemon_controller.dart';
import 'package:pokemon_app_gravity/presentation/widgets/pokemon_card_widget.dart';

class PokemonSearchDelegate extends SearchDelegate {
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
        if (controller.errorMessage.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showSnackBar(context, controller.errorMessage.value);
          });
        }

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
    // 1. Debounce: Cancel previous debounce timer
    controller.debounceSearch(query);

    // 2. Throttle: Prevent search until throttle duration has passed
    if (controller.isThrottling) {
      return const Loader();
    }

    return Obx(() {
      // Show any error message
      if (controller.errorMessage.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showSnackBar(context, controller.errorMessage.value);
        });
      }

      // Show loading if still fetching
      if (controller.isSearching.value) {
        return const Loader();
      }

      // Show no suggestions message if no data or empty search
      if (controller.searchResults.isEmpty) {
        return Center(
          child: Text(AppStrings.noSuggestion,
              style: customTextTheme.displaySmall),
        );
      }

      final cardsList = controller.searchResults;

      // Used Set to avoid duplication in values (by set name)
      Set<String> uniqueSets = {};
      for (var singleCard in cardsList) {
        uniqueSets.add(singleCard.set);
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
    });
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
}
