import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Moviest'),
          centerTitle: true,
          actions: [],
        ),
        body: Obx(() => Padding(
              padding: const EdgeInsets.all(2),
              child: NotificationListener<ScrollEndNotification>(
                onNotification: (data) {
                  if (data.metrics.pixels > 0 && data.metrics.atEdge) {
                    controller.discoverMovie();
                  }
                  return true;
                },
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2),
                  itemCount: controller.listMovie.length,
                  itemBuilder: (context, index) {
                    var itemMovie = controller.listMovie[index];
                    return InkWell(
                      onTap: () =>
                          Get.toNamed(Routes.detail, arguments: itemMovie.id),
                      child: Container(
                        color: Colors.black,
                        child: Stack(
                          children: [
                            Image.network(
                                "https://image.tmdb.org/t/p/w342${itemMovie.posterPath}",
                                fit: BoxFit.fitWidth),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: 56,
                                color: Colors.black.withOpacity(0.8),
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  "${itemMovie.title}",
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            )),
        floatingActionButton: SizedBox(
          height: 48,
          width: Get.width - 80,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  side: const BorderSide(color: Colors.white, width: 2)),
              onPressed: () => Get.toNamed(Routes.favorite),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite),
                  SizedBox(width: 8),
                  Text("FAVORITES"),
                ],
              )),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
