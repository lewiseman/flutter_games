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

  set tile(Tile tile) => array[tile.row][tile.col] = tile;
  int get length => array.length;

  void swap(Tile from, Tile to) {
    final tempTo = array[to.row][to.col]!;
    final tempFrom = array[from.row][from.col]!;
    array[to.row][to.col] = tempFrom.swapped(tempTo);
    array[from.row][from.col] = tempTo.swapped(tempFrom);
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
}
