import 'package:dasboard/constants/constants.dart';
import 'package:dio/dio.dart';

class BaseApiService {
  Future<dynamic> get(String url) {
    Dio client = Dio(BaseOptions(baseUrl: Constants.baseUrl));

    return client.get(url);
  }
}
