import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/characters_model.dart';

part 'api.g.dart';


@RestApi(baseUrl: "https://finalspaceapi.com/api/v0/")
abstract class BaseRestClient {
  factory BaseRestClient(Dio dio, {String baseUrl}) = _BaseRestClient;

  @GET('character/')
  Future<CharactersModel> fetchChar();

}