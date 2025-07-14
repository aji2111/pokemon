import 'package:mobile_test/domain/net_utils.dart';

class RestApi {
  final NetworkUtil _util = NetworkUtil();
  final url = "https://pokeapi.co/api/v2/pokemon";
// PARAMETER
  Future<dynamic> fetchPokemon(
      {required int offset, required int limit, Map<String, String>? header}) {
    return _util
        .get(
      "$url/?offset=$offset&limit=$limit",
    )
        .then((value) {
      // if (value['status'] != Constant.statusSuccess) throw value['message'];

      return value;
    });
  }

  Future<dynamic> detailPokemon({String? urlDetail}) {
    return _util
        .get(
      urlDetail!,
    )
        .then((value) {
      // if (value['status'] != Constant.statusSuccess) throw value['message'];

      return value;
    });
  }
}
