class Array2d<T> {
  final List<List<T>> array;

  Array2d(int rows, int columns) : array = List<List<T>>.empty();

  List<T> operator [](int x) => array[x];

  Array2d.empty() : array = List<List<T>>.empty();
}
