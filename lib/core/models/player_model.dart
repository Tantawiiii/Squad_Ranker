class Player {
  final String id;
  final String name;
  final int marketValue;
  final String? position;
  final String? number;
  final String? imageUrl;

  Player({
    required this.id,
    required this.name,
    required this.marketValue,
    this.position,
    this.number,
    this.imageUrl,
  });

  factory Player.fromShortInfoJson(Map<String, dynamic> json, int marketValue) {
    return Player(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? 'Unknown Player',
      marketValue: marketValue,
      position: json['positions']?['first']?['shortName'] ?? 'N/A',
      number: json['shirtNumber']?.toString() ?? '?',
      imageUrl: json['image'],
    );
  }
}