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
  testWidgets('Checkbox smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Checkbox(trailing: const Text('Test')),
      ),
    );

    expect(find.byType(Checkbox), findsOneWidget);
    expect(find.text('Test'), findsOneWidget);
  });

  testWidgets('Can check and uncheck', (WidgetTester tester) async {
    final CheckboxController controller = CheckboxController.simple();
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Checkbox(controller: controller),
      ),
    );

    expect(controller.checked, isFalse);

    await tester.tap(find.byType(Checkbox));
    await tester.pump();

    expect(controller.checked, isTrue);

    await tester.tap(find.byType(Checkbox));
    await tester.pump();

    expect(controller.checked, isFalse);
  });

  testWidgets('onChange callback is invoked', (WidgetTester tester) async {
    int callCount = 0;
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Checkbox(onChange: () => callCount++),
      ),
    );

    await tester.tap(find.byType(Checkbox));
    await tester.pump();

    expect(callCount, 1);
  });

  testWidgets('Tri-state checkbox cycles through states', (
    WidgetTester tester,
  ) async {
    final CheckboxController controller = CheckboxController.triState(
      canUserToggleMixed: true,
    );
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Checkbox(controller: controller),
      ),
    );

    expect(controller.state, CheckboxState.unchecked);

    await tester.tap(find.byType(Checkbox));
    await tester.pump();

    expect(controller.state, CheckboxState.mixed);

    await tester.tap(find.byType(Checkbox));
    await tester.pump();

    expect(controller.state, CheckboxState.checked);

    await tester.tap(find.byType(Checkbox));
    await tester.pump();

    expect(controller.state, CheckboxState.unchecked);
  });

  testWidgets('Checkbox is disabled', (WidgetTester tester) async {
    final CheckboxController controller = CheckboxController.simple();
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Checkbox(controller: controller, isEnabled: false),
      ),
    );

    expect(controller.checked, isFalse);

    await tester.tap(find.byType(Checkbox));
    await tester.pump();

    expect(controller.checked, isFalse);
  });
}
