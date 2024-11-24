class PokemonCard {
  final String id;
  final String name;
  final String imageUrl;
  final String type;
  final String rarity;
  final String set;
  final String artist;
  final List<String> attacks;
  final List<String> weaknesses;

  PokemonCard({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.type,
    required this.rarity,
    required this.set,
    required this.artist,
    required this.attacks,
    required this.weaknesses,
  });

  factory PokemonCard.fromJson(Map<String, dynamic> json) {
    return PokemonCard(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['images']['large'],
      type: json['types']?.join(', ') ?? 'N/A',
      rarity: json['rarity'] ?? '',
      set: json['set']['name'],
      artist: json['artist'] ?? '',
      attacks: json['attacks'] != null
          ? List<String>.from(json['attacks'].map((x) => x['name']))
          : [],
      weaknesses: json['weaknesses'] != null
          ? List<String>.from(json['weaknesses'].map((x) => x['type']))
          : [],
    );
  }
}
