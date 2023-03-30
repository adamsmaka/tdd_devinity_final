// Copyright (c) 2023, Adam Smaka
// https://smaka.dev

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_devinity_final/app/core/enums.dart';
import 'package:tdd_devinity_final/features/counter/cubit/counter_cubit.dart';
import 'package:tdd_devinity_final/features/counter/presentation/counter_page.dart';

void main() {
  // should display loading indicator on [Status.loading]
  testWidgets('should display loading indicator on [Status.loading]',
      (WidgetTester tester) async {
    final state = CounterState(status: Status.loading);
    await tester.pumpWidget(
      MaterialApp(
        home: CounterView(
          state: state,
        ),
      ),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  // should display provided value on [Status.success]
  testWidgets('should display provided value on [Status.success]',
      (WidgetTester tester) async {
    final state = CounterState(status: Status.success, value: 33333);
    await tester.pumpWidget(
      MaterialApp(
        home: CounterView(
          state: state,
        ),
      ),
    );
    expect(find.text('33333'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  // should display provided value on [Status.success]
  testWidgets('should display provided value on [Status.success]',
      (WidgetTester tester) async {
    final state = CounterState(status: Status.success, value: 44);
    await tester.pumpWidget(
      MaterialApp(
        home: CounterView(
          state: state,
        ),
      ),
    );
    expect(find.text('44'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
