import 'dart:async';

// Creditos
// https://stackoverflow.com/a/52922130/7834829
class Debouncer<T> {
  Debouncer(
      {
//Cantidad de tiempo que yo quiero esperar antes de emitir un valor
      required this.duration,
// Método que dispararemos cuando ya tengamos un valor
      this.onValue});
  final Duration duration;
  void Function(T value)? onValue;
  T? _value;
  Timer? _timer;
  T get value => _value!;
  set value(T val) {
    _value = val;
    _timer?.cancel();
    _timer = Timer(duration, () => onValue!(_value!));
  }
}
