import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc_app/networking/custom_exception.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  final String _baseUrl = "https://api.chucknorris.io/";

  Future<dynamic> get(String url) async {
    var responseJson;

    try {
      final response = await http.get(_baseUrl + url);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException("No Internet connection");
    }

    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
        break;

      case 400:
        throw BadRequestException(response.body.toString());
        break;

      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());

      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
