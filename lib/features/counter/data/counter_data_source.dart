class CounterDataSource {
  int value = 0;
  Future<int> increaseValue() async {
    return ++value;
  }
}
