class EventProvider {
  Stream<int> intStream() {
    Duration interval = const Duration(seconds: 2);
    return Stream<int>.periodic(interval, (int count) => count++);
  }
}