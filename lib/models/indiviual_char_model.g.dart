// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'indiviual_char_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndivChar _$IndivCharFromJson(Map<String, dynamic> json) => IndivChar(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      status: json['status'] as String,
      species: json['species'] as String,
      gender: json['gender'] as String,
      hair: json['hair'] as String,
      alias: (json['alias'] as List<dynamic>).map((e) => e as String).toList(),
      origin: json['origin'] as String,
      abilities:
          (json['abilities'] as List<dynamic>).map((e) => e as String).toList(),
      imgUrl: json['imgUrl'] as String,
    );

Map<String, dynamic> _$IndivCharToJson(IndivChar instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'species': instance.species,
      'gender': instance.gender,
      'hair': instance.hair,
      'alias': instance.alias,
      'origin': instance.origin,
      'abilities': instance.abilities,
      'imgUrl': instance.imgUrl,
    };
