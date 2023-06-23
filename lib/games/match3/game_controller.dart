import 'package:flutter_games/games/match3/models/level.dart';
import 'package:flutter_games/games/match3/models/tile.dart';
import 'package:flutter_games/utils/array_2d.dart';

class GameController {
  final Level level;
  Array2d<Tile> grid = Array2d(0, 0);
  GameController(this.level) {
    shuffle();
  }
  void shuffle() {
    Array2d<Tile> clone = Array2d.empty();
    for (int i = 0; i < level.numberOfRows; i++) {
      var x = List.generate(
        level.numberOfCols,
        (index) => Tile(type: TileType.blue, row: i, col: index),
      );
      clone.array.add(x);
    }
    grid = clone;
  }
}
