import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'indiviual_char_model.g.dart';


@JsonSerializable()
class IndivChar {
  int id;
  String name;
  String status;
  String species;
  String gender;
  String hair;
  List<String> alias;
  String origin;
  List<String> abilities;
  String imgUrl;

  IndivChar({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.hair,
    required this.alias,
    required this.origin,
    required this.abilities,
    required this.imgUrl,
  });

  factory IndivChar.fromRawJson(String str) => IndivChar.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory IndivChar.fromJson(Map<String, dynamic> json) => IndivChar(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    species: json["species"],
    gender: json["gender"],
    hair: json["hair"],
    alias: List<String>.from(json["alias"].map((x) => x)),
    origin: json["origin"],
    abilities: List<String>.from(json["abilities"].map((x) => x)),
    imgUrl: json["img_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
    "species": species,
    "gender": gender,
    "hair": hair,
    "alias": List<dynamic>.from(alias.map((x) => x)),
    "origin": origin,
    "abilities": List<dynamic>.from(abilities.map((x) => x)),
    "img_url": imgUrl,
  };
}
