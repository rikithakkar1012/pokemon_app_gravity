import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pokemon_app_gravity/core/common/widgets/loader.dart';
import 'package:pokemon_app_gravity/core/theme/app_palette.dart';
import 'package:pokemon_app_gravity/core/theme/text_theme.dart';
import 'package:pokemon_app_gravity/data/models/pokemon_card.dart';
import 'package:pokemon_app_gravity/presentation/pages/pokemon_detail_page.dart';

class PokemonCardWidget extends StatelessWidget {
  final PokemonCard card;

  const PokemonCardWidget({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // Navigate to the PokemonDetailPage with animation
          Navigator.of(context).push(_createRoute(card));
        },
        child: Hero(
          tag: 'pokemon-${card.id}',
          child: Card(
              elevation: 5,
              shape: Border.all(color: Colors.transparent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Using SizedBox to control the size of the loader
                  CachedNetworkImage(
                    imageUrl: card.imageUrl,
                    placeholder: (context, url) =>  const Loader(),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      size: 60,
                    ),
                    fit: BoxFit.cover, // Ensure image fits and fills the area
                  ),
                  Text(
                    card.name,
                    style: customTextTheme.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              )),
        ));
  }

  Route _createRoute(PokemonCard card) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          PokemonDetailPage(card: card),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Start position of the new page
        const end =
            Offset.zero; // End position of the new page (final position)
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        // Slide transition for the page
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
