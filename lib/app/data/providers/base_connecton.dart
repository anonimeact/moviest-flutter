import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

import '../../../main.dart';

class BaseService extends GetConnect {
  @override
  void onInit() async {
    httpClient.baseUrl = 'https://api.themoviedb.org/3/';
    httpClient.addRequestModifier((Request request) async {
      request.headers['accept'] = 'application/json';
      request.headers['Authorization'] = 'Bearer $token';
      return request;
    });

    httpClient.defaultContentType = "application/json";
    super.onInit();
  }
}
