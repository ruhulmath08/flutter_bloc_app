import 'package:flutter_bloc_app/models/ChuckCategories.dart';
import 'package:flutter_bloc_app/networking/api_provider.dart';

class ChuckCategoryRepository {
  ApiProvider _provider = ApiProvider();

  Future<ChuckCategories> fetchChuckCategoryData() async {
    final response = await _provider.get("jokes/categories");
    return ChuckCategories.fromJson(response);
  }
}