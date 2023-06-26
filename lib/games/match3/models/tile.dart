import 'package:flutter/material.dart';

class Tile {
  final TileType type;
  final int row;
  final int col;
  final double x;
  final double y;
  final double size;

  Tile({
    required this.type,
    required this.row,
    required this.col,
    required this.x,
    required this.y,
    required this.size,
  });

  Widget get widget => Positioned(
        left: x,
        top: y,
        child: Image.asset(
          type.img,
          height: size,
        ),
      );
}

enum TileType {
  // forbidden,
  empty,
  red,
  green,
  blue,
  orange,
  purple;
  // wall,
  // bomb,
  // flare,
  // wrapped,
  // fireball,
  // last,

  String get img {
    const path = 'assets/match3/images/tiles';
    return switch (this) {
      red => '$path/red.png',
      green => '$path/green.png',
      blue => '$path/blue.png',
      orange => '$path/orange.png',
      purple => '$path/purple.png',
      _ => '',
    };
  }
}
