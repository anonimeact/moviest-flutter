import 'package:get/get.dart';
import 'package:moviest/app/data/models/global_api_response_model.dart';
import 'package:moviest/app/data/models/item_movie_model_model.dart';
import 'package:moviest/app/data/providers/item_movie_model_provider.dart';

class HomeController extends GetxController {
  var listMovie = List<ItemMovieModel>.empty().obs;
  var movieProvider = Get.find<ItemMovieModelProvider>();
  var page = 1;

  @override
  void onInit() {
    discoverMovie();
    super.onInit();
  }

  void discoverMovie() async {
    movieProvider.discoverMovies(page).then((response) {
      if (response.statusCode == 200) {
        final results = GlobalApiResponse.fromJson(response.body);
        final listMovies = ListMovieModel.fromJson(results.results!);
        listMovie.addAll(listMovies.listMovie!);
        page++;
      } else {
        // handel Error here
      }
    });
  }
}
