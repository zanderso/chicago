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

import 'dart:ui' as ui;

import 'package:chicago/chicago.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ActivityIndicator smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: ActivityIndicator(),
      ),
    );

    expect(find.byType(ActivityIndicator), findsOneWidget);
  });

  testWidgets('ActivityIndicator animates', (WidgetTester tester) async {
    final repaintBoundaryKey = GlobalKey();
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: RepaintBoundary(
          key: repaintBoundaryKey,
          child: const ActivityIndicator(),
        ),
      ),
    );

    final RenderRepaintBoundary renderRepaintBoundary =
        repaintBoundaryKey.currentContext!.findRenderObject()!
            as RenderRepaintBoundary;

    final bytes1 = await tester.runAsync(() async {
      final image = await renderRepaintBoundary.toImage();
      return image.toByteData(format: ui.ImageByteFormat.png);
    });

    await tester.pump(const Duration(milliseconds: 100));

    final bytes2 = await tester.runAsync(() async {
      final image = await renderRepaintBoundary.toImage();
      return image.toByteData(format: ui.ImageByteFormat.png);
    });

    expect(
      bytes1!.buffer.asUint8List(),
      isNot(equals(bytes2!.buffer.asUint8List())),
    );
  });

  testWidgets('ActivityIndicator has semantic label', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: ActivityIndicator(semanticLabel: 'Loading...'),
      ),
    );

    expect(find.bySemanticsLabel('Loading...'), findsOneWidget);
  });
}
