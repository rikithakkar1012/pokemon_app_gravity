class PokemonCard {
  final String name;
  final String type;
  final String rarity;
  final String artist;
  final String imageUrl;
  final List<String> attacks;
  final List<String> weaknesses;
  final String set;

  PokemonCard({
    required this.name,
    required this.type,
    required this.rarity,
    required this.artist,
    required this.imageUrl,
    required this.attacks,
    required this.weaknesses,
    required this.set,
  });

  factory PokemonCard.fromJson(Map<String, dynamic> json) {
    return PokemonCard(
      name: json['name'],
      type: json['types'].join(', '),
      rarity: json['rarity'] ?? '',
      artist: json['artist'] ?? 'Unknown',
      imageUrl: json['images']['large'],
      attacks: (json['attacks'] as List)
          .map((attack) => attack['name'] as String)
          .toList(),
      weaknesses: (json['weaknesses'] as List)
          .map((weakness) => weakness['type'] as String)
          .toList(),
      set: json['set']['name'],
    );
  }
}
