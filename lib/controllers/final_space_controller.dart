
import 'dart:developer';
import 'dart:convert';
import 'package:find_space/models/characters_model.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;

import '../models/episode_model.dart';
import '../models/location_model.dart';
part 'final_space_controller.g.dart';

class FinalSpaceController = FinalSpaceControllerBase with _$FinalSpaceController;
abstract class FinalSpaceControllerBase with Store {

  @observable
  List<dynamic> userData =[];

  @observable
  List<EpisodeModel> episodes =[];

  @observable
  List<CharactersModel> characters = [];

  @observable
  List<LocationModel> locations = [];

  @observable
  int selectedIndex= 0;

  @action
  Future<List<CharactersModel>> getCharacters() async {
    try {
      log('Fetching characters...');
      final response = await http.get(Uri.parse('https://finalspaceapi.com/api/v0/character'));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        final characters = jsonData.map((json) => CharactersModel.fromJson(json)).toList();
        return characters;
      } else {
        log('Failed to load character data. Status code: ${response.statusCode}');
        throw Exception('Failed to load character data');
      }
    } catch (error) {
      log(error.toString(), name: 'getCharacters');
      rethrow;
    }
  }

  @action
  Future<List<EpisodeModel>> getEpisode() async {
    try {
      log('Fetching characters...');
      final response = await http.get(Uri.parse('https://finalspaceapi.com/api/v0/episode'));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        final episode = jsonData.map((json) => EpisodeModel.fromJson(json)).toList();
        return episode;
      } else {
        log('Failed to load character data. Status code: ${response.statusCode}');
        throw Exception('Failed to load character data');
      }
    } catch (error) {
      log(error.toString(), name: 'getEpisode');
      rethrow;
    }
  }

  @action
  Future<List<LocationModel>> getLocation() async {
    try {
      log('Fetching characters...');
      final response = await http.get(Uri.parse('https://finalspaceapi.com/api/v0/location'));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        final location = jsonData.map((json) => LocationModel.fromJson(json)).toList();
        return location;
      } else {
        log('Failed to load character data. Status code: ${response.statusCode}');
        throw Exception('Failed to load character data');
      }
    } catch (error) {
      log(error.toString(), name: 'getEpisode');
      rethrow;
    }
  }

}