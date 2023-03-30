// ignore_for_file: public_member_api_docs, sort_constructors_first
// Copyright (c) 2023, Adam Smaka
// https://smaka.dev

import 'package:bloc/bloc.dart';

import '../../../app/core/enums.dart';
import '../domain/repository/counter_repository.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit(this._counterRepository) : super(CounterState());

  final CounterRepository _counterRepository;

  Future<void> increment() async {
    emit(CounterState(status: Status.loading));
    try {
      final value = await _counterRepository.increaseValue();
      emit(CounterState(status: Status.success, value: value));
    } catch (e) {
      emit(CounterState(status: Status.error));
    }
  }
}

class CounterState {
  CounterState({
    this.value = 0,
    this.status = Status.initial,
  });
  final int value;
  final Status status;

  @override
  bool operator ==(covariant CounterState other) {
    if (identical(this, other)) return true;

    return other.value == value && other.status == status;
  }

  @override
  int get hashCode => value.hashCode ^ status.hashCode;
}
