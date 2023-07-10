import 'package:flutter_games/utils/array_2d.dart';
import 'package:flutter_test/flutter_test.dart';

import 'sample_tiles.dart';

void main() {
  group('Array 2d', () {
    final Array2d array2d = Array2d(10, 10);
    prefillTiles(array2d);
    test('Falling from and to position tests', () {
      final results = array2d.fallingTiles();
      print(results);
    });
  });
}
