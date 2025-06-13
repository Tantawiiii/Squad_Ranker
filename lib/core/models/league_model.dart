import 'package:json_annotation/json_annotation.dart';

part 'league_model.g.dart';

@JsonSerializable()
class LeagueModel {
  final String name;
  final String id;
  final String country;
  final int score;
  final bool isOpened;
  final bool isNew;

  LeagueModel({
    required this.name,
    required this.id,
    required this.country,
    required this.score,
    this.isOpened = false,
    this.isNew = false,
  });

  factory LeagueModel.fromJson(Map<String, dynamic> json) => _$LeagueModelFromJson(json);

  Map<String, dynamic> toJson() => _$LeagueModelToJson(this);
}
