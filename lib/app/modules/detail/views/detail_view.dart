import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviest/app/modules/detail/controllers/detail_controller.dart';

import '../../../data/models/reviews_movie_model_model.dart';
import '../../favorite/controllers/favorite_controller.dart';

class DetailView extends GetView<DetailController> {
  final favoriteC = Get.put(FavoriteController());
  @override
  Widget build(BuildContext context) {
    final movieId = Get.arguments;
    controller.getDetailMovie(movieId);
    favoriteC.checkCurrentFavorite(movieId);

    return Scaffold(
        appBar: AppBar(
          title: Obx(() =>
              Text(controller.detailMovie.value.title ?? 'Movie Details')),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(),
              pinned: true,
              floating: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Obx(() => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Vote Average: ${controller.detailMovie.value.voteAverage}'),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Movie Reviews',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            if (controller.reviewsMovie.value.listReview ==
                                    null ||
                                controller.reviewsMovie.value.listReview
                                        ?.isEmpty ==
                                    true)
                              const Text(
                                  'Oops, there are no reviews for this film yet!')
                            else
                              Column(
                                children: controller
                                    .reviewsMovie.value.listReview!
                                    .map((review) {
                                  return ItemReviewWidget(review);
                                }).toList(),
                              ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.snackbar(
                "Favorite",
                favoriteC.currentFavId.value != 0
                    ? "Dihapus dari favorite"
                    : "Ditambahkan ke favorite",
                colorText: Colors.black,
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.amber,
                margin: const EdgeInsets.all(10),
                duration: const Duration(seconds: 1));
            if (favoriteC.currentFavId.value != 0) {
              favoriteC.removeFavorite();
            } else {
              favoriteC.addFavorite(controller.detailMovie.value);
            }
          },
          child: Obx(() => Icon(favoriteC.currentFavId.value != 0
              ? Icons.favorite
              : Icons.favorite_border)),
        ));
  }
}

class ItemReviewWidget extends StatelessWidget {
  ItemReviewWidget(this.review, {super.key});

  ReviewsMovieModel review;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(3),
      leading: CircleAvatar(
        child: review.authorDetails?.avatarPath == null
            ? const Icon(Icons.people)
            : Image.network(
                "https://image.tmdb.org/t/p/w342${review.authorDetails?.avatarPath}"),
      ),
      title: Text(review.author ?? "", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      subtitle: Text(
        review.content ?? "",
        style: const TextStyle(fontSize: 11),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final detailController = Get.find<DetailController>();
  @override
  double get minExtent => 0;
  @override
  double get maxExtent =>
      300.0; // Maximum height of the header when it's fully expanded

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Obx(() => Stack(fit: StackFit.expand, children: [
          detailController.detailMovie.value.backdropPath == null
              ? const Center(child: CircularProgressIndicator())
              : Image.network(
                  "https://image.tmdb.org/t/p/original${detailController.detailMovie.value.backdropPath}",
                  fit: BoxFit.cover,
                ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Opacity(
                  opacity: 1.0 - shrinkOffset / maxExtent,
                  child: Container(
                      padding: const EdgeInsets.all(16.0),
                      color: Colors.black.withOpacity(0.5),
                      child: SizedBox(
                        width: Get.width,
                        child: IntrinsicHeight(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text(
                                detailController.detailMovie.value.title ?? "",
                                style: const TextStyle(
                                  fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                detailController.detailMovie.value.overview ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12, color: Colors.white),
                              )
                            ])),
                      ))))
        ]));
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
