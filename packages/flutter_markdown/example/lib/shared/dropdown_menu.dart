// Copyright 2020 Quiverware LLC. Open source contribution. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

// ignore_for_file: public_member_api_docs

class DropdownMenu<T> extends StatelessWidget {
  DropdownMenu({
    Key? key,
    required this.items,
    required this.initialValue,
    required this.label,
    this.labelStyle,
    Color? background,
    EdgeInsetsGeometry? padding,
    Color? menuItemBackground,
    EdgeInsetsGeometry? menuItemMargin,
    this.onChanged,
  })  : assert(
            items.isNotEmpty, 'The items map must contain at least one entry'),
        background = background ?? Colors.black12,
        padding =
            padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        menuItemBackground = menuItemBackground ?? Colors.white,
        menuItemMargin = menuItemMargin ?? const EdgeInsets.only(left: 4),
        super(key: key);

  final Map<String, T> items;

  final T initialValue;

  final String label;

  final TextStyle? labelStyle;

  final ValueChanged<T?>? onChanged;

  final Color background;

  final EdgeInsetsGeometry padding;

  final Color menuItemBackground;

  final EdgeInsetsGeometry menuItemMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: background,
      padding: padding,
      child: Row(
        children: <Widget>[
          Text(
            label,
            style: labelStyle ?? Theme.of(context).textTheme.subtitle1,
          ),
          Container(
            color: menuItemBackground,
            margin: menuItemMargin,
            child: DropdownButton<T>(
              isDense: true,
              value: initialValue,
              items: <DropdownMenuItem<T>>[
                for (String item in items.keys)
                  DropdownMenuItem<T>(
                    child: Container(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(item),
                    ),
                    value: items[item],
                  ),
              ],
              onChanged: (T? value) => onChanged!(value),
            ),
          ),
        ],
      ),
    );
  }
}
