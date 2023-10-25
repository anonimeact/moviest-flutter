import 'package:get/get.dart';

import '../../../data/providers/item_movie_model_provider.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ItemMovieModelProvider>(
      () => ItemMovieModelProvider(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
