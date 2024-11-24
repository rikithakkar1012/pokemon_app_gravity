import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_app_gravity/core/theme/text_theme.dart';
import 'package:pokemon_app_gravity/data/models/pokemon_card.dart';

class PokemonDetailPage extends StatelessWidget {
  final PokemonCard card;

  const PokemonDetailPage({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(card.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          // Make the back button white
          onPressed: () {
            Navigator.of(context).pop(); // Go back to the previous screen
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'pokemon-${card.id}', // Same tag as in HomePage
              child: CachedNetworkImage(imageUrl: card.imageUrl),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Type: ${card.type}',
                        style: customTextTheme.bodyLarge),
                    Text('Set: ${card.set}', style: customTextTheme.bodyLarge),
                    Text('Artist: ${card.artist}',
                        style: customTextTheme.bodyLarge),
                    Text('Rarity: ${card.rarity}',
                        style: customTextTheme.bodyLarge),
                    const SizedBox(height: 10),
                    Text('Attacks:', style: customTextTheme.bodyLarge),
                    ...card.attacks.map((attack) =>
                        Text(attack, style: customTextTheme.bodyMedium)),
                    const SizedBox(height: 10),
                    Text('Weaknesses:', style: customTextTheme.bodyLarge),
                    ...card.weaknesses.map((weakness) =>
                        Text(weakness, style: customTextTheme.bodyMedium)),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
