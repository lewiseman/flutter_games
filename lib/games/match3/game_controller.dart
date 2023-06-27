import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_games/games/match3/models/level.dart';
import 'package:flutter_games/games/match3/models/tile.dart';
import 'package:flutter_games/utils/array_2d.dart';

class GameController with ChangeNotifier {
  final Level level;
  double _tileSize;
  late Array2d tiles = Array2d(level.numberOfRows, level.numberOfCols);
  GameController(this.level, this._tileSize, TickerProvider vsync) {
    tileAnimationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 250),
      lowerBound: 0,
      upperBound: 100,
    );
    tileAnimationController.addListener(tileAnimation);
    shuffle(_tileSize);
  }
  late final AnimationController tileAnimationController;

  final colorsTypes = [
    TileType.blue,
    TileType.red,
    TileType.green,
    TileType.purple,
    TileType.orange
  ];
  Offset? _fingerStartPos;
  ({Tile tile, Moving direction, Tile destination})? activeTileInfo;

  void shuffle(double tileSize) {
    double left = 0;
    double top = 0;
    final random = Random();
    for (int i = 0; i < level.numberOfRows; i++) {
      for (int j = 0; j < level.numberOfCols; j++) {
        if (j == 0) left = 0;
        Tile tt;
        do {
          tt = Tile(
            type: colorsTypes[random.nextInt(colorsTypes.length)],
            row: i,
            col: j,
            x: left,
            y: top,
            size: tileSize,
          );
        } while (tiles.hasImmediateMatch(tt));
        tiles.tile = tt;
        left += tileSize;
      }
      top += tileSize;
    }
    // notifyListeners();
  }

  void tileAnimation() {
    if (tileAnimationController.isCompleted) {
      // after animation is completed swap the tiles position on grid;
      tiles.swap(activeTileInfo!.tile, activeTileInfo!.destination);
      final matches = tiles.findMatches();
      if (matches.isEmpty) {
        // TODO : Add a swap back 🧠 not sure though 
        tileAnimationController.reverse();
      } else {
        activeTileInfo = null;
        tileAnimationController.reset();
        tiles.removeMatches(matches);
        notifyListeners();
      }
    }
    if (activeTileInfo != null) {
      tiles[activeTileInfo!.tile.row][activeTileInfo!.tile.col] =
          activeTileInfo!.tile.move(
        activeTileInfo!.direction,
        tileAnimationController.value,
        tileAnimationController.upperBound,
      );
      tiles[activeTileInfo!.destination.row][activeTileInfo!.destination.col] =
          activeTileInfo!.destination.moveDestination(
        activeTileInfo!.direction,
        tileAnimationController.value,
        tileAnimationController.upperBound,
      );
      notifyListeners();
    }
  }

  void onFingerStart(DragStartDetails details) {
    _fingerStartPos = details.localPosition;
  }

  void onFingerMove(DragUpdateDetails details) {
    if (_fingerStartPos != null) {
      final fingerMoved = details.localPosition - _fingerStartPos!;
      final neededMoveSize = _tileSize / 2;

      if (fingerMoved.dy.abs() > neededMoveSize ||
          fingerMoved.dx.abs() > neededMoveSize) {
        final md = moveDirection(fingerMoved); // moving direction
        final ac = activeTile(); // active tile
        final movable = canMove(md, ac);
        _fingerStartPos = null;
        if (movable) {
          final dt = destinationTile(ac, md);
          // tiles.swap(ac, dt);
          activeTileInfo = (
            tile: tiles[ac.row][ac.col]!,
            direction: md,
            destination: tiles[dt.row][dt.col]!
          );
          tileAnimationController.forward();
        }
      }
    }
  }

  bool canMove(Moving direction, ({int row, int col}) tilePos) {
    bool canMove = true;
    if (direction == Moving.left && tilePos.col == 0) {
      canMove = false; // Tile is at the left edge
    } else if (direction == Moving.right &&
        tilePos.col == level.numberOfCols - 1) {
      canMove = false; // Tile is at the right edge
    } else if (direction == Moving.up && tilePos.row == 0) {
      canMove = false; // Tile is at the top edge
    } else if (direction == Moving.down &&
        tilePos.row == level.numberOfRows - 1) {
      canMove = false; // Tile is at the bottom edge
    }
    return canMove;
  }

  Moving moveDirection(Offset moved) {
    Moving direction;

    if (moved.dx.abs() > moved.dy.abs()) {
      // Horizontal swipe
      direction = moved.dx.isNegative ? Moving.left : Moving.right;
    } else {
      // Vertical swipe
      direction = moved.dy.isNegative ? Moving.up : Moving.down;
    }
    return direction;
  }

  ({int row, int col}) activeTile() {
    int tappedX = (_fingerStartPos!.dx / _tileSize).floor();
    int tappedY = (_fingerStartPos!.dy / _tileSize).floor();
    return (row: tappedY, col: tappedX);
  }

  ({int row, int col}) destinationTile(
    ({int row, int col}) prev,
    Moving direction,
  ) {
    int newX = prev.col;
    int newY = prev.row;

    // Calculate the new position based on the direction
    if (direction == Moving.left) {
      newX--;
    } else if (direction == Moving.right) {
      newX++;
    } else if (direction == Moving.up) {
      newY--;
    } else if (direction == Moving.down) {
      newY++;
    }

    // Verify if the new position is within the array bounds
    // if (newX >= 0 && newX < columns && newY >= 0 && newY < rows) {
    //   int tileAtNewPosition = boxArray[newY][newX];
    //   print('Tile at new position: $tileAtNewPosition');
    // } else {
    //   print('New position is outside the array bounds');
    // }
    return (row: newY, col: newX);
  }
}
