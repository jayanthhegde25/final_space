import 'package:dio/dio.dart';

class DioService {
  static Dio dio() {
    Dio dio = Dio();
    return dio;
  }
}
