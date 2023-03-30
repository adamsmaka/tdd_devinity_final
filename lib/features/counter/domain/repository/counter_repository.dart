import '../../data/counter_data_source.dart';

class CounterRepository {
  final CounterDataSource dataSource;

  CounterRepository(this.dataSource);

  Future<int> increaseValue() {
    return dataSource.increaseValue();
  }
}
