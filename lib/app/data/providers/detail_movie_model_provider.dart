import 'package:get/get.dart';

import 'base_service.dart';

class DetailMovieModelProvider extends BaseService {
  Future<Response> getDetailMovieModel(int id) async {
    final response = await httpClient.get('movie/$id');
    return response;
  }

  Future<Response> getReviewsMovieModel(int id) async {
    final response = await httpClient.get('movie/$id/reviews');
    return response;
  }
}
