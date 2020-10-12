import 'dart:async';

import 'package:flutter_bloc_app/models/chuck_response.dart';
import 'package:flutter_bloc_app/networking/api_provider.dart';

class ChuckRepository {
  ApiProvider _provider = ApiProvider();

  Future<ChuckResponse> fetchChuckJoke(String category) async {
    final response = await _provider.get("jokes/random?category=" + category);
    return ChuckResponse.fromJson(response);
  }
}