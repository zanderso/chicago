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
  testWidgets('RadioButton smoke test', (WidgetTester tester) async {
    final controller = RadioButtonController<int>(1);
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: RadioButton<int>(
          value: 1,
          controller: controller,
          trailing: const Text('Test'),
        ),
      ),
    );

    expect(find.byType(RadioButton<int>), findsOneWidget);
    expect(find.text('Test'), findsOneWidget);
  });

  testWidgets('Can select a radio button', (WidgetTester tester) async {
    final controller = RadioButtonController<int>(1);
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: RadioButton<int>(value: 2, controller: controller),
      ),
    );

    expect(controller.value, 1);

    await tester.tap(find.byType(RadioButton<int>));
    await tester.pump();

    expect(controller.value, 2);
  });

  testWidgets('Selecting one deselects another', (WidgetTester tester) async {
    final controller = RadioButtonController<String>('A');
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          children: <Widget>[
            RadioButton<String>(
              value: 'A',
              controller: controller,
              trailing: const Text('A'),
            ),
            RadioButton<String>(
              value: 'B',
              controller: controller,
              trailing: const Text('B'),
            ),
          ],
        ),
      ),
    );

    expect(controller.value, 'A');

    await tester.tap(find.text('B'), warnIfMissed: false);
    await tester.pump();

    expect(controller.value, 'B');
  });

  testWidgets('onSelected callback is invoked', (WidgetTester tester) async {
    final controller = RadioButtonController<int>(1);
    bool wasSelected = false;
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: RadioButton<int>(
          value: 2,
          controller: controller,
          onSelected: () => wasSelected = true,
        ),
      ),
    );

    await tester.tap(find.byType(RadioButton<int>));
    await tester.pump();

    expect(wasSelected, isTrue);
  });

  testWidgets('RadioButton is disabled', (WidgetTester tester) async {
    final controller = RadioButtonController<int>(1);
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: RadioButton<int>(
          value: 2,
          controller: controller,
          isEnabled: false,
        ),
      ),
    );

    expect(controller.value, 1);

    await tester.tap(find.byType(RadioButton<int>));
    await tester.pump();

    // Value should not change because the button is disabled
    expect(controller.value, 1);
  });
}
