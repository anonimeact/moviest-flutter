import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class BaseService extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://api.themoviedb.org/3/';
    httpClient.addRequestModifier((Request request) async {
      request.headers['accept'] = 'application/json';
      request.headers['Authorization'] =
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiM2M1YTFjNWE3MzdkYTJlNWIwM2UzNmQ5ZTA0ZDc5ZSIsInN1YiI6IjY1MTNhYzAxMDQ5OWYyMDExYjA5NTIzNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.iTfKIZPZ-XfGFo0c5dDCc7VO6gtIEWynyO36hgC8hTM';
      return request;
    });
   
    httpClient.defaultContentType = "application/json";
    super.onInit();
  }
}