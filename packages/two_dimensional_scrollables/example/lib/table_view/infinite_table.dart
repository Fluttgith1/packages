// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

/// The class demonstrating and infinite number of rows and columns in
/// TableView.
class InfiniteTableExample extends StatefulWidget {
  /// Creates a screen that demonstrates an infinite TableView widget.
  const InfiniteTableExample({super.key});

  @override
  State<InfiniteTableExample> createState() => _InfiniteExampleState();
}

class _InfiniteExampleState extends State<InfiniteTableExample> {
  int? _rowCount;
  int? _columnCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TableView.builder(
        cellBuilder: _buildCell,
        columnCount: _columnCount,
        columnBuilder: _buildSpan,
        rowCount: _rowCount,
        rowBuilder: _buildSpan,
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: <Widget>[
        Text(
          'Column count is ${_columnCount == null ? 'infinite' : '50  '}',
          style: const TextStyle(fontStyle: FontStyle.italic),
        ),
        FilledButton(
          onPressed: () {
            setState(() {
              if (_columnCount != null) {
                _columnCount = null;
              } else {
                _columnCount = 50;
              }
            });
          },
          child: Text(
            'Make columns ${_columnCount == null ? 'fixed' : 'infinite'}',
          ),
        ),
        const SizedBox.square(dimension: 10),
        Text(
          'Row count is ${_rowCount == null ? 'infinite' : '50  '}',
          style: const TextStyle(fontStyle: FontStyle.italic),
        ),
        FilledButton(
          onPressed: () {
            setState(() {
              if (_rowCount != null) {
                _rowCount = null;
              } else {
                _rowCount = 50;
              }
            });
          },
          child: Text(
            'Make rows ${_rowCount == null ? 'fixed' : 'infinite'}',
          ),
        ),
      ],
    );
  }

  TableViewCell _buildCell(BuildContext context, TableVicinity vicinity) {
    return TableViewCell(
      child: ColoredBox(
        color: vicinity.row.isEven && vicinity.column.isOdd
            ? Colors.blueAccent[100]!
            : (vicinity.row.isOdd && vicinity.column.isEven
                ? Colors.indigo[100]!
                : Colors.white),
        child: Center(
          child: Text('${vicinity.column}:${vicinity.row}'),
        ),
      ),
    );
  }

  TableSpan _buildSpan(int index) {
    return const TableSpan(extent: FixedTableSpanExtent(100));
  }
}
