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
  late double boardSize = _calcBoardSize();

  late final GameController _gameController = GameController(
    widget.level,
    boardSize / widget.level.numberOfCols,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    boardSize = _calcBoardSize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 253, 228),
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: Navigator.of(context).pop,
                iconSize: 35,
                icon: Image.asset('assets/match3/images/cancel.png'),
              )
            ],
          ),
          const Spacer(),
          SizedBox(
            width: boardSize,
            height: boardSize,
            child: GestureDetector(
              onPanStart: _gameController.onFingerStart,
              onPanUpdate: _gameController.onFingerMove,
              child: Stack(
                children: [
                  for (int row = 0; row < widget.level.numberOfRows; row++)
                    for (int col = 0; col < widget.level.numberOfCols; col++)
                      () {
                        final tile = _gameController.tiles[row][col];
                        if (tile != null) {
                          return tile.widget;
                        }
                        return const SizedBox.shrink();
                      }()
                ],
              ),
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }

  double _calcBoardSize() {
    final screenSize = MediaQuery.sizeOf(context);
    final desiredBoardSize = screenSize.width - 32;
    return desiredBoardSize < 550.0 ? desiredBoardSize : 550.0;
  }
}
