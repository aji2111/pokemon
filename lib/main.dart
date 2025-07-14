// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:mobile_test/config/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:mobile_test/data/shared_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.getPref();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pokemon Aplikasi',
      initialRoute: Routes.home,
      getPages: AppPages.routes,
    );
  }
}
