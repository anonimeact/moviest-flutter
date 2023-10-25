import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:moviest/app/data/models/detail_movie_model_model.dart';
import 'package:moviest/app/routes/app_pages.dart';

import '../controllers/favorite_controller.dart';

class FavoriteView extends GetView<FavoriteController> {
  const FavoriteView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.fetchFavorites();
    return Scaffold(
        appBar: AppBar(
          title: const Text('FavoriteView'),
          centerTitle: true,
        ),
        body: Obx(() => controller.listFavorites.isEmpty
            ? const Center(
                child: Text("Belum ada data"),
              )
            : ListView.builder(
                itemCount: controller.listFavorites.length,
                itemBuilder: (context, index) {
                  final itemFav = controller.listFavorites[index];
                  return ItemFavoriteWidget(itemFav: itemFav);
                })));
  }
}

class ItemFavoriteWidget extends StatelessWidget {
  ItemFavoriteWidget({
    super.key,
    required this.itemFav,
  });

  final DetailMovieModel itemFav;

  final favC = Get.find<FavoriteController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Get.toNamed(Routes.detail, arguments: itemFav.idMovie)?.then((value) {
        favC.fetchFavorites();
      }),
      child: SizedBox(
          width: Get.width,
          child: Card(
            margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: Stack(
              children: [
                FadeInImage.assetNetwork(
                    placeholder: "assets/images/placeholder_banner_movies.png",
                    image:
                        "https://image.tmdb.org/t/p/original${itemFav.backdropPath}"),
                Positioned(
                  left: 0,
                  bottom: 0,
                  width: Get.width,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.black.withOpacity(0.5),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${itemFav.title}",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${itemFav.overview}",
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
