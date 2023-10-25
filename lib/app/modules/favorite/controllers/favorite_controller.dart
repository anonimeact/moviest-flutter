import 'package:get/get.dart';
import 'package:moviest/app/data/models/detail_movie_model_model.dart';
import 'package:moviest/main.dart';

import '../../../../objectbox.g.dart';

class FavoriteController extends GetxController {
  var currentFavId = 0.obs;
  var listFavorites = List<DetailMovieModel>.empty().obs;
  final favoriteBox = objectbox.store.box<DetailMovieModel>();
  void addFavorite(DetailMovieModel newMovie) {
    final id = favoriteBox.put(newMovie);
    currentFavId.value = id;
  }

  void removeFavorite() {
    favoriteBox.remove(currentFavId.value);
    currentFavId.value = 0;
  }

  void fetchFavorites() {
    listFavorites.value = [];
    listFavorites.value = favoriteBox.getAll();
  }

  void checkCurrentFavorite(int movieId) {
    final query =
        (favoriteBox.query(DetailMovieModel_.idMovie.equals(movieId))).build();
    final result = query.find();
    if (result.isNotEmpty) {
      currentFavId.value = result[0].id;
    }
    query.close();
  }
}
