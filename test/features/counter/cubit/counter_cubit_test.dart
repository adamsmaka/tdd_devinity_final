// Copyright (c) 2023, Adam Smaka
// https://smaka.dev

// will be called CounterCubit
// will have injected CounterRepository
// will have initial state with value 0 and Status.initial
// will have event called `increment`

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_devinity_final/app/core/enums.dart';
import 'package:tdd_devinity_final/features/counter/cubit/counter_cubit.dart';
import 'package:tdd_devinity_final/features/counter/domain/repository/counter_repository.dart';

class MockCounterRepository extends Mock implements CounterRepository {}

void main() {
  late CounterCubit sut;
  late CounterRepository repository;

  setUp(() {
    repository = MockCounterRepository();
    sut = CounterCubit(repository);
  });

  // has initial state with value 0 and status initial
  test('has expected initial state', () {
    expect(
      sut.state,
      CounterState(value: 0, status: Status.initial),
    );
  });

  group('increment', () {
    // verify calls repository increaseValue once
    blocTest(
      'verify repository call',
      setUp: () {
        when(() => repository.increaseValue()).thenAnswer((_) async => 0);
      },
      build: () => sut,
      act: (cubit) => cubit.increment(),
      verify: (_) {
        verify(() => repository.increaseValue()).called(1);
      },
    );

    group('on success', () {
      // emits [Status.loading] then [Status.success]
      blocTest(
        'emits [Status.loading] then [Status.success]',
        setUp: () {
          when(() => repository.increaseValue()).thenAnswer((_) async => 0);
        },
        build: () => sut,
        act: (cubit) => cubit.increment(),
        expect: () => [
          isA<CounterState>()
              .having((state) => state.status, 'status', Status.loading),
          isA<CounterState>()
              .having((state) => state.status, 'status', Status.success),
        ],
      );

      // emits value from repository
      blocTest(
        'emits value from repository',
        setUp: () {
          when(() => repository.increaseValue()).thenAnswer((_) async => 8);
        },
        build: () => sut,
        act: (cubit) => cubit.increment(),
        skip: 1, // <--- NEW
        expect: () => [
          isA<CounterState>().having((state) => state.value, 'value', 8),
        ],
      );

      blocTest(
        'emits value from repository',
        setUp: () {
          when(() => repository.increaseValue()).thenAnswer((_) async => 5);
        },
        build: () => sut,
        act: (cubit) => cubit.increment(),
        skip: 1, // <--- NEW
        expect: () => [
          isA<CounterState>().having((state) => state.value, 'value', 5),
        ],
      );
    });

    group('on error', () {
      // emits [Status.loading] then [Status.error]
      blocTest(
        'emits [Status.loading] then [Status.error]',
        setUp: () {
          when(() => repository.increaseValue()).thenThrow(Exception('oops'));
        },
        build: () => sut,
        act: (cubit) => cubit.increment(),
        expect: () => [
          isA<CounterState>()
              .having((state) => state.status, 'status', Status.loading),
          isA<CounterState>()
              .having((state) => state.status, 'status', Status.error),
        ],
      );
    });
  });
}
