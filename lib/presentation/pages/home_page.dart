import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemon_app_gravity/core/common/app_strings.dart';
import 'package:pokemon_app_gravity/core/common/widgets/loader.dart';
import 'package:pokemon_app_gravity/core/utils/show_snackbar.dart';
import 'package:pokemon_app_gravity/presentation/widgets/pokemon_search_delegate.dart';
import '../controllers/pokemon_controller.dart';
import '../widgets/pokemon_card_widget.dart';

class HomePage extends StatelessWidget {
  final PokemonController controller = Get.find<PokemonController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: Colors.white,
            onPressed: () {
              showSearch(context: context, delegate: PokemonSearchDelegate());
            },
          ),
        ],
      ),
      body: Obx(
        () {
          if (controller.errorMessage.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showSnackBar(context, controller.errorMessage.value);
            });
          }

          if (controller.isLoading.value && controller.pokemonCards.isEmpty) {
            // Show the loading indicator if loading is true and there are no pokemon cards
            return const Loader();
          } else {
            // Display GridView with Pokémon cards
            return GridView.builder(
              controller: ScrollController()
                ..addListener(() {
                  if (controller.isLoading.value) return;
                  if (controller.pokemonCards.length ==
                      controller.currentPage.value * 10) {
                    // Fetch more cards if the end of the current list is reached
                    controller.fetchPokemonCards(
                        page: controller.currentPage.value + 1);
                  }
                }),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                //for web make crossAxisCount 4 by adding a condition of: if (constraints.maxWidth >= 1200)
                crossAxisSpacing: 3,
                mainAxisSpacing: 3,
                // width / height: fixed for *all* items
                childAspectRatio: 0.66,
              ),
              itemCount: controller.pokemonCards.length + 1,
              itemBuilder: (context, index) {
                if (index == controller.pokemonCards.length) {
                  // Show the loading spinner at the bottom when more cards are being loaded
                  if (controller.pokemonCards.isNotEmpty) {
                    return const Loader();
                  } else {
                    return const SizedBox();
                  }
                }

                final card = controller.pokemonCards[index];
                return PokemonCardWidget(card: card);
              },
            );
          }
        },
      ),
    );
  }
}
