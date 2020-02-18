// Copyright 2020 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'ast.dart';
import 'generator_tools.dart';

/// Options that control how Objective-C code will be generated.
class JavaOptions {
  /// The name of the class that will house all the generated classes.
  String className;

  /// The package where the generated class will live.
  String package;
}

void _writeHostApi(Indent indent, Api api) {
  assert(api.location == ApiLocation.host);
  indent.write('public interface ${api.name} ');
  indent.scoped('{', '}', () {
    for (Method func in api.methods) {
      indent.writeln('${func.returnType} ${func.name}(${func.argType} arg);');
    }
  });
  indent.write(
      'public static void ${api.name}Setup(BinaryMessenger binaryMessenger, ${api.name} api) ');
  indent.scoped('{', '}', () {
    for (Method func in api.methods) {
      final String channelName = makeChannelName(api, func);
      indent.write('');
      indent.scoped('{', '}', () {
        indent.writeln('BasicMessageChannel<Object> channel =');
        indent.inc();
        indent.inc();
        indent.writeln(
            'new BasicMessageChannel<Object>(binaryMessenger, "$channelName", new StandardMessageCodec());');
        indent.dec();
        indent.dec();
        indent.write(
            'channel.setMessageHandler(new BasicMessageChannel.MessageHandler<Object>() ');
        indent.scoped('{', '});', () {
          indent.write(
              'public void onMessage(Object message, BasicMessageChannel.Reply<Object> reply) ');
          indent.scoped('{', '}', () {
            final String argType = func.argType;
            final String returnType = func.returnType;
            indent.writeln(
                '$argType input = $argType.fromMap((HashMap)message);');
            indent.writeln('$returnType output = api.${func.name}(input);');
            indent.writeln('reply.reply(output.toMap());');
          });
        });
      });
    }
  });
}

// void _writeFlutterApi(Indent indent, Api api) {
//   assert(api.location == ApiLocation.flutter);
// }

String _makeGetter(Field field) {
  final String uppercased =
      field.name.substring(0, 1).toUpperCase() + field.name.substring(1);
  return 'get$uppercased';
}

String _makeSetter(Field field) {
  final String uppercased =
      field.name.substring(0, 1).toUpperCase() + field.name.substring(1);
  return 'set$uppercased';
}

/// Generates the ".java" file for the AST represented by [root] to [sink] with the
/// provided [options].
void generateJava(JavaOptions options, Root root, StringSink sink) {
  final Indent indent = Indent(sink);
  indent.writeln('// Autogenerated from Pigeon, do not edit directly.');
  indent.addln('');
  if (options.package != null) {
    indent.writeln('package ${options.package};');
  }
  indent.addln('');

  indent.writeln('import java.util.HashMap;');
  indent.addln('');
  indent.writeln('import io.flutter.plugin.common.BasicMessageChannel;');
  indent.writeln('import io.flutter.plugin.common.BinaryMessenger;');
  indent.writeln('import io.flutter.plugin.common.StandardMessageCodec;');

  indent.addln('');
  assert(options.className != null);
  indent.write('public class ${options.className} ');
  indent.scoped('{', '}', () {
    for (Class klass in root.classes) {
      indent.addln('');
      indent.write('public static class ${klass.name} ');
      indent.scoped('{', '}', () {
        for (Field field in klass.fields) {
          indent.writeln('private ${field.dataType} ${field.name};');
          indent.writeln(
              'public ${field.dataType} ${_makeGetter(field)}() { return ${field.name}; }');
          indent.writeln(
              'public void ${_makeSetter(field)}(${field.dataType} setterArg) { this.${field.name} = setterArg; }');
          indent.addln('');
        }
        indent.write('HashMap toMap() ');
        indent.scoped('{', '}', () {
          indent.writeln(
              'HashMap<String, Object> toMapResult = new HashMap<String, Object>();');
          for (Field field in klass.fields) {
            indent.writeln('toMapResult.put("${field.name}", ${field.name});');
          }
          indent.writeln('return toMapResult;');
        });
        indent.write('static ${klass.name} fromMap(HashMap map) ');
        indent.scoped('{', '}', () {
          indent.writeln('${klass.name} fromMapResult = new ${klass.name}();');
          for (Field field in klass.fields) {
            indent.writeln(
                'fromMapResult.${field.name} = (${field.dataType})map.get("${field.name}");');
          }
          indent.writeln('return fromMapResult;');
        });
      });
    }

    for (Api api in root.apis) {
      indent.addln('');
      if (api.location == ApiLocation.host) {
        _writeHostApi(indent, api);
      } else if (api.location == ApiLocation.flutter) {
        // _writeFlutterApi(indent, api);
      }
    }
  });
}
