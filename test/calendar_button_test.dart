// Licensed to the Apache Software Foundation (ASF) under one or more
// contributor license agreements.  See the NOTICE file distributed with
// this work for additional information regarding copyright ownership.
// The ASF licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:chicago/chicago.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CalendarButton smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: Center(child: CalendarButton()))),
    );

    expect(find.byType(CalendarButton), findsOneWidget);
  });

  testWidgets('CalendarButton shows initial date', (WidgetTester tester) async {
    final date = const CalendarDate(2023, 4, 15); // May 15, 2023
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(child: CalendarButton(initialSelectedDate: date)),
        ),
      ),
    );

    expect(find.text('May 16, 2023'), findsOneWidget);
  });

  testWidgets('Tapping button opens calendar popup', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: Center(child: CalendarButton()))),
    );

    expect(find.byType(Calendar), findsNothing);

    await tester.tap(find.byType(CalendarButton));
    await tester.pumpAndSettle(); // Wait for popup animation

    expect(find.byType(Calendar), findsOneWidget);
  });

  testWidgets('Selecting a date in popup updates button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: CalendarButton(
              initialYear: 2023,
              initialMonth: 4, // May
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(CalendarButton));
    await tester.pumpAndSettle();

    expect(find.byType(Calendar), findsOneWidget);
    expect(find.text('May 21, 2023'), findsNothing);

    await tester.tap(find.text('21'));
    await tester.pumpAndSettle();

    expect(find.byType(Calendar), findsNothing); // Popup should be closed
    expect(
      find.text('May 21, 2023'),
      findsOneWidget,
    ); // Button text should be updated
  });

  testWidgets('onDateChanged callback is invoked', (WidgetTester tester) async {
    CalendarDate? selectedDate;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: CalendarButton(
              initialYear: 2023,
              initialMonth: 4, // May
              onDateChanged: (date) => selectedDate = date,
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(CalendarButton));
    await tester.pumpAndSettle();

    await tester.tap(find.text('21'));
    await tester.pumpAndSettle();

    expect(selectedDate, const CalendarDate(2023, 4, 20));
  });
}
