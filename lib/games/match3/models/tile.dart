import 'package:flutter/material.dart';

class Tile {
  final TileType type;
  final int row;
  final int col;
  double x;
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

  Widget get widget {
    // print('x=$x    y=$y');
    return Positioned(
      left: x,
      top: y,
      child: Image.asset(
        type.img,
        height: size,
      ),
    );
  }

  Tile move(Moving direction, double value, double total) {
    double move = (value * size) / total;
    double newX = x;
    double newY = y;
    if (direction == Moving.up) newY -= move;
    if (direction == Moving.down) newY += move;
    if (direction == Moving.left) newX -= move;
    if (direction == Moving.right) newX += move;
    return Tile(type: type, row: row, col: col, x: newX, y: newY, size: size);
  }

  Tile moveDestination(Moving direction, double value, double total) {
    double move = (value * size) / total;
    double newX = x;
    double newY = y;
    if (direction == Moving.up) newY += move;
    if (direction == Moving.down) newY -= move;
    if (direction == Moving.left) newX += move;
    if (direction == Moving.right) newX -= move;
    return Tile(type: type, row: row, col: col, x: newX, y: newY, size: size);
  }

  Tile swapped(Tile destination) {
    return Tile(
      type: type,
      row: destination.row,
      col: destination.col,
      x: x,
      y: y,
      size: size,
    );
  }
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

enum Moving { left, right, up, down }
