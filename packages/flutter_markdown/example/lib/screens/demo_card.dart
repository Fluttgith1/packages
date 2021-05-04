// Copyright 2020 Quiverware LLC. Open source contribution. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import '../screens/demo_screen.dart';
import '../shared/markdown_demo_widget.dart';

// ignore_for_file: public_member_api_docs

class DemoCard extends StatelessWidget {
  const DemoCard({Key? key, required this.widget}) : super(key: key);

  final MarkdownDemoWidget widget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        DemoScreen.routeName,
        arguments: widget,
      ),
      child: Container(
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(minHeight: 50, minWidth: 425, maxWidth: 425),
          child: Card(
              color: Colors.blue,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.title,
                      style: Theme.of(context).primaryTextTheme.headline5,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      widget.description,
                      style: Theme.of(context).primaryTextTheme.bodyText1,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
