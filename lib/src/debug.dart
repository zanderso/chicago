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

import 'package:flutter/painting.dart';

const HSVColor _kDebugDefaultRepaintColor = HSVColor.fromAHSV(
  0.4,
  60.0,
  1.0,
  1.0,
);

/// Overlay a rotating set of colors when rebuilding table cells in checked
/// mode.
///
/// See also:
///
///  * [debugRepaintRainbowEnabled], a similar flag for visualizing layer
///    repaints.
///  * [BasicTableView], [TableView], and [ScrollableTableView], which look
///    for this flag when running in debug mode.
bool debugPaintTableCellBuilds = false;

/// The current color to overlay when repainting a table cell build.
HSVColor debugCurrentTableCellColor = _kDebugDefaultRepaintColor;

/// Overlay a rotating set of colors when rebuilding list items in checked
/// mode.
///
/// See also:
///
///  * [debugRepaintRainbowEnabled], a similar flag for visualizing layer
///    repaints.
///  * [BasicListView] and [ListView], which look for this flag when running in
///    debug mode.
bool debugPaintListItemBuilds = false;

/// The current color to overlay when repainting a list item build.
HSVColor debugCurrentListItemColor = _kDebugDefaultRepaintColor;
