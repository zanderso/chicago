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

import 'package:chicago/src/colors.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('brighten', () {
    test('should increase the brightness value', () {
      const Color color = Color(0xff808080); // HSV value is 0.5
      final Color brightened = brighten(color);
      final HSVColor hsv = HSVColor.fromColor(brightened);
      // Expecting value to be 0.5 + 0.1 = 0.6
      expect(hsv.value, closeTo(0.6, 0.01));
    });

    test('should not exceed a brightness value of 1.0', () {
      const Color color = Color(0xffffffff); // HSV value is 1.0
      final Color brightened = brighten(color);
      final HSVColor hsv = HSVColor.fromColor(brightened);
      expect(hsv.value, 1.0);
    });
  });

  group('darken', () {
    test('should decrease the brightness value', () {
      const Color color = Color(0xff808080); // HSV value is 0.5
      final Color darkened = darken(color);
      final HSVColor hsv = HSVColor.fromColor(darkened);
      // Expecting value to be 0.5 - 0.1 = 0.4
      expect(hsv.value, closeTo(0.4, 0.01));
    });

    test('should not go below a brightness value of 0.0', () {
      const Color color = Color(0xff000000); // HSV value is 0.0
      final Color darkened = darken(color);
      final HSVColor hsv = HSVColor.fromColor(darkened);
      expect(hsv.value, 0.0);
    });
  });
}
