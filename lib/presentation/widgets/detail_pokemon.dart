import 'package:flutter/material.dart';
import 'package:mobile_test/domain/model.dart';
import 'package:mobile_test/presentation/controller/pokemon_controller.dart';

class PokemonDetail extends StatelessWidget {
  final Results pokemon;
  final PokemonController home;
  final Function() onTap;
  const PokemonDetail(
      {super.key,
      required this.pokemon,
      required this.home,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          pokemon.name!,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: home.responseTypes
                .map((element) => Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ]),
                          child: Text(
                            element.type!.name!,
                            style: const TextStyle(color: Colors.white),
                          )),
                    ))
                .toList()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    home.pokemon.weight!.toDouble().toString(),
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                  const Text(
                    'weight',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    home.pokemon.height!.toDouble().toString(),
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                  const Text(
                    'Height',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Divider(
          height: 0.1,
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "moves",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: home.resultMove
                        .map((element) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      ),
                                    ]),
                                child: Text(
                                  element.move!.name!,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ))
                        .toList()),
              ),
            ],
          ),
        ),
        Column(
            children: home.responseData
                .map((element) => Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          element.stat!.name ?? "",
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                        )),
                        Expanded(
                          child: Stack(
                            children: [
                              LinearProgressIndicator(
                                  color: Colors.red,
                                  minHeight: 25,
                                  semanticsLabel: 'test',
                                  semanticsValue: 'test',
                                  borderRadius: BorderRadius.circular(8),
                                  value: element.baseStat!.toDouble() / 300),
                              Positioned.fill(
                                child: Semantics(
                                  child: Center(
                                    child: Text(
                                      '${element.baseStat!.toDouble()} /300',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )))
                .toList()),
        Visibility(
          visible: pokemon.catchOr!,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: onTap,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.catching_pokemon_sharp,
                          color: Colors.white,
                        ),
                        Text(
                          'Catch',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
