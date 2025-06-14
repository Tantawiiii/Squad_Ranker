class PlayerShortInfo {
  final String id;
  final String name;
  final String? image;
  final String? imageLarge;
  final String? imageSource;
  final String? shirtNumber;
  final int? age;
  final String? dateOfBirth;
  final String? heroImage;
  final bool isGoalkeeper;
  final Position? firstPosition;
  final Position? secondPosition;
  final Position? thirdPosition;
  final dynamic marketValue;

  PlayerShortInfo({
    required this.id,
    required this.name,
    this.image,
    this.imageLarge,
    this.imageSource,
    this.shirtNumber,
    this.age,
    this.dateOfBirth,
    this.heroImage,
    required this.isGoalkeeper,
    this.firstPosition,
    this.secondPosition,
    this.thirdPosition,
    this.marketValue,
  });

  factory PlayerShortInfo.fromJson(Map<String, dynamic> json) {
    return PlayerShortInfo(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? 'Unknown',
      image: json['image'],
      imageLarge: json['imageLarge'],
      imageSource: json['imageSource'],
      shirtNumber: json['shirtNumber']?.toString(),
      age: json['age'],
      dateOfBirth: json['dateOfBirth'],
      heroImage: json['heroImage'],
      isGoalkeeper: json['isGoalkeeper'] ?? false,
      firstPosition: json['positions']?['first'] != null
          ? Position.fromJson(json['positions']['first'])
          : null,
      secondPosition: json['positions']?['second'] != null
          ? Position.fromJson(json['positions']['second'])
          : null,
      thirdPosition: json['positions']?['third'] != null
          ? Position.fromJson(json['positions']['third'])
          : null,
      marketValue: json['marketValue'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'imageLarge': imageLarge,
      'imageSource': imageSource,
      'shirtNumber': shirtNumber,
      'age': age,
      'dateOfBirth': dateOfBirth,
      'heroImage': heroImage,
      'isGoalkeeper': isGoalkeeper,
      'positions': {
        'first': firstPosition?.toJson(),
        'second': secondPosition?.toJson(),
        'third': thirdPosition?.toJson(),
      },
      'marketValue': marketValue,
    };
  }

  bool get hasMarketValue => marketValue != null;

  String get marketValueString => marketValue?.toString() ?? '0';

  String get positionName => firstPosition?.shortName ?? 'N/A';
}

class Position {
  final String id;
  final String name;
  final String shortName;
  final String? group;

  Position({
    required this.id,
    required this.name,
    required this.shortName,
    this.group,
  });

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      shortName: json['shortName'] ?? '',
      group: json['group'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'shortName': shortName,
      'group': group,
    };
  }
}

class PlayerShortInfoResponse {
  final List<PlayerShortInfo> players;

  PlayerShortInfoResponse({required this.players});

  factory PlayerShortInfoResponse.fromJson(Map<String, dynamic> json) {
    return PlayerShortInfoResponse(
      players: (json['player'] as List<dynamic>?)
          ?.map((playerJson) => PlayerShortInfo.fromJson(playerJson))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'player': players.map((player) => player.toJson()).toList(),
    };
  }

  List<PlayerShortInfo> get playersWithMarketValue =>
      players.where((player) => player.hasMarketValue).toList();
}