import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobile_test/config/routes/app_pages.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> nav = [Routes.home, Routes.myPokemon];
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.people), label: "Catch Pokemon"),
        BottomNavigationBarItem(
            icon: Icon(Icons.catching_pokemon_rounded), label: "My Pokemon"),
      ],
      onTap: (value) {
        Get.offAndToNamed(nav[value]);
      },
    );
  }
}
