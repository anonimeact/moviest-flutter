import 'package:get/get.dart';
import 'package:moviest/app/data/models/detail_movie_model_model.dart';
import 'package:moviest/app/data/models/reviews_movie_model_model.dart';
import 'package:moviest/app/data/providers/detail_movie_model_provider.dart';

import '../../../data/models/global_api_response_model.dart';

class DetailController extends GetxController {
  var detailMovie = DetailMovieModel().obs;
  var reviewsMovie = ListReviewMovieModel().obs;
  final detailProvider = Get.put(DetailMovieModelProvider());

  void getDetailMovie(int movieId) {
    detailProvider.getDetailMovieModel(movieId).then((response) {
      if (response.statusCode == 200) {
        detailMovie.value = DetailMovieModel.fromJson(response.body);
      }
    });
    detailProvider.getReviewsMovieModel(movieId).then((response) {
      if (response.statusCode == 200) {
        final results = GlobalApiResponse.fromJson(response.body);
        final reviews = ListReviewMovieModel.fromJson(results.results!);
        reviewsMovie.value = reviews;
      }
    });
  }
}
