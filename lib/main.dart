import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/services/objectbox.dart';

late ObjectBox objectbox;
late String token;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectbox = await ObjectBox.create();
  token = await rootBundle.loadString('assets/token.text');
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Moviest",
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    ),
  );
}
