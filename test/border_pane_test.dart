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
  testWidgets('BorderPane smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: BorderPane(child: Text('Test Content')),
      ),
    );

    expect(find.byType(BorderPane), findsOneWidget);
    expect(find.text('Test Content'), findsOneWidget);
  });

  testWidgets('BorderPane with title', (WidgetTester tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: BorderPane(title: 'Test Title', child: Text('Test Content')),
      ),
    );

    expect(find.text('Test Title'), findsOneWidget);
    expect(find.text('Test Content'), findsOneWidget);
  });

  testWidgets('BorderPane title position (LTR)', (WidgetTester tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: BorderPane(
          title: 'Test Title',
          inset: 20,
          child: Container(width: 200, height: 200),
        ),
      ),
    );

    final Offset titlePosition = tester.getTopLeft(find.text('Test Title'));
    expect(titlePosition.dx, 20);
  });

  testWidgets('BorderPane title position (RTL)', (WidgetTester tester) async {
    await tester.pumpWidget(
      Align(
        alignment: Alignment.topLeft,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SizedBox(
            width: 300,
            child: BorderPane(
              title: 'Test Title',
              inset: 20,
              child: Container(width: 200, height: 200),
            ),
          ),
        ),
      ),
    );

    final Offset titlePosition = tester.getTopRight(find.text('Test Title'));
    // Total width is 300, inset is 20 from the right edge.
    expect(titlePosition.dx, 300 - 20);
  });

  testWidgets('BorderPane child position', (WidgetTester tester) async {
    const double borderThickness = 1.0;

    await tester.pumpWidget(
      const Align(
        alignment: Alignment.topLeft,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: BorderPane(
            title: 'Test Title',
            borderThickness: borderThickness,
            child: SizedBox(key: ValueKey('child'), width: 200, height: 200),
          ),
        ),
      ),
    );

    // Get the actual height of the title widget.
    final double titleHeight = tester.getSize(find.text('Test Title')).height;

    // Calculate the expected offset of the outer container.
    final double expectedBoxDy = (titleHeight / 2).roundToDouble();

    // Get the actual position of the inner child.
    final Offset childPosition = tester.getTopLeft(
      find.byKey(const ValueKey('child')),
    );

    // The child's final position is the container's offset plus the border padding.
    expect(childPosition.dy, expectedBoxDy + borderThickness);
  });
}
