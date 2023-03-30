// Copyright (c) 2023, Adam Smaka
// https://smaka.dev

// will be called CounterRepository
// will have injected CounterDataSource
// dataSource.increaseValue() will return Future<int>

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

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

  // should return value from data source
}
