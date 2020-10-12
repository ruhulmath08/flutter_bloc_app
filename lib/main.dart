import 'package:flutter/material.dart';
import 'package:flutter_bloc_app/view/get_chuck_categories.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Chucky Norris',
        home: GetChuckCategories()); // define it once at root level.
  }
}