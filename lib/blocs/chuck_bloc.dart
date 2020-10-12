import 'dart:async';

import 'package:flutter_bloc_app/models/chuck_response.dart';
import 'package:flutter_bloc_app/networking/response.dart';
import 'package:flutter_bloc_app/repository/chuck_repository.dart';

class ChuckBloc {
  ChuckRepository _chuckRepository;
  StreamController _chuckDataController;

  StreamSink<Response<ChuckResponse>> get chuckDataSink => _chuckDataController.sink;

  Stream<Response<ChuckResponse>> get chuckDataStream => _chuckDataController.stream;

  ChuckBloc(String category) {
    _chuckDataController = StreamController<Response<ChuckResponse>>();
    _chuckRepository = ChuckRepository();
    fetchChuckyJoke(category);
  }

  fetchChuckyJoke(String category) async {
    chuckDataSink.add(Response.loading('Getting A Chucky Joke!'));
    try {
      ChuckResponse chuckJoke = await _chuckRepository.fetchChuckJoke(category);
      chuckDataSink.add(Response.completed(chuckJoke));
    } catch (e) {
      chuckDataSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _chuckDataController?.close();
  }
}
