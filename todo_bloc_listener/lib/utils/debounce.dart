import 'dart:async';

class Debounce {
  final int milliseconds;
  Debounce({this.milliseconds = 1000});

  Timer? _timer;
  void run(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), callback);
  }

  void dispose() {
    _timer?.cancel();
  }
}
