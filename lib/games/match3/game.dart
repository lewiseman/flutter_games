import 'package:flutter/material.dart';
import 'package:flutter_games/games/match3/game_controller.dart';
import 'package:flutter_games/games/match3/models/level.dart';

class Game extends StatefulWidget {
  const Game({required this.level, super.key});
  final Level level;

  static void push(BuildContext context, Level level) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => Game(level: level)),
    );
  }

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  late final GameController _gameController = GameController(widget.level);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 253, 228),
      body: Column(
        children: [
          ..._gameController.grid.array.map((e) => Text('data'))
        ],
      ),
    );
  }
}
