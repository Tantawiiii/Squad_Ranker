// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeagueModel _$LeagueModelFromJson(Map<String, dynamic> json) => LeagueModel(
      name: json['name'] as String,
      id: json['id'] as String,
      country: json['country'] as String,
      score: (json['score'] as num).toInt(),
      isOpened: json['isOpened'] as bool? ?? false,
      isNew: json['isNew'] as bool? ?? false,
    );

Map<String, dynamic> _$LeagueModelToJson(LeagueModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'country': instance.country,
      'score': instance.score,
      'isOpened': instance.isOpened,
      'isNew': instance.isNew,
    };
