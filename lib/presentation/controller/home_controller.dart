import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_test/domain/model.dart';
import 'package:mobile_test/domain/rest_api.dart';

class HomeController extends GetxController {
  RestApi api = RestApi();
  RxBool isLoading = false.obs;
  RxBool isLoadingImage = false.obs;
  RxBool isLoadingLoadMore = false.obs;
  final controller = ScrollController();

  var responseData = <Results>[].obs;
  late List<Results> pokemonList;
  int currentPage = 1;
  int itemsPerPage = 20; // Number of items to fetch per page

  @override
  void onInit() {
    viewPokemon(itemsPerPage, page: currentPage);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      controller.addListener(scrollListener);
    });
    super.onInit();
  }

  scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange &&
        !isLoadingLoadMore.value) {
      // Avoid triggering multiple load more requests simultaneously
      viewPokemon(itemsPerPage, page: currentPage + 1);
    }
  }

  Future<void> viewPokemon(int itemsPerPage, {int page = 1}) async {
    try {
      if (page == 1) {
        isLoading.value = true;
      } else {
        isLoadingLoadMore.value = true;
      }

      int offset =
          (page - 1) * itemsPerPage; // Calculate offset based on the page
      int limit = itemsPerPage;

      var response = await api.fetchPokemon(offset: offset, limit: limit);

      if (response['results'] != null) {
        for (var element in (response['results'] as List)) {
          if (element is Map) {
            responseData.add(Results(
                name: element['name'],
                url: element['url'],
                id: getIdFromUrl(element['url'])));
          }
        }
        currentPage = page; // Update the current page after a successful load
      }
    } finally {
      if (page == 1) {
        isLoading.value = false;
      } else {
        isLoadingLoadMore.value = false;
      }
    }
  }

  int getIdFromUrl(String url) {
    final uri = Uri.parse(url);
    final parts = uri.path.split('/');
    return int.parse(parts[parts.length - 2]);
  }
}
