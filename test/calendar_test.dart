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
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Calendar smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Calendar(
          initialYear: 2023,
          initialMonth: 8, // September
        ),
      ),
    );

    expect(find.byType(Calendar), findsOneWidget);
    expect(find.text('September'), findsOneWidget);
    expect(find.text('2023'), findsOneWidget);
  });

  testWidgets('Can select a date', (WidgetTester tester) async {
    final CalendarSelectionController controller =
        CalendarSelectionController();
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Calendar(
          initialYear: 2023,
          initialMonth: 8, // September
          selectionController: controller,
        ),
      ),
    );

    await tester.tap(find.text('15'));
    await tester.pump();

    expect(
      controller.value,
      const CalendarDate(2023, 8, 14),
    ); // Day is 0-indexed
  });

  testWidgets('onDateChanged callback is invoked', (WidgetTester tester) async {
    CalendarDate? selectedDate;
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Calendar(
          initialYear: 2023,
          initialMonth: 8, // September
          onDateChanged: (date) => selectedDate = date,
        ),
      ),
    );

    await tester.tap(find.text('21'));
    await tester.pump();

    expect(selectedDate, const CalendarDate(2023, 8, 20));
  });
}
