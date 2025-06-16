class LeagueModel {
  final int index;
  final String name;
  final String id;
  final String country;
  final int score;
  final bool isOpened;
  final bool isNew;

  LeagueModel({
    required this.index,
    required this.name,
    required this.id,
    required this.country,
    required this.score,
    required this.isOpened,
    required this.isNew,
  });

  factory LeagueModel.fromJson(Map<String, dynamic> json) {
    return LeagueModel(
      index: json['index'],
      name: json['name'],
      id: json['id'],
      country: json['country'],
      score: json['score'],
      isOpened: json['isOpened'],
      isNew: json['isNew'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'name': name,
      'id': id,
      'country': country,
      'score': score,
      'isOpened': isOpened,
      'isNew': isNew,
    };
  }

  LeagueModel copyWith({
    int? index,
    String? name,
    String? id,
    String? country,
    int? score,
    bool? isOpened,
    bool? isNew,
  }) {
    return LeagueModel(
      index: index ?? this.index,
      name: name ?? this.name,
      id: id ?? this.id,
      country: country ?? this.country,
      score: score ?? this.score,
      isOpened: isOpened ?? this.isOpened,
      isNew: isNew ?? this.isNew,
    );
  }
}