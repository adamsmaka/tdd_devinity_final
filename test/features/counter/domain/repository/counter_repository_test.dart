// Copyright (c) 2023, Adam Smaka
// https://smaka.dev

// will be called CounterRepository
// will have injected CounterDataSource
// dataSource.increaseValue() will return Future<int>

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_devinity_final/features/counter/data/counter_data_source.dart';
import 'package:tdd_devinity_final/features/counter/domain/repository/counter_repository.dart';

class MockCounterDataSource extends Mock implements CounterDataSource {}

void main() {
  late CounterDataSource dataSource;
  late CounterRepository sut;

  setUp(() {
    dataSource = MockCounterDataSource();
    sut = CounterRepository(dataSource);
    when(() => dataSource.increaseValue()).thenAnswer((_) async => 5);
  });

  // should call incraseValue from data source
  test('should call incraseValue from data source', () async {
    verifyNever(() => dataSource.increaseValue());
    await sut.increaseValue();
    verify(() => dataSource.increaseValue()).called(1);
  });

  // should return value from data source
  test('should return value from data source', () async {
    final result = await sut.increaseValue();
    expect(result, 5);
  });
}
