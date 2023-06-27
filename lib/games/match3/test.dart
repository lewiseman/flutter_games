import 'dart:math';

class Tile {
  String id;
  Color color;
  bool isMatched;

  Tile(this.id, this.color) : isMatched = false;
}

enum Color {
  Red,
  Green,
  Blue,
  Yellow,
  // Add more colors as needed
}

List<List<Tile>> generateInitialArray(int rows, int columns) {
  // List<List<Tile>> boxArray = List.generate(rows, (row) {
  //   return List.generate(columns, (column) {
  //     Tile tile;
  //     do {
  //       tile = Tile('$row-$column', _getRandomColor());
  //     } while (_hasImmediateMatch(boxArray, tile, row, column));
  //     return tile;
  //   });
  // });

  return [];
}

bool _hasImmediateMatch(
    List<List<Tile>> array, Tile tile, int row, int column) {
  // Check for horizontal matches
  if (column >= 2) {
    Tile leftTile = array[row][column - 1];
    Tile leftLeftTile = array[row][column - 2];

    if (tile.color == leftTile.color && tile.color == leftLeftTile.color) {
      return true;
    }
  }

  if (column <= array[row].length - 3) {
    Tile rightTile = array[row][column + 1];
    Tile rightRightTile = array[row][column + 2];

    if (tile.color == rightTile.color && tile.color == rightRightTile.color) {
      return true;
    }
  }

  // Check for vertical matches
  if (row >= 2) {
    Tile topTile = array[row - 1][column];
    Tile topTopTile = array[row - 2][column];

    if (tile.color == topTile.color && tile.color == topTopTile.color) {
      return true;
    }
  }

  if (row <= array.length - 3) {
    Tile bottomTile = array[row + 1][column];
    Tile bottomBottomTile = array[row + 2][column];

    if (tile.color == bottomTile.color &&
        tile.color == bottomBottomTile.color) {
      return true;
    }
  }

  return false;
}

Color _getRandomColor() {
  List<Color> colors = Color.values;
  return colors[Random().nextInt(colors.length)];
}

void main() {
  final int rows = 5;
  final int columns = 5;

  List<List<Tile>> boxArray = generateInitialArray(rows, columns);

  // Print the initial state of the array
  print('Initial Array:');
  for (int row = 0; row < rows; row++) {
    for (int column = 0; column < columns; column++) {
      Tile tile = boxArray[row][column];
      print('Tile (${tile.id}) - Color: ${tile.color}');
    }
  }

  // Find and remove matching tiles
  findAndRemoveMatches(boxArray, rows, columns);

  // Print the updated state of the array after removing matches
  print('\nArray after removing matches:');
  for (int row = 0; row < rows; row++) {
    for (int column = 0; column < columns; column++) {
      Tile tile = boxArray[row][column];
      print(
          'Tile (${tile.id}) - Color: ${tile.color} - Matched: ${tile.isMatched}');
    }
  }
}

void findAndRemoveMatches(List<List<Tile>> array, int rows, int columns) {
  // Check for horizontal matches
  for (int row = 0; row < rows; row++) {
    for (int column = 0; column < columns - 2; column++) {
      Tile currentTile = array[row][column];
      Tile nextTile = array[row][column + 1];
      Tile nextNextTile = array[row][column + 2];

      if (currentTile.color == nextTile.color &&
          currentTile.color == nextNextTile.color) {
        currentTile.isMatched = true;
        nextTile.isMatched = true;
        nextNextTile.isMatched = true;
      }
    }
  }

  // Check for vertical matches
  for (int row = 0; row < rows - 2; row++) {
    for (int column = 0; column < columns; column++) {
      Tile currentTile = array[row][column];
      Tile belowTile = array[row + 1][column];
      Tile belowBelowTile = array[row + 2][column];

      if (currentTile.color == belowTile.color &&
          currentTile.color == belowBelowTile.color) {
        currentTile.isMatched = true;
        belowTile.isMatched = true;
        belowBelowTile.isMatched = true;
      }
    }
  }

  // Remove matched tiles from the array
  for (int row = 0; row < rows; row++) {
    array[row].removeWhere((tile) => tile.isMatched);
  }

  // Add new tiles at the top of each column to fill the gaps
  for (int column = 0; column < columns; column++) {
    int emptyRowsCount = rows - array[column].length;
    if (emptyRowsCount > 0) {
      for (int i = 0; i < emptyRowsCount; i++) {
        array[column].insert(0, Tile('$i-$column', _getRandomColor()));
      }
    }
  }
}
