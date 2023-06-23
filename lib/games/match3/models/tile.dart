class Tile {
  final TileType type;
  final int row;
  final int col;

  Tile({required this.type, required this.row, required this.col});
}

enum TileType {
  // forbidden,
  // empty,
  red,
  green,
  blue,
  orange,
  purple,
  yellow,
  // wall,
  // bomb,
  // flare,
  // wrapped,
  // fireball,
  // last,
}
