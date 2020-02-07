// Copyright 2020 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'ast.dart';
import 'generator_tools.dart';

/// Generates Dart source code for the given AST represented by [root],
/// outputting the code to [sink].
void generateDart(Root root, StringSink sink) {
  final List<String> customClassNames =
      root.classes.map((Class x) => x.name).toList();
  final Indent indent = Indent(sink);
  indent.writeln('// Autogenerated from Dartle, do not edit directly.');
  indent.writeln('import \'package:flutter/services.dart\';');
  indent.writeln('');

  for (Class klass in root.classes) {
    sink.write('class ${klass.name} ');
    indent.scoped('{', '}', () {
      for (Field field in klass.fields) {
        indent.writeln('${field.dataType} ${field.name};');
      }
      indent.write('Map _toMap() ');
      indent.scoped('{', '}', () {
        indent.writeln('Map dartleMap = Map();');
        for (Field field in klass.fields) {
          indent.write('dartleMap["${field.name}"] = ');
          if (customClassNames.contains(field.dataType)) {
            indent.addln('${field.name}._toMap();');
          } else {
            indent.addln('${field.name};');
          }
        }
        indent.writeln('return dartleMap;');
      });
      indent.write('static ${klass.name} _fromMap(Map dartleMap) ');
      indent.scoped('{', '}', () {
        indent.writeln('var result = ${klass.name}();');
        for (Field field in klass.fields) {
          indent.write('result.${field.name} = ');
          if (customClassNames.contains(field.dataType)) {
            indent.addln(
                '${field.dataType}._fromMap(dartleMap["${field.name}"]);');
          } else {
            indent.addln('dartleMap["${field.name}"];');
          }
        }
        indent.writeln('return result;');
      });
    });
    indent.writeln('');
  }
  for (Api api in root.apis) {
    if (api.location == ApiLocation.host) {
      indent.write('class ${api.name} ');
      indent.scoped('{', '}', () {
        for (Method func in api.methods) {
          indent.write(
              'Future<${func.returnType}> ${func.name}(${func.argType} arg) async ');
          indent.scoped('{', '}', () {
            indent.writeln('Map requestMap = arg._toMap();');
            final String channelName = makeChannelName(api, func);
            indent.writeln('BasicMessageChannel channel =');
            indent.inc();
            indent.inc();
            indent.writeln(
                'BasicMessageChannel(\'$channelName\', StandardMessageCodec());');
            indent.dec();
            indent.dec();
            indent.writeln('Map replyMap = await channel.send(requestMap);');
            indent.writeln('return ${func.returnType}._fromMap(replyMap);');
          });
        }
      });
      indent.writeln('');
    }
  }
}
