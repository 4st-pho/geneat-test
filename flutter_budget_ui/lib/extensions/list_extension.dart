extension ForEachIndexed<E> on List<E> {
  void forEachIndexed(void Function(int index, E element) action) {
    for (var index = 0; index < length; index++) {
      action(index, this[index]);
    }
  }
}

extension MapIndexed<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E element, int index) action) {
    var i = 0;
    return map((e) => action(e, i++));
  }
}
