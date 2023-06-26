import 'package:flutter_games/games/match3/models/tile.dart';

class Array2d {
  final List<List<Tile?>> array;

  Array2d(int rows, int columns)
      : array = List.generate(rows,
            (index) => List.generate(columns, (index) => null, growable: false),
            growable: false);

  List<Tile?> operator [](int x) => array[x];

  set tile(Tile tile) => array[tile.row][tile.col] = tile;

  Array2d.empty() : array = List<List<Tile>>.empty();
}
