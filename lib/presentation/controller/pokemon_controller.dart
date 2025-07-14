import 'dart:convert';

import 'package:get/get.dart';
import 'package:mobile_test/data/shared_prefs.dart';
import 'package:mobile_test/domain/model.dart';

import 'package:mobile_test/domain/rest_api.dart';

class PokemonController extends GetxController {
  RestApi api = RestApi();
  RxBool isLoading = false.obs;
  RxBool isLoadingImage = false.obs;
  final Results pokemon = Get.arguments;

  var responseData = <Stats>[].obs;
  var responseTypes = <Types>[].obs;
  Rx<Results> resultPokemon = Results().obs;

  var resultMove = <Moves>[].obs;

  List<Model> modelList = [];

  @override
  void onInit() {
    super.onInit();
    viewPokemonDetail(pokemon.url!);
  }

  Future<void> setUserData(Model models) async {
    modelList.add(models);
    List<String> modelListJson =
        modelList.map((model) => jsonEncode(model.toMap())).toList();
    await SharedPrefs.setStringList("modelList", modelListJson);

    modelList =
        modelListJson.map((json) => Model.fromMap(jsonDecode(json))).toList();
  }

  Future<void> getUserData() async {
    List<String>? modelListJson = await SharedPrefs.getStringList('modelList');

    // Mendekode JSON menjadi objek Model
    modelList =
        modelListJson.map((json) => Model.fromMap(jsonDecode(json))).toList();
  }

  Future<void> viewPokemonDetail(String url) async {
    try {
      isLoading.value = true;

      var response = await api.detailPokemon(urlDetail: url);

      if (response != null) {
        pokemon.height = response['height'];
        pokemon.weight = response['weight'];
        pokemon.name = response['name'];
        pokemon.id = response['id'];
        for (var element in (response['moves'] as List)) {
          if (element is Map) {
            resultMove.add(Moves(move: Ability.fromJson(element['move'])));
          }
        }
        for (var element in (response['types'] as List)) {
          if (element is Map) {
            responseTypes.add(Types(type: Stat.fromJson(element['type'])));
          }
        }
        for (var element in (response['stats'] as List)) {
          if (element is Map) {
            responseData.add(Stats(
                baseStat: element['base_stat'],
                effort: element['effort'],
                stat: Stat.fromJson(element['stat'])));
          }
        }
      }
    } finally {
      isLoading.value = false;
    }
  }
}
