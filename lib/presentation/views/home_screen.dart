import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_test/config/routes/app_pages.dart';
import 'package:mobile_test/domain/model.dart';
import 'package:mobile_test/presentation/controller/home_controller.dart';
import 'package:mobile_test/presentation/widgets/bottom_nav.dart';
import 'package:mobile_test/presentation/widgets/grid_item.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController home = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon APP'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (home.isLoading.isTrue && home.responseData.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return GridView.builder(
            controller: home.controller,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount:
                home.responseData.length + 1, // Add 1 for the loading indicator
            itemBuilder: (context, index) {
              if (index < home.responseData.length) {
                Results pokemon = home.responseData[index];

                return Column(
                  children: [
                    GridItem(
                      onDetail: () {
                        Get.toNamed(Routes.catchRoute,
                            arguments: Results(
                                catchOr: true,
                                id: pokemon.id,
                                name: pokemon.name,
                                url: pokemon.url));
                      },
                      pokemon: pokemon,
                    ),
                    Visibility(
                        visible: home.isLoadingLoadMore.isTrue,
                        child: const Center(child: CircularProgressIndicator()))
                  ],
                );
              }
            },
          );
        }
      }),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
