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
  testWidgets('BasicListView smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: SizedBox(
          width: 200,
          height: 200,
          child: ScrollPane(
            horizontalScrollBarPolicy: ScrollBarPolicy.stretch,
            view: BasicListView(
              length: 10,
              itemHeight: 20,
              itemBuilder: (context, index) => Text('Item $index'),
            ),
          ),
        ),
      ),
    );

    expect(find.byType(BasicListView), findsOneWidget);
    expect(find.text('Item 0').hitTestable(), findsOneWidget);
    expect(find.text('Item 9').hitTestable(), findsOneWidget);
  });

  testWidgets('BasicListView empty list', (WidgetTester tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: SizedBox(
          width: 200,
          height: 200,
          child: ScrollPane(
            horizontalScrollBarPolicy: ScrollBarPolicy.stretch,
            view: BasicListView(
              length: 0,
              itemHeight: 20,
              itemBuilder: (context, index) => Text('Item $index'),
            ),
          ),
        ),
      ),
    );

    expect(find.byType(BasicListView), findsOneWidget);
    expect(find.byType(Text), findsNothing);
  });

  testWidgets('BUG: BasicListView can scroll', (WidgetTester tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: SizedBox(
          height: 99,
          width: 200,
          child: ScrollPane(
            horizontalScrollBarPolicy: ScrollBarPolicy.stretch,
            view: BasicListView(
              length: 20,
              itemHeight: 20,
              itemBuilder: (context, index) => Text('Item $index'),
            ),
          ),
        ),
      ),
    );

    // This test will likely fail because of the underlying culling bug,
    // but is included for completeness.
    expect(find.text('Item 5').hitTestable(), findsNothing);
  }, skip: true);

  testWidgets('BUG: BasicListView builds items outside the viewport', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: SizedBox(
          height: 99,
          width: 200,
          child: ScrollPane(
            horizontalScrollBarPolicy: ScrollBarPolicy.stretch,
            view: BasicListView(
              length: 20,
              itemHeight: 20,
              itemBuilder: (context, index) => Text('Item $index'),
            ),
          ),
        ),
      ),
    );

    final RenderBasicListView renderObject = tester.renderObject(
      find.byType(BasicListView),
    );
    final List<int> builtItems = <int>[];
    renderObject.visitChildren((child) {
      final parentData = child.parentData as ListViewParentData;
      builtItems.add(parentData.index);
    });

    builtItems.sort();

    // This assertion is expected to fail, proving the bug.
    // It will likely find that items 0-5 are built, when it should only be 0-4.
    expect(builtItems, orderedEquals([0, 1, 2, 3, 4]));
  }, skip: true);
}
