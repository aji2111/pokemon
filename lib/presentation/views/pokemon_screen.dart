// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_test/config/routes/app_pages.dart';
import 'package:mobile_test/data/shared_prefs.dart';
import 'package:get/get.dart';
import 'package:mobile_test/domain/model.dart';

import 'package:mobile_test/presentation/widgets/bottom_nav.dart';
import 'package:mobile_test/presentation/widgets/grid_item.dart';

class MyPokemon extends StatefulWidget {
  MyPokemon({super.key});

  @override
  State<MyPokemon> createState() => _MyPokemonState();
}

class _MyPokemonState extends State<MyPokemon> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Model>>(
      future: _loadModelList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Model> modelList = snapshot.data ?? [];

          return Scaffold(
              appBar: AppBar(
                title: const Text('Pokemon APP'),
                centerTitle: true,
              ),
              bottomNavigationBar: const BottomNavbar(),
              body: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: modelList.length,
                itemBuilder: (context, index) {
                  Model model = modelList[index];

                  return GridItemPokemon(
                    onDetail: () {
                      Get.toNamed(Routes.catchRoute,
                          arguments: Results(
                              catchOr: false,
                              id: model.id,
                              name: model.name,
                              url: model.url));
                    },
                    onDelete: () async {
                      await deleteItem(index);
                      setState(() {});
                    },
                    modelList: model,
                  );
                },
              ));
        }
      },
    );
  }

  Future<List<Model>> _loadModelList() async {
    List<String>? modelListJson =
        await SharedPrefs.getStringList('modelList') ?? [];

    // Mendekode JSON menjadi objek Model
    return modelListJson
        .map((json) => Model.fromMap(jsonDecode(json)))
        .toList();
  }

  Future<void> deleteItem(int index) async {
    List<String>? modelListJson = await SharedPrefs.getStringList('modelList');

    if (modelListJson.length > index) {
      // Remove the item at the specified index
      modelListJson.removeAt(index);

      // Save the updated list back to shared preferences
      await SharedPrefs.setStringList('modelList', modelListJson);
    }
  }
}
