// Copyright (c) 2023, Adam Smaka
// https://smaka.dev

// will be called CounterCubit
// will have injected CounterRepository
// will have initial state with value 0 and Status.initial
// will have event called `increment`

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCounterRepository extends Mock implements CounterRepository {}

void main() {
  late CounterCubit sut;
  late CounterRepository repository;

  setUp(() {
    repository = MockCounterRepository();
    sut = CounterCubit(repository);
  });

  // has initial state with value 0 and status initial

  group('increment', () {
    // verify calls repository increaseValue once

    group('on success', () {
      // emits [Status.loading] then [Status.success]

      // emits value from repository
    });

    group('on error', () {
      // emits [Status.loading] then [Status.error]
    });
  });
}
