import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_games/games/match3/models/level.dart';
import 'package:flutter_games/games/match3/models/tile.dart';
import 'package:flutter_games/utils/array_2d.dart';

class GameController extends ChangeNotifier {
  final Level level;
  double _tileSize;
  late Array2d tiles = Array2d(level.numberOfRows, level.numberOfCols);
  GameController(this.level, this._tileSize) {
    shuffle(_tileSize);
  }
  final colorsTypes = [
    TileType.blue,
    TileType.red,
    TileType.green,
    TileType.purple,
    TileType.orange
  ];
  Offset? _fingerStartPos;

  void shuffle(double tileSize) {
    double left = 0;
    double top = 0;
    final random = Random();
    for (int i = 0; i < level.numberOfRows; i++) {
      for (int j = 0; j < level.numberOfCols; j++) {
        if (j == 0) left = 0;
        final tt = Tile(
          type: colorsTypes[random.nextInt(colorsTypes.length)],
          row: i,
          col: j,
          x: left,
          y: top,
          size: tileSize,
        );
        tiles.tile = tt;
        left += tileSize;
      }
      top += tileSize;
    }
    notifyListeners();
  }

  void onFingerStart(DragStartDetails details) {
    _fingerStartPos = details.localPosition;
  }

  void onFingerMove(DragUpdateDetails details) {
    if (_fingerStartPos != null) {
      final fingerMoved = details.localPosition - _fingerStartPos!;
      final neededMoveSize = _tileSize / 2;

      if (fingerMoved.dx.abs() > fingerMoved.dy.abs() &&
          fingerMoved.dx.abs() > neededMoveSize) {
        // horizontal move
        print('horizontal move');
      }

      if (fingerMoved.dy.abs() > fingerMoved.dx.abs() &&
          fingerMoved.dy.abs() > neededMoveSize) {
        // vertical move
        print('vertical move');
      }
    }
  }
}
