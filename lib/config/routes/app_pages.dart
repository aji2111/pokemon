// ignore_for_file: depend_on_referenced_packages

import 'package:get/get.dart';
import 'package:mobile_test/presentation/views/catch_screen.dart';
import 'package:mobile_test/presentation/views/home_screen.dart';
import 'package:mobile_test/presentation/views/pokemon_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeScreen(),
    ),
    GetPage(
        name: _Paths.catchRoute,
        page: () => CatchScreen(),
        arguments: Get.arguments),
    GetPage(
      name: _Paths.myPokemon,
      page: () => MyPokemon(),
    ),
  ];
}
