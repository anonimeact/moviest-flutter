import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/services/objectbox.dart';
late ObjectBox objectbox;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectbox = await ObjectBox.create();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Moviest",
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    ),
  );
}
