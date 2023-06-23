class Level {
  final int _index;
  final int _rows;
  final int _cols;
  final int _maxMoves;

  Level({
    required int level,
    required int rows,
    required int cols,
    required int moves,
  })  : _index = level,
        _rows = rows,
        _cols = cols,
        _maxMoves = moves;

  int get numberOfRows => _rows;
  int get numberOfCols => _cols;
  int get index => _index;
  int get maxMoves => _maxMoves;
}

final levels = [
  Level(level: 1, rows: 10, cols: 10, moves: 24),
  Level(level: 2, rows: 10, cols: 10, moves: 24),
  Level(level: 3, rows: 10, cols: 10, moves: 24),
  Level(level: 4, rows: 10, cols: 10, moves: 24),
  Level(level: 5, rows: 10, cols: 10, moves: 24),
];

final levelss = [
  {
    "level": 1,
    "rows": 10,
    "cols": 10,
    "grid": [
      "1,1,1,1,1,1,1,1,1,1",
      "1,1,1,1,1,1,1,1,1,1",
      "1,1,1,1,1,1,1,1,1,1",
      "1,1,1,1,1,1,1,1,1,1",
      "1,1,1,1,1,1,1,1,1,1",
      "1,1,1,1,1,1,1,1,1,1",
      "1,1,1,1,1,1,1,1,1,1",
      "1,1,1,1,1,1,1,1,1,1",
      "1,1,1,1,1,1,1,1,1,1",
      "1,1,1,1,1,1,1,1,1,1"
    ],
    "moves": 24,
    "objective": ["4;blue", "20;red", "2;bomb"]
  },
  {
    "level": 2,
    "rows": 5,
    "cols": 5,
    "grid": ["1,1,1,1,1", "X,1,1,1,X", "1,1,1,1,1", "X,1,1,1,X", "1,1,1,1,1"],
    "moves": 24,
    "objective": ["4;blue", "20;red", "2;bomb"]
  },
  {
    "level": 3,
    "rows": 10,
    "cols": 10,
    "grid": [
      "X,1,1,X,X,X,X,X,1,X",
      "1,1,1,1,1,1,1,1,1,1",
      "X,1,1,1,1,1,1,1,1,X",
      "1,1,1,W,1,1,W,1,1,1",
      "1,1,W,W,1,1,W,W,1,1",
      "1,1,1,W,1,1,W,1,1,1",
      "X,1,1,W,1,1,W,1,2,X",
      "1,1,1,1,1,1,1,1,2,1",
      "1,1,1,1,1,1,1,1,1,1",
      "X,1,1,X,X,X,X,1,1,X"
    ],
    "moves": 24,
    "objective": ["4;blue", "20;red", "2;bomb"]
  },
  {
    "level": 4,
    "rows": 10,
    "cols": 10,
    "grid": [
      "X,1,1,X,X,X,X,1,1,X",
      "1,1,1,1,1,1,1,1,1,1",
      "X,1,1,1,1,1,1,1,1,X",
      "1,1,1,1,1,1,1,1,1,1",
      "1,1,1,1,1,1,1,1,1,1",
      "1,1,1,1,1,1,1,1,1,1",
      "X,1,1,1,1,1,1,1,2,X",
      "1,1,1,1,1,1,1,1,2,1",
      "1,1,1,1,1,1,1,1,1,1",
      "X,1,1,X,X,X,X,1,1,X"
    ],
    "moves": 20,
    "objective": ["4;blue", "4;red", "4;purple", "2;flare"]
  },
  {
    "level": 5,
    "rows": 5,
    "cols": 5,
    "grid": ["X,1,X,1,X", "X,1,1,1,X", "1,1,1,1,1", "X,1,1,1,X", "X,1,X,1,X"],
    "moves": 24,
    "objective": ["4;blue", "20;red", "2;bomb"]
  }
];
