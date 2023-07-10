import 'dart:math';

import 'package:flutter_games/games/match3/models/tile.dart';

class Array2d {
  final List<List<Tile?>> array;
  final int rows;
  final int columns;

  Array2d(this.rows, this.columns)
      : array = List.generate(rows,
            (index) => List.generate(columns, (index) => null, growable: false),
            growable: false);

  List<Tile?> operator [](int x) => array[x];
  final colorsTypes = [
    TileType.blue,
    TileType.red,
    TileType.green,
    TileType.purple,
    TileType.orange
  ];

  set tile(Tile tile) => array[tile.row][tile.col] = tile;
  int get length => array.length;

  void shuffle(double tileSize) {
    print('start');
    double left = 0;
    double top = 0;
    final random = Random();
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
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
        } while (hasImmediateMatch(tt));
        tile = tt;
        print(tt);
        left += tileSize;
      }
      top += tileSize;
    }
    print('start');
  }

  void swap(Tile from, Tile to) {
    final tempTo = array[to.row][to.col]!;
    final tempFrom = array[from.row][from.col]!;
    array[to.row][to.col] = tempFrom.swapped((tempTo.row, tempTo.col));
    array[from.row][from.col] = tempTo.swapped((tempFrom.row, tempFrom.col));
  }

  void swapFall(List<({(int, int) from, (int, int) to})> fallingTiles) {
    for (var tm in fallingTiles) {
      array[tm.to.$1][tm.to.$2] = array[tm.from.$1][tm.from.$2]!.swapped(tm.to);
      array[tm.from.$1][tm.from.$2] = null;
    }
  }

  void fall(
      {required (int, int) pos,
      required double distance,
      required double value}) {
    array[pos.$1][pos.$2] = array[pos.$1][pos.$2]!.falling(
      (value * distance) / 100,
    );
  }

  bool hasImmediateMatch(Tile tile) {
    // Check for horizontal matches
    if (tile.col >= 2) {
      Tile? leftTile = array[tile.row][tile.col - 1];
      Tile? leftLeftTile = array[tile.row][tile.col - 2];

      if (tile.type == leftTile?.type && tile.type == leftLeftTile?.type) {
        return true;
      }
    }

    if (tile.col <= array[tile.row].length - 3) {
      Tile? rightTile = array[tile.row][tile.col + 1];
      Tile? rightRightTile = array[tile.row][tile.col + 2];

      if (tile.type == rightTile?.type && tile.type == rightRightTile?.type) {
        return true;
      }
    }

    // Check for vertical matches
    if (tile.row >= 2) {
      Tile? topTile = array[tile.row - 1][tile.col];
      Tile? topTopTile = array[tile.row - 2][tile.col];

      if (tile.type == topTile?.type && tile.type == topTopTile?.type) {
        return true;
      }
    }

    if (tile.row <= array.length - 3) {
      Tile? bottomTile = array[tile.row + 1][tile.col];
      Tile? bottomBottomTile = array[tile.row + 2][tile.col];

      if (tile.type == bottomTile?.type &&
          tile.type == bottomBottomTile?.type) {
        return true;
      }
    }

    return false;
  }

  Set<(int, int)> findMatches() {
    Set<(int, int)> matches = {};

    // Check for horizontal matches
    for (int row = 0; row < rows; row++) {
      for (int column = 0; column < columns - 2; column++) {
        Tile? currentTile = array[row][column];
        if (currentTile == null) continue;

        int matchLength = 1;
        while (column + matchLength < columns &&
            array[row][column + matchLength]?.type == currentTile.type) {
          matchLength++;
        }

        if (matchLength >= 3) {
          for (int i = 0; i < matchLength; i++) {
            matches.add((row, column + i));
          }
        }
      }
    }

    // Check for vertical matches
    for (int column = 0; column < columns; column++) {
      for (int row = 0; row < rows - 2; row++) {
        Tile? currentTile = array[row][column];
        if (currentTile == null) continue;

        int matchLength = 1;
        while (row + matchLength < rows &&
            array[row + matchLength][column]?.type == currentTile.type) {
          matchLength++;
        }

        if (matchLength >= 3) {
          for (int i = 0; i < matchLength; i++) {
            matches.add((row + i, column));
          }
        }
      }
    }

    return matches;
  }

  removeMatches(Set<(int, int)> matches) {
    for (final match in matches) {
      array[match.$1][match.$2] = null;
    }
  }

  List<({(int, int) from, (int, int) to})> fallingTiles() {
    final cloned = List<List<Tile?>>.from(array);
    List<({(int, int) from, (int, int) to})> fallingTiles = [];

    // Check each cell for potential falling tiles
    for (int row = 0; row < rows; row++) {
      for (int column = 0; column < columns; column++) {
        Tile? tile = array[row][column];
        if (tile == null) continue;

        int destinationRow = row;
        // Find the first available empty space below the current tile
        bool ingrid() => destinationRow < rows - 1;
        bool nextempty() => array[destinationRow + 1][column] == null;
        // bool nextmoved() => fallingTiles
        //     .any((element) => element.from == (destinationRow + 1, column));
        while (ingrid() && (nextempty())) {
          destinationRow++;
        }

        // If the tile will fall to a different position, add it to the list
        if (destinationRow != row) {
          final fallingTile =
              (from: (row, column), to: (destinationRow, column));
          fallingTiles.add(fallingTile);
        }
      }
    }

    return fallingTiles;
  }
}
