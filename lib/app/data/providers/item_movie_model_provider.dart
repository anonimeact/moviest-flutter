import 'package:get/get.dart';

import 'base_connecton.dart';

class ItemMovieModelProvider extends BaseService {

  Future<Response> discoverMovies(int page) async {
    final response = await httpClient
        .get('discover/movie', query: {'page': page.toString()});
    return response;
  }
}
