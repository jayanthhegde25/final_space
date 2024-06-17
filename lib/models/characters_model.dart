
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CharactersModel {
  CharactersModel({
      num? id, 
      String? name, 
      String? status, 
      String? species, 
      String? gender, 
      String? hair, 
      List<String>? alias, 
      String? origin, 
      List<String>? abilities, 
      String? imgUrl,}){
    _id = id;
    _name = name;
    _status = status;
    _species = species;
    _gender = gender;
    _hair = hair;
    _alias = alias;
    _origin = origin;
    _abilities = abilities;
    _imgUrl = imgUrl;
}

  CharactersModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _status = json['status'];
    _species = json['species'];
    _gender = json['gender'];
    _hair = json['hair'];
    _alias = json['alias'] != null ? json['alias'].cast<String>() : [];
    _origin = json['origin'];
    _abilities = json['abilities'] != null ? json['abilities'].cast<String>() : [];
    _imgUrl = json['img_url'];
  }
  num? _id;
  String? _name;
  String? _status;
  String? _species;
  String? _gender;
  String? _hair;
  List<String>? _alias;
  String? _origin;
  List<String>? _abilities;
  String? _imgUrl;
CharactersModel copyWith({  num? id,
  String? name,
  String? status,
  String? species,
  String? gender,
  String? hair,
  List<String>? alias,
  String? origin,
  List<String>? abilities,
  String? imgUrl,
}) => CharactersModel(  id: id ?? _id,
  name: name ?? _name,
  status: status ?? _status,
  species: species ?? _species,
  gender: gender ?? _gender,
  hair: hair ?? _hair,
  alias: alias ?? _alias,
  origin: origin ?? _origin,
  abilities: abilities ?? _abilities,
  imgUrl: imgUrl ?? _imgUrl,
);
  num? get id => _id;
  String? get name => _name;
  String? get status => _status;
  String? get species => _species;
  String? get gender => _gender;
  String? get hair => _hair;
  List<String>? get alias => _alias;
  String? get origin => _origin;
  List<String>? get abilities => _abilities;
  String? get imgUrl => _imgUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['status'] = _status;
    map['species'] = _species;
    map['gender'] = _gender;
    map['hair'] = _hair;
    map['alias'] = _alias;
    map['origin'] = _origin;
    map['abilities'] = _abilities;
    map['img_url'] = _imgUrl;
    return map;
  }

}