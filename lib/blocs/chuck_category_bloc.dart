import 'dart:async';

import 'package:flutter_bloc_app/models/ChuckCategories.dart';
import 'package:flutter_bloc_app/networking/response.dart';
import 'package:flutter_bloc_app/repository/chuckCategoryRepository.dart';

class ChuckCategoryBloc {
  ChuckCategoryRepository _chuckRepository;
  StreamController _chuckListController;

  StreamSink<Response<ChuckCategories>> get chuckListSink =>
      _chuckListController.sink;

  Stream<Response<ChuckCategories>> get chuckListStream =>
      _chuckListController.stream;

  ChuckCategoryBloc() {
    _chuckListController = StreamController<Response<ChuckCategories>>();
    _chuckRepository = ChuckCategoryRepository();
    fetchCategories();
  }

  fetchCategories() async {
    chuckListSink.add(Response.loading('Getting Chuck Categories.'));
    try {
      ChuckCategories chuckCats =
      await _chuckRepository.fetchChuckCategoryData();
      chuckListSink.add(Response.completed(chuckCats));
    } catch (e) {
      chuckListSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _chuckListController?.close();
  }
}
