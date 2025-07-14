import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile_test/config/routes/app_pages.dart';
import 'package:mobile_test/data/shared_prefs.dart';
import 'package:mobile_test/domain/model.dart';
import 'package:mobile_test/presentation/controller/pokemon_controller.dart';
import 'package:get/get.dart';
import 'package:mobile_test/presentation/widgets/content_dialog.dart';
import 'package:mobile_test/presentation/widgets/detail_pokemon.dart';

class CatchScreen extends GetView<PokemonController> {
  CatchScreen({super.key});
  final Results pokemon = Get.arguments;
  final PokemonController home =
      Get.put<PokemonController>(PokemonController());
  @override
  Widget build(BuildContext context) {
    final imageUrl =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokemon.id}.png';
    return Scaffold(
      appBar: AppBar(
        title: const Text('DETAIL POKEMON'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  width: 300,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
            ),
            Obx(() {
              if (home.isLoading.isTrue) {
                return const CircularProgressIndicator();
              } else {
                return PokemonDetail(
                  pokemon: pokemon,
                  home: home,
                  onTap: () async {
                    await home.getUserData();
                    List<String>? modelListJson =
                        await SharedPrefs.getStringList('modelList') ?? [];

                    List<Model> modelList = modelListJson
                        .map((json) => Model.fromMap(jsonDecode(json)))
                        .toList();
                    bool isPokemonOwned =
                        modelList.any((model) => model.id == pokemon.id);
                    catchPokemon(isPokemonOwned);
                  },
                );
              }
            })
          ],
        ),
      ),
    );
  }

  catchPokemon(bool isPokemonOwned) {
    if (isPokemonOwned) {
      Get.dialog(
        DialogContent(
          nameContent: 'You Already owned this Pokemon',
          icon: const Icon(
            Icons.close,
            color: Colors.red,
          ),
          onTap: () {
            Get.back();
          },
        ),
      );
    } else {
      double catchPercentage = getRandomCatchPercentage();
      if (catchPercentage > 50.0) {
        print('Pokemon berhasil ditangkap!');
        home.setUserData(
          Model(id: pokemon.id!, name: pokemon.name!, url: pokemon.url!),
        );
        // print(home.modelList.length);
        Get.dialog(
          DialogContent(
            
            nameContent: 'Success To Catch Pokemon',
            icon: const Icon(
              Icons.check,
              color: Colors.black,
            ),
            onTap: () {
              Get.offAllNamed(
                Routes.home,
              );
            },
          ),
        );
      } else {
        print('Pokemon melarikan diri!');
        Get.dialog(
          DialogContent(
            nameContent: 'Failed To Catch Pokemon',
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            ),
            onTap: () {
              Get.back();
            },
          ),
        );
      }
    }
  }

  double getRandomCatchPercentage() {
    Random random = Random();
    return random.nextDouble() * 100.0;
  }
}
