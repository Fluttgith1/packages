// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:code_builder/code_builder.dart' as cb;
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as path;

import 'ast.dart';
import 'functional.dart';
import 'generator.dart';
import 'generator_tools.dart';

/// Documentation comment open symbol.
const String _docCommentPrefix = '///';

/// Prefix for all local variables in host API methods.
///
/// This lowers the chances of variable name collisions with
/// user defined parameters.
const String _varNamePrefix = '__pigeon_';

/// Name of field used for host API codec.
const String _pigeonChannelCodec = 'pigeonChannelCodec';

/// Documentation comment spec.
const DocumentCommentSpecification _docCommentSpec =
    DocumentCommentSpecification(_docCommentPrefix);

/// The standard codec for Flutter, used for any non custom codecs and extended for custom codecs.
const String _standardMessageCodec = 'StandardMessageCodec';

/// Options that control how Dart code will be generated.
class DartOptions {
  /// Constructor for DartOptions.
  const DartOptions({
    this.copyrightHeader,
    this.sourceOutPath,
    this.testOutPath,
  });

  /// A copyright header that will get prepended to generated code.
  final Iterable<String>? copyrightHeader;

  /// Path to output generated Dart file.
  final String? sourceOutPath;

  /// Path to output generated Test file for tests.
  final String? testOutPath;

  /// Creates a [DartOptions] from a Map representation where:
  /// `x = DartOptions.fromMap(x.toMap())`.
  static DartOptions fromMap(Map<String, Object> map) {
    final Iterable<dynamic>? copyrightHeader =
        map['copyrightHeader'] as Iterable<dynamic>?;
    return DartOptions(
      copyrightHeader: copyrightHeader?.cast<String>(),
      sourceOutPath: map['sourceOutPath'] as String?,
      testOutPath: map['testOutPath'] as String?,
    );
  }

  /// Converts a [DartOptions] to a Map representation where:
  /// `x = DartOptions.fromMap(x.toMap())`.
  Map<String, Object> toMap() {
    final Map<String, Object> result = <String, Object>{
      if (copyrightHeader != null) 'copyrightHeader': copyrightHeader!,
      if (sourceOutPath != null) 'sourceOutPath': sourceOutPath!,
      if (testOutPath != null) 'testOutPath': testOutPath!,
    };
    return result;
  }

  /// Overrides any non-null parameters from [options] into this to make a new
  /// [DartOptions].
  DartOptions merge(DartOptions options) {
    return DartOptions.fromMap(mergeMaps(toMap(), options.toMap()));
  }
}

/// Class that manages all Dart code generation.
class DartGenerator extends StructuredGenerator<DartOptions> {
  /// Instantiates a Dart Generator.
  const DartGenerator();

  @override
  void writeFilePrologue(
    DartOptions generatorOptions,
    Root root,
    Indent indent, {
    required String dartPackageName,
  }) {
    if (generatorOptions.copyrightHeader != null) {
      addLines(indent, generatorOptions.copyrightHeader!, linePrefix: '// ');
    }
    indent.writeln('// ${getGeneratedCodeWarning()}');
    indent.writeln('// $seeAlsoWarning');
    indent.writeln(
      '// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import, no_leading_underscores_for_local_identifiers',
    );
    indent.newln();
  }

  @override
  void writeFileImports(
    DartOptions generatorOptions,
    Root root,
    Indent indent, {
    required String dartPackageName,
  }) {
    indent.writeln("import 'dart:async';");
    indent.writeln(
      "import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;",
    );
    indent.newln();
    indent.writeln(
        "import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer, immutable, protected;");
    indent.writeln("import 'package:flutter/services.dart';");
    if (root.apis.any((Api api) => api is AstProxyApi)) {
      indent.writeln(
        "import 'package:flutter/widgets.dart' show WidgetsFlutterBinding;",
      );
    }
  }

  @override
  void writeEnum(
    DartOptions generatorOptions,
    Root root,
    Indent indent,
    Enum anEnum, {
    required String dartPackageName,
  }) {
    indent.newln();
    addDocumentationComments(
        indent, anEnum.documentationComments, _docCommentSpec);
    indent.write('enum ${anEnum.name} ');
    indent.addScoped('{', '}', () {
      for (final EnumMember member in anEnum.members) {
        addDocumentationComments(
            indent, member.documentationComments, _docCommentSpec);
        indent.writeln('${member.name},');
      }
    });
  }

  @override
  void writeDataClass(
    DartOptions generatorOptions,
    Root root,
    Indent indent,
    Class classDefinition, {
    required String dartPackageName,
  }) {
    indent.newln();
    addDocumentationComments(
        indent, classDefinition.documentationComments, _docCommentSpec);

    indent.write('class ${classDefinition.name} ');
    indent.addScoped('{', '}', () {
      _writeConstructor(indent, classDefinition);
      indent.newln();
      for (final NamedType field
          in getFieldsInSerializationOrder(classDefinition)) {
        addDocumentationComments(
            indent, field.documentationComments, _docCommentSpec);

        final String datatype = _addGenericTypesNullable(field.type);
        indent.writeln('$datatype ${field.name};');
        indent.newln();
      }
      writeClassEncode(
        generatorOptions,
        root,
        indent,
        classDefinition,
        dartPackageName: dartPackageName,
      );
      indent.newln();
      writeClassDecode(
        generatorOptions,
        root,
        indent,
        classDefinition,
        dartPackageName: dartPackageName,
      );
    });
  }

  void _writeConstructor(Indent indent, Class classDefinition) {
    indent.write(classDefinition.name);
    indent.addScoped('({', '});', () {
      for (final NamedType field
          in getFieldsInSerializationOrder(classDefinition)) {
        final String required =
            !field.type.isNullable && field.defaultValue == null
                ? 'required '
                : '';
        final String defaultValueString =
            field.defaultValue == null ? '' : ' = ${field.defaultValue}';
        indent.writeln('${required}this.${field.name}$defaultValueString,');
      }
    });
  }

  @override
  void writeClassEncode(
    DartOptions generatorOptions,
    Root root,
    Indent indent,
    Class classDefinition, {
    required String dartPackageName,
  }) {
    indent.write('Object encode() ');
    indent.addScoped('{', '}', () {
      indent.write(
        'return <Object?>',
      );
      indent.addScoped('[', '];', () {
        for (final NamedType field
            in getFieldsInSerializationOrder(classDefinition)) {
          final String conditional = field.type.isNullable ? '?' : '';
          if (field.type.isClass) {
            indent.writeln(
              '${field.name}$conditional.encode(),',
            );
          } else if (field.type.isEnum) {
            indent.writeln(
              '${field.name}$conditional.index,',
            );
          } else {
            indent.writeln('${field.name},');
          }
        }
      });
    });
  }

  @override
  void writeClassDecode(
    DartOptions generatorOptions,
    Root root,
    Indent indent,
    Class classDefinition, {
    required String dartPackageName,
  }) {
    void writeValueDecode(NamedType field, int index) {
      final String resultAt = 'result[$index]';
      final String castCallPrefix = field.type.isNullable ? '?' : '!';
      final String genericType = _makeGenericTypeArguments(field.type);
      final String castCall = _makeGenericCastCall(field.type);
      final String nullableTag = field.type.isNullable ? '?' : '';
      if (field.type.isClass) {
        final String nonNullValue =
            '${field.type.baseName}.decode($resultAt! as List<Object?>)';
        if (field.type.isNullable) {
          indent.format('''
$resultAt != null
\t\t? $nonNullValue
\t\t: null''', leadingSpace: false, trailingNewline: false);
        } else {
          indent.add(nonNullValue);
        }
      } else if (field.type.isEnum) {
        final String nonNullValue =
            '${field.type.baseName}.values[$resultAt! as int]';
        if (field.type.isNullable) {
          indent.format('''
$resultAt != null
\t\t? $nonNullValue
\t\t: null''', leadingSpace: false, trailingNewline: false);
        } else {
          indent.add(nonNullValue);
        }
      } else if (field.type.typeArguments.isNotEmpty) {
        indent.add(
          '($resultAt as $genericType?)$castCallPrefix$castCall',
        );
      } else {
        final String castCallForcePrefix = field.type.isNullable ? '' : '!';
        final String castString = field.type.baseName == 'Object'
            ? ''
            : ' as $genericType$nullableTag';

        indent.add(
          '$resultAt$castCallForcePrefix$castString',
        );
      }
    }

    indent.write(
      'static ${classDefinition.name} decode(Object result) ',
    );
    indent.addScoped('{', '}', () {
      indent.writeln('result as List<Object?>;');
      indent.write('return ${classDefinition.name}');
      indent.addScoped('(', ');', () {
        enumerate(getFieldsInSerializationOrder(classDefinition),
            (int index, final NamedType field) {
          indent.write('${field.name}: ');
          writeValueDecode(field, index);
          indent.addln(',');
        });
      });
    });
  }

  /// Writes the code for host [Api], [api].
  /// Example:
  /// class FooCodec extends StandardMessageCodec {...}
  ///
  /// abstract class Foo {
  ///   static const MessageCodec<Object?> codec = FooCodec();
  ///   int add(int x, int y);
  ///   static void setup(Foo api, {BinaryMessenger? binaryMessenger}) {...}
  /// }
  @override
  void writeFlutterApi(
    DartOptions generatorOptions,
    Root root,
    Indent indent,
    AstFlutterApi api, {
    String Function(Method)? channelNameFunc,
    bool isMockHandler = false,
    required String dartPackageName,
  }) {
    String codecName = _standardMessageCodec;
    if (getCodecClasses(api, root).isNotEmpty) {
      codecName = _getCodecName(api);
      _writeCodec(indent, codecName, api, root);
    }
    indent.newln();
    addDocumentationComments(
        indent, api.documentationComments, _docCommentSpec);

    indent.write('abstract class ${api.name} ');
    indent.addScoped('{', '}', () {
      if (isMockHandler) {
        indent.writeln(
            'static TestDefaultBinaryMessengerBinding? get _testBinaryMessengerBinding => TestDefaultBinaryMessengerBinding.instance;');
      }
      indent.writeln(
          'static const MessageCodec<Object?> $_pigeonChannelCodec = $codecName();');
      indent.newln();
      for (final Method func in api.methods) {
        addDocumentationComments(
            indent, func.documentationComments, _docCommentSpec);

        final bool isAsync = func.isAsynchronous;
        final String returnType = isAsync
            ? 'Future<${_addGenericTypesNullable(func.returnType)}>'
            : _addGenericTypesNullable(func.returnType);
        final String argSignature = _getMethodParameterSignature(func);
        indent.writeln('$returnType ${func.name}($argSignature);');
        indent.newln();
      }
      indent.write(
          'static void setup(${api.name}? api, {BinaryMessenger? binaryMessenger}) ');
      indent.addScoped('{', '}', () {
        for (final Method func in api.methods) {
          indent.write('');
          indent.addScoped('{', '}', () {
            indent.writeln(
              'final BasicMessageChannel<Object?> ${_varNamePrefix}channel = BasicMessageChannel<Object?>(',
            );
            final String channelName = channelNameFunc == null
                ? makeChannelName(api, func, dartPackageName)
                : channelNameFunc(func);
            indent.nest(2, () {
              indent.writeln("'$channelName', $_pigeonChannelCodec,");
              indent.writeln(
                'binaryMessenger: binaryMessenger);',
              );
            });
            final String messageHandlerSetterWithOpeningParentheses = isMockHandler
                ? '_testBinaryMessengerBinding!.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(${_varNamePrefix}channel, '
                : '${_varNamePrefix}channel.setMessageHandler(';
            indent.write('if (api == null) ');
            indent.addScoped('{', '}', () {
              indent.writeln(
                  '${messageHandlerSetterWithOpeningParentheses}null);');
            }, addTrailingNewline: false);
            indent.add(' else ');
            indent.addScoped('{', '}', () {
              indent.write(
                '$messageHandlerSetterWithOpeningParentheses(Object? message) async ',
              );
              indent.addScoped('{', '});', () {
                final String returnType =
                    _addGenericTypesNullable(func.returnType);
                final bool isAsync = func.isAsynchronous;
                const String emptyReturnStatement =
                    'return wrapResponse(empty: true);';
                String call;
                if (func.parameters.isEmpty) {
                  call = 'api.${func.name}()';
                } else {
                  indent.writeln('assert(message != null,');
                  indent.writeln("'Argument for $channelName was null.');");
                  const String argsArray = 'args';
                  indent.writeln(
                      'final List<Object?> $argsArray = (message as List<Object?>?)!;');
                  String argNameFunc(int index, NamedType type) =>
                      _getSafeArgumentName(index, type);
                  enumerate(func.parameters, (int count, NamedType arg) {
                    final String argType = _addGenericTypes(arg.type);
                    final String argName = argNameFunc(count, arg);
                    final String genericArgType =
                        _makeGenericTypeArguments(arg.type);
                    final String castCall = _makeGenericCastCall(arg.type);

                    final String leftHandSide = 'final $argType? $argName';
                    if (arg.type.isEnum) {
                      indent.writeln(
                          '$leftHandSide = $argsArray[$count] == null ? null : $argType.values[$argsArray[$count]! as int];');
                    } else {
                      indent.writeln(
                          '$leftHandSide = ($argsArray[$count] as $genericArgType?)${castCall.isEmpty ? '' : '?$castCall'};');
                    }
                    if (!arg.type.isNullable) {
                      indent.writeln('assert($argName != null,');
                      indent.writeln(
                          "    'Argument for $channelName was null, expected non-null $argType.');");
                    }
                  });
                  final Iterable<String> argNames =
                      indexMap(func.parameters, (int index, NamedType field) {
                    final String name = _getSafeArgumentName(index, field);
                    return '$name${field.type.isNullable ? '' : '!'}';
                  });
                  call = 'api.${func.name}(${argNames.join(', ')})';
                }
                indent.writeScoped('try {', '} ', () {
                  if (func.returnType.isVoid) {
                    if (isAsync) {
                      indent.writeln('await $call;');
                    } else {
                      indent.writeln('$call;');
                    }
                    indent.writeln(emptyReturnStatement);
                  } else {
                    if (isAsync) {
                      indent.writeln('final $returnType output = await $call;');
                    } else {
                      indent.writeln('final $returnType output = $call;');
                    }

                    const String returnExpression = 'output';
                    final String nullability =
                        func.returnType.isNullable ? '?' : '';
                    final String valueExtraction =
                        func.returnType.isEnum ? '$nullability.index' : '';
                    final String returnStatement = isMockHandler
                        ? 'return <Object?>[$returnExpression$valueExtraction];'
                        : 'return wrapResponse(result: $returnExpression$valueExtraction);';
                    indent.writeln(returnStatement);
                  }
                }, addTrailingNewline: false);
                indent.addScoped('on PlatformException catch (e) {', '}', () {
                  indent.writeln('return wrapResponse(error: e);');
                }, addTrailingNewline: false);

                indent.writeScoped('catch (e) {', '}', () {
                  indent.writeln(
                      "return wrapResponse(error: PlatformException(code: 'error', message: e.toString()));");
                });
              });
            });
          });
        }
      });
    });
  }

  /// Writes the code for host [Api], [api].
  /// Example:
  /// class FooCodec extends StandardMessageCodec {...}
  ///
  /// class Foo {
  ///   Foo(BinaryMessenger? binaryMessenger) {}
  ///   static const MessageCodec<Object?> codec = FooCodec();
  ///   Future<int> add(int x, int y) async {...}
  /// }
  ///
  /// Messages will be sent and received in a list.
  ///
  /// If the message received was successful,
  /// the result will be contained at the 0'th index.
  ///
  /// If the message was a failure, the list will contain 3 items:
  /// a code, a message, and details in that order.
  @override
  void writeHostApi(
    DartOptions generatorOptions,
    Root root,
    Indent indent,
    AstHostApi api, {
    required String dartPackageName,
  }) {
    String codecName = _standardMessageCodec;
    if (getCodecClasses(api, root).isNotEmpty) {
      codecName = _getCodecName(api);
      _writeCodec(indent, codecName, api, root);
    }
    indent.newln();
    bool first = true;
    addDocumentationComments(
        indent, api.documentationComments, _docCommentSpec);
    indent.write('class ${api.name} ');
    indent.addScoped('{', '}', () {
      indent.format('''
/// Constructor for [${api.name}].  The [binaryMessenger] named argument is
/// available for dependency injection.  If it is left null, the default
/// BinaryMessenger will be used which routes to the host platform.
${api.name}({BinaryMessenger? binaryMessenger})
\t\t: ${_varNamePrefix}binaryMessenger = binaryMessenger;
final BinaryMessenger? ${_varNamePrefix}binaryMessenger;
''');

      indent.writeln(
          'static const MessageCodec<Object?> $_pigeonChannelCodec = $codecName();');
      indent.newln();
      for (final Method func in api.methods) {
        if (!first) {
          indent.newln();
        } else {
          first = false;
        }
        addDocumentationComments(
            indent, func.documentationComments, _docCommentSpec);
        String argSignature = '';
        String sendArgument = 'null';
        if (func.parameters.isNotEmpty) {
          final Iterable<String> argExpressions =
              indexMap(func.parameters, (int index, NamedType type) {
            final String name = _getParameterName(index, type);
            if (type.type.isEnum) {
              return '$name${type.type.isNullable ? '?' : ''}.index';
            } else {
              return name;
            }
          });
          sendArgument = '<Object?>[${argExpressions.join(', ')}]';
          argSignature = _getMethodParameterSignature(func);
        }
        indent.write(
          'Future<${_addGenericTypesNullable(func.returnType)}> ${func.name}($argSignature) async ',
        );
        indent.addScoped('{', '}', () {
          indent.writeln(
              "const String ${_varNamePrefix}channelName = '${makeChannelName(api, func, dartPackageName)}';");
          indent.writeScoped(
              'final BasicMessageChannel<Object?> ${_varNamePrefix}channel = BasicMessageChannel<Object?>(',
              ');', () {
            indent.writeln('${_varNamePrefix}channelName,');
            indent.writeln('$_pigeonChannelCodec,');
            indent
                .writeln('binaryMessenger: ${_varNamePrefix}binaryMessenger,');
          });
          final String returnType = _makeGenericTypeArguments(func.returnType);
          final String genericCastCall = _makeGenericCastCall(func.returnType);
          const String accessor = '${_varNamePrefix}replyList[0]';
          // Avoid warnings from pointlessly casting to `Object?`.
          final String nullablyTypedAccessor =
              returnType == 'Object' ? accessor : '($accessor as $returnType?)';
          final String nullHandler = func.returnType.isNullable
              ? (genericCastCall.isEmpty ? '' : '?')
              : '!';
          String returnStatement = 'return';
          if (func.returnType.isEnum) {
            if (func.returnType.isNullable) {
              returnStatement =
                  '$returnStatement ($accessor as int?) == null ? null : $returnType.values[$accessor! as int]';
            } else {
              returnStatement =
                  '$returnStatement $returnType.values[$accessor! as int]';
            }
          } else if (!func.returnType.isVoid) {
            returnStatement =
                '$returnStatement $nullablyTypedAccessor$nullHandler$genericCastCall';
          }
          returnStatement = '$returnStatement;';

          indent.format('''
final List<Object?>? ${_varNamePrefix}replyList =
\t\tawait ${_varNamePrefix}channel.send($sendArgument) as List<Object?>?;
if (${_varNamePrefix}replyList == null) {
\tthrow _createConnectionError(${_varNamePrefix}channelName);
} else if (${_varNamePrefix}replyList.length > 1) {
\tthrow PlatformException(
\t\tcode: ${_varNamePrefix}replyList[0]! as String,
\t\tmessage: ${_varNamePrefix}replyList[1] as String?,
\t\tdetails: ${_varNamePrefix}replyList[2],
\t);''');
          // On iOS we can return nil from functions to accommodate error
          // handling.  Returning a nil value and not returning an error is an
          // exception.
          if (!func.returnType.isNullable && !func.returnType.isVoid) {
            indent.format('''
} else if (${_varNamePrefix}replyList[0] == null) {
\tthrow PlatformException(
\t\tcode: 'null-error',
\t\tmessage: 'Host platform returned null value for non-null return value.',
\t);''');
          }
          indent.format('''
} else {
\t$returnStatement
}''');
        });
      }
    });
  }

  @override
  void writeInstanceManager(
    DartOptions generatorOptions,
    Root root,
    Indent indent, {
    required String dartPackageName,
  }) {
    final Iterable<String> apiHandlerSetups =
        root.apis.whereType<AstProxyApi>().map(
      (AstProxyApi api) {
        return '${api.name}.\$setUpMessageHandlers(\$instanceManager: instanceManager);';
      },
    );
    indent.format('''
/// An immutable object that can provide functional copies of itself.
///
/// All implementers are expected to be immutable as defined by the annotation.
@immutable
mixin \$Copyable {
  /// Instantiates and returns a functionally identical object to oneself.
  ///
  /// Outside of tests, this method should only ever be called by
  /// [\$InstanceManager].
  ///
  /// Subclasses should always override their parent's implementation of this
  /// method.
  @protected
  \$Copyable \$copy();
}

/// Maintains instances used to communicate with the native objects they
/// represent.
///
/// Added instances are stored as weak references and their copies are stored
/// as strong references to maintain access to their variables and callback
/// methods. Both are stored with the same identifier.
///
/// When a weak referenced instance becomes inaccessible,
/// [onWeakReferenceRemoved] is called with its associated identifier.
///
/// If an instance is retrieved and has the possibility to be used,
/// (e.g. calling [getInstanceWithWeakReference]) a copy of the strong reference
/// is added as a weak reference with the same identifier. This prevents a
/// scenario where the weak referenced instance was released and then later
/// returned by the host platform.
class \$InstanceManager {
  /// Constructs an [\$InstanceManager].
  \$InstanceManager({required void Function(int) onWeakReferenceRemoved}) {
    this.onWeakReferenceRemoved = (int identifier) {
      _weakInstances.remove(identifier);
      onWeakReferenceRemoved(identifier);
    };
    _finalizer = Finalizer<int>(this.onWeakReferenceRemoved);
  }

  // Identifiers are locked to a specific range to avoid collisions with objects
  // created simultaneously by the host platform.
  // Host uses identifiers >= 2^16 and Dart is expected to use values n where,
  // 0 <= n < 2^16.
  static const int _maxDartCreatedIdentifier = 65536;

  static final \$InstanceManager instance = _initInstance();

  // Expando is used because it doesn't prevent its keys from becoming
  // inaccessible. This allows the manager to efficiently retrieve an identifier
  // of an instance without holding a strong reference to that instance.
  //
  // It also doesn't use `==` to search for identifiers, which would lead to an
  // infinite loop when comparing an object to its copy. (i.e. which was caused
  // by calling instanceManager.getIdentifier() inside of `==` while this was a
  // HashMap).
  final Expando<int> _identifiers = Expando<int>();
  final Map<int, WeakReference<\$Copyable>> _weakInstances =
      <int, WeakReference<\$Copyable>>{};
  final Map<int, \$Copyable> _strongInstances = <int, \$Copyable>{};
  late final Finalizer<int> _finalizer;
  int _nextIdentifier = 0;

  /// Called when a weak referenced instance is removed by [removeWeakReference]
  /// or becomes inaccessible.
  late final void Function(int) onWeakReferenceRemoved;

  static \$InstanceManager _initInstance() {
    WidgetsFlutterBinding.ensureInitialized();
    final _InstanceManagerApi api = _InstanceManagerApi();
    // Clears the native `InstanceManager` on the initial use of the Dart one.
    api.clear();
    final \$InstanceManager instanceManager = \$InstanceManager(
      onWeakReferenceRemoved: (int identifier) {
        api.removeStrongReference(identifier);
      },
    );
    _InstanceManagerApi.\$setUpMessageHandlers(instanceManager: instanceManager);
    ${apiHandlerSetups.join('\n\t\t')}
    return instanceManager;
  }

  /// Adds a new instance that was instantiated by Dart.
  ///
  /// In other words, Dart wants to add a new instance that will represent
  /// an object that will be instantiated on the host platform.
  ///
  /// Throws assertion error if the instance has already been added.
  ///
  /// Returns the randomly generated id of the [instance] added.
  int addDartCreatedInstance(\$Copyable instance) {
    final int identifier = _nextUniqueIdentifier();
    _addInstanceWithIdentifier(instance, identifier);
    return identifier;
  }

  /// Removes the instance, if present, and call [onWeakReferenceRemoved] with
  /// its identifier.
  ///
  /// Returns the identifier associated with the removed instance. Otherwise,
  /// `null` if the instance was not found in this manager.
  ///
  /// This does not remove the strong referenced instance associated with
  /// [instance]. This can be done with [remove].
  int? removeWeakReference(\$Copyable instance) {
    final int? identifier = getIdentifier(instance);
    if (identifier == null) {
      return null;
    }

    _identifiers[instance] = null;
    _finalizer.detach(instance);
    onWeakReferenceRemoved(identifier);

    return identifier;
  }

  /// Removes [identifier] and its associated strongly referenced instance, if
  /// present, from the manager.
  ///
  /// Returns the strong referenced instance associated with [identifier] before
  /// it was removed. Returns `null` if [identifier] was not associated with
  /// any strong reference.
  ///
  /// This does not remove the weak referenced instance associated with
  /// [identifier]. This can be done with [removeWeakReference].
  T? remove<T extends \$Copyable>(int identifier) {
    return _strongInstances.remove(identifier) as T?;
  }

  /// Retrieves the instance associated with identifier.
  ///
  /// The value returned is chosen from the following order:
  ///
  /// 1. A weakly referenced instance associated with identifier.
  /// 2. If the only instance associated with identifier is a strongly
  /// referenced instance, a copy of the instance is added as a weak reference
  /// with the same identifier. Returning the newly created copy.
  /// 3. If no instance is associated with identifier, returns null.
  ///
  /// This method also expects the host `InstanceManager` to have a strong
  /// reference to the instance the identifier is associated with.
  T? getInstanceWithWeakReference<T extends \$Copyable>(int identifier) {
    final \$Copyable? weakInstance = _weakInstances[identifier]?.target;

    if (weakInstance == null) {
      final \$Copyable? strongInstance = _strongInstances[identifier];
      if (strongInstance != null) {
        final \$Copyable copy = strongInstance.\$copy();
        _identifiers[copy] = identifier;
        _weakInstances[identifier] = WeakReference<\$Copyable>(copy);
        _finalizer.attach(copy, identifier, detach: copy);
        return copy as T;
      }
      return strongInstance as T?;
    }

    return weakInstance as T;
  }

  /// Retrieves the identifier associated with instance.
  int? getIdentifier(\$Copyable instance) {
    return _identifiers[instance];
  }

  /// Adds a new instance that was instantiated by the host platform.
  ///
  /// In other words, the host platform wants to add a new instance that
  /// represents an object on the host platform. Stored with [identifier].
  ///
  /// Throws assertion error if the instance or its identifier has already been
  /// added.
  ///
  /// Returns unique identifier of the [instance] added.
  void addHostCreatedInstance(\$Copyable instance, int identifier) {
    _addInstanceWithIdentifier(instance, identifier);
  }

  void _addInstanceWithIdentifier(\$Copyable instance, int identifier) {
    assert(!containsIdentifier(identifier));
    assert(getIdentifier(instance) == null);
    assert(identifier >= 0);

    _identifiers[instance] = identifier;
    _weakInstances[identifier] = WeakReference<\$Copyable>(instance);
    _finalizer.attach(instance, identifier, detach: instance);

    final \$Copyable copy = instance.\$copy();
    _identifiers[copy] = identifier;
    _strongInstances[identifier] = copy;
  }

  /// Whether this manager contains the given [identifier].
  bool containsIdentifier(int identifier) {
    return _weakInstances.containsKey(identifier) ||
        _strongInstances.containsKey(identifier);
  }

  int _nextUniqueIdentifier() {
    late int identifier;
    do {
      identifier = _nextIdentifier;
      _nextIdentifier = (_nextIdentifier + 1) % _maxDartCreatedIdentifier;
    } while (containsIdentifier(identifier));
    return identifier;
  }
}
''');
  }

  @override
  void writeInstanceManagerApi(
    DartOptions generatorOptions,
    Root root,
    Indent indent, {
    required String dartPackageName,
  }) {
    final String removeStrongReferenceName = makeChannelNameWithStrings(
      apiName: r'$InstanceManagerApi',
      methodName: 'removeStrongReference',
      dartPackageName: dartPackageName,
    );
    final String clearName = makeChannelNameWithStrings(
      apiName: r'$InstanceManagerApi',
      methodName: 'clear',
      dartPackageName: dartPackageName,
    );

    indent.writeln('''
/// Generated API for managing the Dart and native `InstanceManager`s.
class _InstanceManagerApi {
  /// Constructor for [_InstanceManagerApi].
  ///
  /// The [binaryMessenger] named argument is available for dependency
  /// injection. If it is left null, the default [BinaryMessenger] will be used
  /// which routes to the host platform.
  _InstanceManagerApi({BinaryMessenger? binaryMessenger})
      : _binaryMessenger = binaryMessenger;

  final BinaryMessenger? _binaryMessenger;
  
  static const MessageCodec<Object?> $_pigeonChannelCodec =
     StandardMessageCodec();

  static void \$setUpMessageHandlers({
    BinaryMessenger? binaryMessenger,
    \$InstanceManager? instanceManager,
  }) {
    const String channelName =
        r'$removeStrongReferenceName';
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
      channelName,
      $_pigeonChannelCodec,
      binaryMessenger: binaryMessenger,
    );
    channel.setMessageHandler((Object? message) async {
      assert(
        message != null,
        'Argument for \$channelName was null.',
      );
      final int? identifier = message as int?;
      assert(
        identifier != null,
        r'Argument for \$channelName, expected non-null int.',
      );
      (instanceManager ?? \$InstanceManager.instance).remove(identifier!);
      return;
    });
  }

  Future<void> removeStrongReference(int identifier) async {
    const String channelName =
        r'$removeStrongReferenceName';
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
      channelName,
      $_pigeonChannelCodec,
      binaryMessenger: _binaryMessenger,
    );
    final List<Object?>? replyList =
        await channel.send(identifier) as List<Object?>?;
    if (replyList == null) {
      throw _createConnectionError(channelName);
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  /// Clear the native `InstanceManager`.
  ///
  /// This is typically called after a hot restart.
  Future<void> clear() async {
    const String channelName =
        r'$clearName';
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
      channelName,
      $_pigeonChannelCodec,
      binaryMessenger: _binaryMessenger,
    );
    final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw _createConnectionError(channelName);
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }
}''');
  }

  @override
  void writeProxyApi(
    DartOptions generatorOptions,
    Root root,
    Indent indent,
    AstProxyApi api, {
    required String dartPackageName,
  }) {
    final String codecName = _getCodecName(api);
    final String codecInstanceName = '_codec${api.name}';

    // codec
    indent.writeln('''
class $codecName extends StandardMessageCodec {
 const $codecName(this.instanceManager);

 final \$InstanceManager instanceManager;

 @override
 void writeValue(WriteBuffer buffer, Object? value) {
   if (value is \$Copyable) {
     buffer.putUint8(128);
     writeValue(buffer, instanceManager.getIdentifier(value));
   } else {
     super.writeValue(buffer, value);
   }
 }

 @override
 Object? readValueOfType(int type, ReadBuffer buffer) {
   switch (type) {
     case 128:
       return instanceManager
           .getInstanceWithWeakReference(readValue(buffer)! as int);
     default:
       return super.readValueOfType(type, buffer);
   }
 }
}
''');

    final Iterable<AstProxyApi> allProxyApis =
        root.apis.whereType<AstProxyApi>();

    final List<AstProxyApi> superClassApisChain =
        recursiveGetSuperClassApisChain(
      api,
      allProxyApis,
    );

    final AstProxyApi? superClassApi =
        superClassApisChain.isNotEmpty ? superClassApisChain.first : null;

    final Set<AstProxyApi> interfacesApis = recursiveFindAllInterfacesApis(
      api.interfacesNames,
      allProxyApis,
    );

    final List<Method> interfacesMethods = <Method>[];
    for (final AstProxyApi proxyApi in interfacesApis) {
      interfacesMethods.addAll(proxyApi.methods);
    }

    // A list of inherited methods from super classes that constructors set with
    // `super.<methodName>`.
    final List<Method> superClassFlutterMethods = <Method>[];
    if (superClassApi != null) {
      for (final AstProxyApi proxyApi in superClassApisChain) {
        for (final Method method in proxyApi.methods) {
          if (method.location == ApiLocation.flutter) {
            superClassFlutterMethods.add(method);
          }
        }
      }

      final Set<AstProxyApi> superClassInterfacesApis =
          recursiveFindAllInterfacesApis(
        superClassApi.interfacesNames,
        allProxyApis,
      );
      for (final AstProxyApi proxyApi in superClassInterfacesApis) {
        superClassFlutterMethods.addAll(proxyApi.methods);
      }
    }

    final bool hasARequiredFlutterMethod = api.methods
        .followedBy(superClassFlutterMethods)
        .followedBy(interfacesMethods)
        .any((Method method) {
      return method.location == ApiLocation.flutter && method.required;
    });

    final cb.Class proxyApi = cb.Class(
      (cb.ClassBuilder builder) => builder
        ..name = api.name
        ..extend = _referOrNull(superClassApi?.name)
        ..implements.addAll(<cb.Reference>[
          if (api.interfacesNames.isNotEmpty)
            ...api.interfacesNames.map((String name) => cb.refer(name))
          else
            cb.refer(r'$Copyable')
        ])
        ..docs.addAll(asDocumentationComments(
          api.documentationComments,
          _docCommentSpec,
        ))
        ..constructors.addAll(_proxyApiConstructors(
          api.constructors,
          apiName: api.name,
          dartPackageName: dartPackageName,
          codecInstanceName: codecInstanceName,
          superClassApi: superClassApi,
          nonAttachedFields: api.nonAttachedFields,
          superClassFlutterMethods: superClassFlutterMethods,
          interfacesMethods: interfacesMethods,
          flutterMethods: api.flutterMethods,
        ))
        ..fields.addAll(_proxyApiFields(
          nonAttachedFields: api.nonAttachedFields,
          attachedFields: api.attachedFields,
          apiName: api.name,
          dartPackageName: dartPackageName,
          codecInstanceName: codecInstanceName,
          codecName: codecName,
          interfacesApis: interfacesApis,
          flutterMethods: api.flutterMethods,
          hasSuperClass: superClassApi != null,
          referencesCodecInstance: api.hostMethods.isNotEmpty ||
              api.constructors.isNotEmpty ||
              api.attachedFields.any((Field field) => !field.isStatic),
        ))
        ..methods.addAll(_proxyApiMethods(
          hostMethods: api.hostMethods,
          flutterMethods: api.flutterMethods,
          superClassFlutterMethods: superClassFlutterMethods,
          apiName: api.name,
          dartPackageName: dartPackageName,
          codecInstanceName: codecInstanceName,
          codecName: codecName,
          nonAttachedFields: api.nonAttachedFields,
          attachedFields: api.attachedFields,
          interfacesApis: interfacesApis,
          hasARequiredFlutterMethod: hasARequiredFlutterMethod,
        )),
    );

    final cb.DartEmitter emitter = cb.DartEmitter(useNullSafetySyntax: true);
    indent.writeln(DartFormatter().format('${proxyApi.accept(emitter)}'));
  }

  Iterable<cb.Constructor> _proxyApiConstructors(
    Iterable<Constructor> constructors, {
    required String apiName,
    required String dartPackageName,
    required String codecInstanceName,
    required AstProxyApi? superClassApi,
    required Iterable<Field> nonAttachedFields,
    required Iterable<Method> superClassFlutterMethods,
    required Iterable<Method> interfacesMethods,
    required Iterable<Method> flutterMethods,
  }) {
    return <cb.Constructor>[
      ...constructors.map(
        (Constructor constructor) => cb.Constructor(
          (cb.ConstructorBuilder builder) {
            final String channelName = makeChannelNameWithStrings(
              apiName: apiName,
              methodName: constructor.name.isNotEmpty
                  ? constructor.name
                  : r'$defaultConstructor',
              dartPackageName: dartPackageName,
            );
            builder
              ..name = constructor.name.isNotEmpty ? constructor.name : null
              ..docs.addAll(asDocumentationComments(
                constructor.documentationComments,
                _docCommentSpec,
              ))
              ..optionalParameters.addAll(
                <cb.Parameter>[
                  cb.Parameter(
                    (cb.ParameterBuilder builder) => builder
                      ..name = r'$binaryMessenger'
                      ..named = true
                      ..toSuper = superClassApi != null
                      ..toThis = superClassApi == null,
                  ),
                  cb.Parameter((cb.ParameterBuilder builder) => builder
                    ..name = r'$instanceManager'
                    ..type = _referOrNull(
                      superClassApi == null ? r'$InstanceManager' : null,
                      isNullable: true,
                    )
                    ..named = true
                    ..toSuper = superClassApi != null),
                  for (final Field field in nonAttachedFields)
                    cb.Parameter(
                      (cb.ParameterBuilder builder) => builder
                        ..name = field.name
                        ..named = true
                        ..toThis = true
                        ..required = !field.type.isNullable,
                    ),
                  for (final Method method in superClassFlutterMethods)
                    cb.Parameter(
                      (cb.ParameterBuilder builder) => builder
                        ..name = method.name
                        ..named = true
                        ..toSuper = true
                        ..required = method.required,
                    ),
                  for (final Method method in interfacesMethods)
                    cb.Parameter(
                      (cb.ParameterBuilder builder) => builder
                        ..name = method.name
                        ..named = true
                        ..toThis = true
                        ..required = method.required,
                    ),
                  for (final Method method in flutterMethods)
                    cb.Parameter(
                      (cb.ParameterBuilder builder) => builder
                        ..name = method.name
                        ..named = true
                        ..toThis = true
                        ..required = method.required,
                    ),
                  ...indexMap(
                    constructor.parameters,
                    (int index, NamedType parameter) => cb.Parameter(
                      (cb.ParameterBuilder builder) => builder
                        ..name = _getParameterName(index, parameter)
                        ..type = cb.refer(
                          _addGenericTypesNullable(parameter.type),
                        )
                        ..named = true
                        ..required = !parameter.type.isNullable,
                    ),
                  ),
                ],
              )
              ..initializers.add(
                cb.Code(
                  superClassApi != null
                      ? r'super.$detached()'
                      : r'$instanceManager = $instanceManager ?? $InstanceManager.instance',
                ),
              )
              ..body = cb.Block.of(<cb.Code>[
                cb.Code(
                  "const String ${_varNamePrefix}channelName = r'$channelName';",
                ),
                _basicMessageChannel(
                  codec: cb.refer(codecInstanceName),
                  binaryMessenger: cb.refer(r'$binaryMessenger'),
                ),
                cb
                    .refer('${_varNamePrefix}channel.send')
                    .call(<cb.Expression>[
                      cb.literalList(
                        <Object?>[
                          cb.refer(
                            '${superClassApi != null ? '' : 'this.'}\$instanceManager.addDartCreatedInstance(this)',
                          ),
                          ...indexMap(
                            nonAttachedFields,
                            (int index, Field field) => _hostMessageArgument(
                              index,
                              field,
                              getArgumentName: _getParameterName,
                            ),
                          ),
                          ...indexMap(
                            constructor.parameters,
                            (int index, NamedType type) => _hostMessageArgument(
                              index,
                              type,
                              getArgumentName: _getParameterName,
                            ),
                          ),
                        ],
                        cb.refer('Object?'),
                      )
                    ])
                    .property('then')
                    .call(
                      <cb.Expression>[
                        cb.Method(
                          (cb.MethodBuilder builder) => builder
                            ..requiredParameters.add(
                              cb.Parameter(
                                (cb.ParameterBuilder builder) => builder
                                  ..name = 'value'
                                  ..type = cb.refer('Object?'),
                              ),
                            )
                            ..body = cb.Block.of(<cb.Code>[
                              const cb.Code(
                                'final List<Object?>? ${_varNamePrefix}replyList = value as List<Object?>?;',
                              ),
                              const cb.Code(
                                'if (${_varNamePrefix}replyList == null) {',
                              ),
                              const cb.Code(
                                'throw _createConnectionError(${_varNamePrefix}channelName);',
                              ),
                              const cb.Code(
                                '} else if (${_varNamePrefix}replyList.length > 1) {',
                              ),
                              cb.InvokeExpression.newOf(
                                  cb.refer('PlatformException'),
                                  <cb.Expression>[],
                                  <String, cb.Expression>{
                                    'code': cb
                                        .refer('${_varNamePrefix}replyList')
                                        .index(cb.literal(0))
                                        .nullChecked
                                        .asA(cb.refer('String')),
                                    'message': cb
                                        .refer('${_varNamePrefix}replyList')
                                        .index(cb.literal(1))
                                        .asA(cb.refer('String?')),
                                    'details': cb
                                        .refer('${_varNamePrefix}replyList')
                                        .index(cb.literal(2)),
                                  }).thrown.statement,
                              const cb.Code('}'),
                            ]),
                        ).genericClosure
                      ],
                      <String, cb.Expression>{},
                      <cb.Reference>[cb.refer('void')],
                    )
                    .statement
              ]);
          },
        ),
      ),
      cb.Constructor(
        (cb.ConstructorBuilder builder) => builder
          ..name = r'$detached'
          ..docs.addAll(<String>[
            '/// Constructs $apiName without creating the associated native object.',
            '///',
            '/// This should only be used by subclasses created by this library or to',
            '/// create copies.',
          ])
          ..optionalParameters.addAll(<cb.Parameter>[
            cb.Parameter(
              (cb.ParameterBuilder builder) => builder
                ..name = r'$binaryMessenger'
                ..named = true
                ..toSuper = superClassApi != null
                ..toThis = superClassApi == null,
            ),
            cb.Parameter(
              (cb.ParameterBuilder builder) => builder
                ..name = r'$instanceManager'
                ..type = _referOrNull(
                  superClassApi == null ? r'$InstanceManager' : null,
                  isNullable: true,
                )
                ..named = true
                ..toSuper = superClassApi != null,
            ),
            for (final Field field in nonAttachedFields)
              cb.Parameter(
                (cb.ParameterBuilder builder) => builder
                  ..name = field.name
                  ..named = true
                  ..toThis = true
                  ..required = !field.type.isNullable,
              ),
            for (final Method method in superClassFlutterMethods)
              cb.Parameter(
                (cb.ParameterBuilder builder) => builder
                  ..name = method.name
                  ..named = true
                  ..toSuper = true
                  ..required = method.required,
              ),
            for (final Method method in interfacesMethods)
              cb.Parameter(
                (cb.ParameterBuilder builder) => builder
                  ..name = method.name
                  ..named = true
                  ..toThis = true
                  ..required = method.required,
              ),
            for (final Method method in flutterMethods)
              cb.Parameter(
                (cb.ParameterBuilder builder) => builder
                  ..name = method.name
                  ..named = true
                  ..toThis = true
                  ..required = method.required,
              ),
          ])
          ..initializers.add(
            cb.Code(
              superClassApi != null
                  ? r'super.$detached()'
                  : r'$instanceManager = $instanceManager ?? $InstanceManager.instance',
            ),
          ),
      ),
    ];
  }

  Iterable<cb.Field> _proxyApiFields({
    required Iterable<Field> nonAttachedFields,
    required Iterable<Field> attachedFields,
    required String apiName,
    required String dartPackageName,
    required String codecInstanceName,
    required String codecName,
    required Iterable<AstProxyApi> interfacesApis,
    required Iterable<Method> flutterMethods,
    required bool hasSuperClass,
    required bool referencesCodecInstance,
  }) {
    return <cb.Field>[
      if (referencesCodecInstance)
        cb.Field(
          (cb.FieldBuilder builder) => builder
            ..name = codecInstanceName
            ..type = cb.refer(codecName)
            ..late = true
            ..modifier = cb.FieldModifier.final$
            ..assignment = cb.Code('$codecName(\$instanceManager)'),
        ),
      if (!hasSuperClass) ...<cb.Field>[
        cb.Field(
          (cb.FieldBuilder builder) => builder
            ..name = r'$binaryMessenger'
            ..type = cb.refer('BinaryMessenger?')
            ..modifier = cb.FieldModifier.final$
            ..docs.addAll(<String>[
              '/// Sends and receives binary data across the Flutter platform barrier.',
              '///',
              '/// If it is null, the default BinaryMessenger will be used, which routes to',
              '/// the host platform.',
            ])
            ..annotations.addAll(<cb.Expression>[
              if (!hasSuperClass && interfacesApis.isNotEmpty)
                cb.refer('override'),
            ]),
        ),
        cb.Field(
          (cb.FieldBuilder builder) => builder
            ..name = r'$instanceManager'
            ..type = cb.refer(r'$InstanceManager')
            ..modifier = cb.FieldModifier.final$
            ..docs.add(
              '/// Maintains instances stored to communicate with native language objects.',
            )
            ..annotations.addAll(<cb.Expression>[
              if (!hasSuperClass && interfacesApis.isNotEmpty)
                cb.refer('override'),
            ]),
        ),
      ],
      for (final Field field in nonAttachedFields)
        cb.Field(
          (cb.FieldBuilder builder) => builder
            ..name = field.name
            ..type = cb.refer(_addGenericTypesNullable(field.type))
            ..modifier = cb.FieldModifier.final$
            ..docs.addAll(asDocumentationComments(
              field.documentationComments,
              _docCommentSpec,
            )),
        ),
      for (final Method method in flutterMethods)
        cb.Field(
          (cb.FieldBuilder builder) => builder
            ..name = method.name
            ..modifier = cb.FieldModifier.final$
            ..docs.addAll(asDocumentationComments(
              method.documentationComments,
              _docCommentSpec,
            ))
            ..type = cb.FunctionType(
              (cb.FunctionTypeBuilder builder) => builder
                ..returnType = _referOrNull(
                  _addGenericTypesNullable(method.returnType),
                  isFuture: method.isAsynchronous,
                )
                ..isNullable = !method.required
                ..requiredParameters.addAll(<cb.Reference>[
                  cb.refer('$apiName instance'),
                  ...indexMap(
                    method.parameters,
                    (int index, NamedType parameter) {
                      return cb.refer(
                        '${_addGenericTypesNullable(parameter.type)} ${_getParameterName(index, parameter)}',
                      );
                    },
                  ),
                ]),
            ),
        ),
      for (final AstProxyApi proxyApi in interfacesApis)
        for (final Method method in proxyApi.methods)
          cb.Field(
            (cb.FieldBuilder builder) => builder
              ..name = method.name
              ..modifier = cb.FieldModifier.final$
              ..annotations.add(cb.refer('override'))
              ..docs.addAll(asDocumentationComments(
                  method.documentationComments, _docCommentSpec))
              ..type = cb.FunctionType(
                (cb.FunctionTypeBuilder builder) => builder
                  ..returnType = _referOrNull(
                    _addGenericTypesNullable(method.returnType),
                    isFuture: method.isAsynchronous,
                  )
                  ..isNullable = !method.required
                  ..requiredParameters.addAll(<cb.Reference>[
                    cb.refer('${proxyApi.name} instance'),
                    ...indexMap(
                      method.parameters,
                      (int index, NamedType parameter) {
                        return cb.refer(
                          '${_addGenericTypesNullable(parameter.type)} ${_getParameterName(index, parameter)}',
                        );
                      },
                    ),
                  ]),
              ),
          ),
      for (final Field field in attachedFields)
        cb.Field(
          (cb.FieldBuilder builder) => builder
            ..name = field.name
            ..type = cb.refer(_addGenericTypesNullable(field.type))
            ..modifier = cb.FieldModifier.final$
            ..static = field.isStatic
            ..late = !field.isStatic
            ..docs.addAll(asDocumentationComments(
              field.documentationComments,
              _docCommentSpec,
            ))
            ..assignment = cb.Code('_${field.name}()'),
        ),
    ];
  }

  Iterable<cb.Method> _proxyApiMethods({
    required Iterable<Method> hostMethods,
    required Iterable<Method> flutterMethods,
    required Iterable<Method> superClassFlutterMethods,
    required String apiName,
    required String dartPackageName,
    required String codecInstanceName,
    required String codecName,
    required Iterable<Field> nonAttachedFields,
    required Iterable<Field> attachedFields,
    required Iterable<AstProxyApi> interfacesApis,
    required bool hasARequiredFlutterMethod,
  }) {
    return <cb.Method>[
      cb.Method.returnsVoid(
        (cb.MethodBuilder builder) => builder
          ..name = r'$setUpMessageHandlers'
          ..returns = cb.refer('void')
          ..static = true
          ..optionalParameters.addAll(<cb.Parameter>[
            cb.Parameter(
              (cb.ParameterBuilder builder) => builder
                ..name = r'$binaryMessenger'
                ..named = true
                ..type = cb.refer('BinaryMessenger?'),
            ),
            cb.Parameter(
              (cb.ParameterBuilder builder) => builder
                ..name = r'$instanceManager'
                ..named = true
                ..type = cb.refer(r'$InstanceManager?'),
            ),
            if (!hasARequiredFlutterMethod)
              cb.Parameter(
                (cb.ParameterBuilder builder) => builder
                  ..name = r'$detached'
                  ..named = true
                  ..type = cb.FunctionType(
                    (cb.FunctionTypeBuilder builder) => builder
                      ..returnType = cb.refer(apiName)
                      ..isNullable = true
                      ..requiredParameters.addAll(indexMap(
                        nonAttachedFields,
                        (int index, Field field) {
                          return cb.refer(
                            '${_addGenericTypesNullable(field.type)} ${_getParameterName(index, field)}',
                          );
                        },
                      )),
                  ),
              ),
            for (final Method method in flutterMethods)
              cb.Parameter(
                (cb.ParameterBuilder builder) => builder
                  ..name = method.name
                  ..type = cb.FunctionType(
                    (cb.FunctionTypeBuilder builder) => builder
                      ..returnType = _referOrNull(
                        _addGenericTypesNullable(method.returnType),
                        isFuture: method.isAsynchronous,
                      )
                      ..isNullable = true
                      ..requiredParameters.addAll(<cb.Reference>[
                        cb.refer('$apiName instance'),
                        ...indexMap(
                          method.parameters,
                          (int index, NamedType parameter) {
                            return cb.refer(
                              '${_addGenericTypesNullable(parameter.type)} ${_getParameterName(index, parameter)}',
                            );
                          },
                        )
                      ]),
                  ),
              ),
          ])
          ..body = cb.Block.of(<cb.Code>[
            cb.Code(
              'final $codecName $_pigeonChannelCodec = $codecName(\$instanceManager ?? \$InstanceManager.instance);',
            ),
            if (!hasARequiredFlutterMethod) ...<cb.Code>[
              const cb.Code('{'),
              cb.Code(
                "const String ${_varNamePrefix}channelName = r'${makeChannelNameWithStrings(
                  apiName: apiName,
                  methodName: r'$detached',
                  dartPackageName: dartPackageName,
                )}';",
              ),
              _basicMessageChannel(
                binaryMessenger: cb.refer(r'$binaryMessenger'),
              ),
              cb.refer('${_varNamePrefix}channel.setMessageHandler').call(
                <cb.Expression>[
                  cb.Method(
                    (cb.MethodBuilder builder) => builder
                      ..modifier = cb.MethodModifier.async
                      ..requiredParameters.add(
                        cb.Parameter(
                          (cb.ParameterBuilder builder) => builder
                            ..name = 'message'
                            ..type = cb.refer('Object?'),
                        ),
                      )
                      ..body = cb.Block((cb.BlockBuilder builder) {
                        builder.statements.addAll(<cb.Code>[
                          _assert(
                            condition:
                                cb.refer('message').notEqualTo(cb.literalNull),
                            message: cb.literalString(
                              'Argument for \$${_varNamePrefix}channelName was null.',
                            ),
                          ),
                          const cb.Code(
                            'final List<Object?> args = (message as List<Object?>?)!;',
                          ),
                          const cb.Code(
                            'final int? instanceIdentifier = (args[0] as int?);',
                          ),
                          _assert(
                            condition: cb
                                .refer('instanceIdentifier')
                                .notEqualTo(cb.literalNull),
                            message: cb.literalString(
                              'Argument for \$${_varNamePrefix}channelName was null, expected non-null int.',
                            ),
                          ),
                          ...indexFold<List<cb.Code>, Field>(
                            nonAttachedFields,
                            <cb.Code>[],
                            (List<cb.Code> list, int index, Field field) {
                              return list
                                ..addAll(
                                  _messageArg(index + 1, field),
                                );
                            },
                          ),
                          cb
                              .refer(
                                r'($instanceManager ?? $InstanceManager.instance)',
                              )
                              .property('addHostCreatedInstance')
                              .call(<cb.Expression>[
                            cb
                                .refer(r'$detached?.call')
                                .call(
                                  indexMap(
                                    nonAttachedFields,
                                    (int index, Field field) {
                                      // The calling instance is the first arg.
                                      final String name = _getSafeArgumentName(
                                        index + 1,
                                        field,
                                      );
                                      return cb.refer(name).nullCheckedIf(
                                            !field.type.isNullable,
                                          );
                                    },
                                  ),
                                )
                                .ifNullThen(
                                  cb.refer('$apiName.\$detached').call(
                                    <cb.Expression>[],
                                    <String, cb.Expression>{
                                      r'$binaryMessenger':
                                          cb.refer(r'$binaryMessenger'),
                                      r'$instanceManager':
                                          cb.refer(r'$instanceManager'),
                                      ...nonAttachedFields.toList().asMap().map(
                                        (int index, Field field) {
                                          final String argName =
                                              _getSafeArgumentName(
                                            index + 1,
                                            field,
                                          );
                                          return MapEntry<String,
                                              cb.Expression>(
                                            field.name,
                                            cb.refer(argName).nullCheckedIf(
                                                  !field.type.isNullable,
                                                ),
                                          );
                                        },
                                      )
                                    },
                                  ),
                                ),
                            cb.refer('instanceIdentifier').nullChecked
                          ]).statement,
                          const cb.Code('return;'),
                        ]);
                      }),
                  ).genericClosure
                ],
              ).statement,
              const cb.Code('}'),
            ],
            ...flutterMethods.fold<List<cb.Code>>(
              <cb.Code>[],
              (List<cb.Code> list, Method method) {
                final String channelName = makeChannelNameWithStrings(
                  apiName: apiName,
                  methodName: method.name,
                  dartPackageName: dartPackageName,
                );
                final cb.Expression call = cb
                    .refer(
                  '(${method.name} ?? instance!.${method.name})${method.required ? '' : '?'}.call',
                )
                    .call(
                  <cb.Expression>[
                    cb.refer('instance').nullChecked,
                    ...indexMap(
                      method.parameters,
                      (int index, NamedType parameter) {
                        final String name = _getSafeArgumentName(
                          index + 1,
                          parameter,
                        );
                        return cb
                            .refer(name)
                            .nullCheckedIf(!parameter.type.isNullable);
                      },
                    ),
                  ],
                );
                return list
                  ..addAll(<cb.Code>[
                    const cb.Code('{'),
                    cb.Code(
                      "const String ${_varNamePrefix}channelName = r'$channelName';",
                    ),
                    _basicMessageChannel(
                      binaryMessenger: cb.refer(r'$binaryMessenger'),
                    ),
                    cb.refer('${_varNamePrefix}channel.setMessageHandler').call(
                      <cb.Expression>[
                        cb.Method(
                          (cb.MethodBuilder builder) => builder
                            ..modifier = cb.MethodModifier.async
                            ..requiredParameters.add(
                              cb.Parameter(
                                (cb.ParameterBuilder builder) => builder
                                  ..name = 'message'
                                  ..type = cb.refer('Object?'),
                              ),
                            )
                            ..body = cb.Block((cb.BlockBuilder builder) {
                              builder.statements.addAll(<cb.Code>[
                                _assert(
                                  condition: cb
                                      .refer('message')
                                      .notEqualTo(cb.literalNull),
                                  message: cb.literalString(
                                    'Argument for \$${_varNamePrefix}channelName was null.',
                                  ),
                                ),
                                const cb.Code(
                                  'final List<Object?> args = (message as List<Object?>?)!;',
                                ),
                                cb.Code(
                                  'final $apiName? instance = (args[0] as $apiName?);',
                                ),
                                _assert(
                                  condition: cb
                                      .refer('instance')
                                      .notEqualTo(cb.literalNull),
                                  message: cb.literalString(
                                    'Argument for \$${_varNamePrefix}channelName was null, expected non-null $apiName.',
                                  ),
                                ),
                                ...indexFold<List<cb.Code>, NamedType>(
                                  method.parameters,
                                  <cb.Code>[],
                                  (
                                    List<cb.Code> list,
                                    int index,
                                    NamedType type,
                                  ) {
                                    return list
                                      ..addAll(_messageArg(index + 1, type));
                                  },
                                ),
                                const cb.Code('try {'),
                                if (method.returnType.isVoid) ...<cb.Code>[
                                  if (method.isAsynchronous)
                                    call.awaited.statement
                                  else
                                    call.statement,
                                  const cb.Code(
                                    'return wrapResponse(empty: true);',
                                  ),
                                ] else ...<cb.Code>[
                                  cb
                                      .declareFinal(
                                        'output',
                                        type: cb.refer(
                                          _addGenericTypesNullable(
                                            method.returnType,
                                          ),
                                        ),
                                      )
                                      .assign(
                                        call.awaitedIf(method.isAsynchronous),
                                      )
                                      .statement,
                                  _wrapResultResponse(method.returnType)
                                      .returned
                                      .statement,
                                ],
                                const cb.Code(
                                  '} on PlatformException catch (e) {',
                                ),
                                const cb.Code(
                                  'return wrapResponse(error: e);',
                                ),
                                const cb.Code('} catch (e) {'),
                                const cb.Code(
                                  "return wrapResponse(error: PlatformException(code: 'error', message: e.toString()),);",
                                ),
                                const cb.Code('}')
                              ]);
                            }),
                        ).genericClosure
                      ],
                    ).statement,
                    const cb.Code('}'),
                  ]);
              },
            ),
          ]),
      ),
      for (final Field field in attachedFields)
        cb.Method(
          (cb.MethodBuilder builder) {
            final String type = _addGenericTypesNullable(field.type);
            final String channelName = makeChannelNameWithStrings(
              apiName: apiName,
              methodName: field.name,
              dartPackageName: dartPackageName,
            );
            builder
              ..name = '_${field.name}'
              ..static = field.isStatic
              ..returns = cb.refer(type)
              ..body = cb.Block.of(
                <cb.Code>[
                  cb.Code('final $type instance = $type.\$detached('),
                  if (!field.isStatic) ...<cb.Code>[
                    const cb.Code(r'$binaryMessenger: $binaryMessenger,'),
                    const cb.Code(r'$instanceManager: $instanceManager,'),
                  ],
                  const cb.Code(');'),
                  cb.Code(
                    "const String ${_varNamePrefix}channelName = r'$channelName';",
                  ),
                  _basicMessageChannel(
                    codec: !field.isStatic
                        ? cb.refer('_codec$apiName')
                        : cb.refer('$codecName(\$InstanceManager.instance)'),
                    binaryMessenger:
                        !field.isStatic ? cb.refer(r'$binaryMessenger') : null,
                  ),
                  cb
                      .refer('${_varNamePrefix}channel.send')
                      .call(<cb.Expression>[
                        cb.literalList(
                          <Object?>[
                            if (!field.isStatic) cb.refer('this'),
                            cb.refer(
                              '${field.isStatic ? r'$InstanceManager.instance' : r'$instanceManager'}.addDartCreatedInstance(instance)',
                            ),
                          ],
                          cb.refer('Object?'),
                        )
                      ])
                      .property('then')
                      .call(
                        <cb.Expression>[
                          cb.Method(
                            (cb.MethodBuilder builder) => builder
                              ..requiredParameters.add(
                                cb.Parameter(
                                  (cb.ParameterBuilder builder) => builder
                                    ..name = 'value'
                                    ..type = cb.refer('Object?'),
                                ),
                              )
                              ..body = cb.Block.of(<cb.Code>[
                                const cb.Code(
                                  'final List<Object?>? ${_varNamePrefix}replyList = value as List<Object?>?;',
                                ),
                                const cb.Code(
                                  'if (${_varNamePrefix}replyList == null) {',
                                ),
                                const cb.Code(
                                  'throw _createConnectionError(${_varNamePrefix}channelName);',
                                ),
                                const cb.Code(
                                  '} else if (${_varNamePrefix}replyList.length > 1) {',
                                ),
                                cb.InvokeExpression.newOf(
                                    cb.refer('PlatformException'),
                                    <cb.Expression>[],
                                    <String, cb.Expression>{
                                      'code': cb
                                          .refer('${_varNamePrefix}replyList')
                                          .index(cb.literal(0))
                                          .nullChecked
                                          .asA(cb.refer('String')),
                                      'message': cb
                                          .refer('${_varNamePrefix}replyList')
                                          .index(cb.literal(1))
                                          .asA(cb.refer('String?')),
                                      'details': cb
                                          .refer('${_varNamePrefix}replyList')
                                          .index(cb.literal(2)),
                                    }).thrown.statement,
                                const cb.Code('}'),
                              ]),
                          ).genericClosure,
                        ],
                        <String, cb.Expression>{},
                        <cb.Reference>[cb.refer('void')],
                      )
                      .statement,
                  const cb.Code('return instance;'),
                ],
              );
          },
        ),
      for (final Method method in hostMethods)
        cb.Method(
          (cb.MethodBuilder builder) => builder
            ..name = method.name
            ..static = method.isStatic
            ..modifier = cb.MethodModifier.async
            ..docs.addAll(asDocumentationComments(
              method.documentationComments,
              _docCommentSpec,
            ))
            ..returns = _referOrNull(
              _addGenericTypesNullable(method.returnType),
              isFuture: true,
            )
            ..requiredParameters.addAll(indexMap(
              method.parameters,
              (int index, NamedType parameter) => cb.Parameter(
                (cb.ParameterBuilder builder) => builder
                  ..name = _getParameterName(index, parameter)
                  ..type = cb.refer(
                    _addGenericTypesNullable(parameter.type),
                  ),
              ),
            ))
            ..optionalParameters.addAll(<cb.Parameter>[
              if (method.isStatic) ...<cb.Parameter>[
                cb.Parameter(
                  (cb.ParameterBuilder builder) => builder
                    ..name = r'$binaryMessenger'
                    ..type = cb.refer('BinaryMessenger?')
                    ..named = true,
                ),
                cb.Parameter(
                  (cb.ParameterBuilder builder) => builder
                    ..name = r'$instanceManager'
                    ..type = cb.refer(r'$InstanceManager?'),
                ),
              ],
            ])
            ..body = cb.Block.of(<cb.Code>[
              cb.Code(
                "const String ${_varNamePrefix}channelName = r'${makeChannelNameWithStrings(
                  apiName: apiName,
                  methodName: method.name,
                  dartPackageName: dartPackageName,
                )}';",
              ),
              _basicMessageChannel(
                codec: !method.isStatic
                    ? cb.refer('_codec$apiName')
                    : cb.refer(
                        '$codecName(\$instanceManager ?? \$InstanceManager.instance)',
                      ),
                binaryMessenger: cb.refer(r'$binaryMessenger'),
              ),
              const cb.Code(
                  'final List<Object?>? ${_varNamePrefix}replyList ='),
              cb
                  .refer('${_varNamePrefix}channel.send')
                  .call(<cb.Expression>[
                    cb.literalList(
                      <Object?>[
                        if (!method.isStatic) cb.refer('this'),
                        ...indexMap(
                          method.parameters,
                          (int index, NamedType parameter) => _referOrNull(
                            _getParameterName(index, parameter),
                            isNullable: parameter.type.isNullable,
                          )!
                              .propertyIf(parameter.type.isEnum, 'index'),
                        ),
                      ],
                      cb.refer('Object?'),
                    )
                  ])
                  .awaited
                  .asA(cb.refer('List<Object?>?'))
                  .statement,
              const cb.Code('if (${_varNamePrefix}replyList == null) {'),
              const cb.Code(
                'throw _createConnectionError(${_varNamePrefix}channelName);',
              ),
              const cb.Code(
                '} else if (${_varNamePrefix}replyList.length > 1) {',
              ),
              cb.InvokeExpression.newOf(
                  cb.refer('PlatformException'),
                  <cb.Expression>[],
                  <String, cb.Expression>{
                    'code': cb
                        .refer('${_varNamePrefix}replyList')
                        .index(cb.literal(0))
                        .nullChecked
                        .asA(cb.refer('String')),
                    'message': cb
                        .refer('${_varNamePrefix}replyList')
                        .index(cb.literal(1))
                        .asA(cb.refer('String?')),
                    'details': cb
                        .refer('${_varNamePrefix}replyList')
                        .index(cb.literal(2)),
                  }).thrown.statement,
              // On iOS we can return nil from functions to accommodate error
              // handling.  Returning a nil value and not returning an error is an
              // exception.
              if (!method.returnType.isNullable &&
                  !method.returnType.isVoid) ...<cb.Code>[
                const cb.Code(
                  '} else if (${_varNamePrefix}replyList[0] == null) {',
                ),
                cb.InvokeExpression.newOf(
                    cb.refer('PlatformException'),
                    <cb.Expression>[],
                    <String, cb.Expression>{
                      'code': cb.literalString('null-error'),
                      'message': cb.literalString(
                        'Host platform returned null value for non-null return value.',
                      )
                    }).thrown.statement,
              ],
              const cb.Code('} else {'),
              _unwrapReturnValue(method.returnType).returned.statement,
              const cb.Code('}'),
            ]),
        ),
      cb.Method(
        (cb.MethodBuilder builder) => builder
          ..name = r'$copy'
          ..returns = cb.refer(apiName)
          ..annotations.add(cb.refer('override'))
          ..body = cb.Block.of(<cb.Code>[
            cb
                .refer('$apiName.\$detached')
                .call(
                  <cb.Expression>[],
                  <String, cb.Expression>{
                    r'$binaryMessenger': cb.refer(r'$binaryMessenger'),
                    r'$instanceManager': cb.refer(r'$instanceManager'),
                    for (final Field field in nonAttachedFields)
                      field.name: cb.refer(field.name),
                    for (final Method method in superClassFlutterMethods)
                      method.name: cb.refer(method.name),
                    for (final AstProxyApi proxyApi in interfacesApis)
                      for (final Method method in proxyApi.methods)
                        method.name: cb.refer(method.name),
                    for (final Method method in flutterMethods)
                      method.name: cb.refer(method.name),
                  },
                )
                .returned
                .statement,
          ]),
      ),
    ];
  }

  /// Generates Dart source code for test support libraries based on the given AST
  /// represented by [root], outputting the code to [sink]. [sourceOutPath] is the
  /// path of the generated dart code to be tested. [testOutPath] is where the
  /// test code will be generated.
  void generateTest(
    DartOptions generatorOptions,
    Root root,
    StringSink sink, {
    required String dartPackageName,
    required String dartOutputPackageName,
  }) {
    final Indent indent = Indent(sink);
    final String sourceOutPath = generatorOptions.sourceOutPath ?? '';
    final String testOutPath = generatorOptions.testOutPath ?? '';
    _writeTestPrologue(generatorOptions, root, indent);
    _writeTestImports(generatorOptions, root, indent);
    final String relativeDartPath =
        path.Context(style: path.Style.posix).relative(
      _posixify(sourceOutPath),
      from: _posixify(path.dirname(testOutPath)),
    );
    if (!relativeDartPath.contains('/lib/')) {
      // If we can't figure out the package name or the relative path doesn't
      // include a 'lib' directory, try relative path import which only works in
      // certain (older) versions of Dart.
      // TODO(gaaclarke): We should add a command-line parameter to override this import.
      indent.writeln(
          "import '${_escapeForDartSingleQuotedString(relativeDartPath)}';");
    } else {
      final String path =
          relativeDartPath.replaceFirst(RegExp(r'^.*/lib/'), '');
      indent.writeln("import 'package:$dartOutputPackageName/$path';");
    }
    for (final Api api in root.apis) {
      if (api is AstHostApi && api.dartHostTestHandler != null) {
        final AstFlutterApi mockApi = AstFlutterApi(
          name: api.dartHostTestHandler!,
          methods: api.methods,
          documentationComments: api.documentationComments,
        );
        writeFlutterApi(
          generatorOptions,
          root,
          indent,
          mockApi,
          channelNameFunc: (Method func) =>
              makeChannelName(api, func, dartPackageName),
          isMockHandler: true,
          dartPackageName: dartPackageName,
        );
      }
    }
  }

  /// Writes file header to sink.
  void _writeTestPrologue(DartOptions opt, Root root, Indent indent) {
    if (opt.copyrightHeader != null) {
      addLines(indent, opt.copyrightHeader!, linePrefix: '// ');
    }
    indent.writeln('// ${getGeneratedCodeWarning()}');
    indent.writeln('// $seeAlsoWarning');
    indent.writeln(
      '// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, unnecessary_import, no_leading_underscores_for_local_identifiers',
    );
    indent.writeln('// ignore_for_file: avoid_relative_lib_imports');
  }

  /// Writes file imports to sink.
  void _writeTestImports(DartOptions opt, Root root, Indent indent) {
    indent.writeln("import 'dart:async';");
    indent.writeln(
      "import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;",
    );
    indent.writeln(
        "import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;");
    indent.writeln("import 'package:flutter/services.dart';");
    indent.writeln("import 'package:flutter_test/flutter_test.dart';");
    indent.newln();
  }

  @override
  void writeGeneralUtilities(
    DartOptions generatorOptions,
    Root root,
    Indent indent, {
    required String dartPackageName,
  }) {
    final bool hasHostApi = root.apis
        .whereType<AstHostApi>()
        .any((Api api) => api.methods.isNotEmpty);
    final bool hasFlutterApi = root.apis
        .whereType<AstFlutterApi>()
        .any((Api api) => api.methods.isNotEmpty);
    final bool hasProxyApi = root.apis.any((Api api) => api is AstProxyApi);

    if (hasHostApi || hasProxyApi) {
      _writeCreateConnectionError(indent);
    }
    if (hasFlutterApi || hasProxyApi) {
      _writeWrapResponse(generatorOptions, root, indent);
    }
  }

  /// Writes [wrapResponse] method.
  void _writeWrapResponse(DartOptions opt, Root root, Indent indent) {
    indent.newln();
    indent.writeScoped(
        'List<Object?> wrapResponse({Object? result, PlatformException? error, bool empty = false}) {',
        '}', () {
      indent.writeScoped('if (empty) {', '}', () {
        indent.writeln('return <Object?>[];');
      });
      indent.writeScoped('if (error == null) {', '}', () {
        indent.writeln('return <Object?>[result];');
      });
      indent.writeln(
          'return <Object?>[error.code, error.message, error.details];');
    });
  }

  void _writeCreateConnectionError(Indent indent) {
    indent.newln();
    indent.format('''
PlatformException _createConnectionError(String channelName) {
\treturn PlatformException(
\t\tcode: 'channel-error',
\t\tmessage: 'Unable to establish connection on channel: "\$channelName".',
\t);
}''');
  }
}

// Adds support for conditional expressions.
extension on cb.Expression {
  cb.Expression awaitedIf(bool condition) => condition ? awaited : this;
  cb.Expression nullCheckedIf(bool condition) => condition ? nullChecked : this;
  cb.Expression propertyIf(bool condition, String name) =>
      condition ? property(name) : this;
}

cb.Expression _unwrapReturnValue(TypeDeclaration returnType) {
  final String type = _makeGenericTypeArguments(returnType);
  final String genericCastCall = _makeGenericCastCall(returnType);
  const String accessor = '${_varNamePrefix}replyList[0]';
  final String nullablyTypedAccessor =
      type == 'Object' ? accessor : '($accessor as $type?)';
  final String nullHandler =
      returnType.isNullable ? (genericCastCall.isEmpty ? '' : '?') : '!';
  if (returnType.isEnum) {
    if (returnType.isNullable) {
      return cb.refer(
        '($accessor as int?) == null ? null : $type.values[$accessor! as int]',
      );
    } else {
      return cb.refer('$type.values[$accessor! as int]');
    }
  } else if (!returnType.isVoid) {
    return cb.refer('$nullablyTypedAccessor$nullHandler$genericCastCall');
  }
  return cb.refer('');
}

cb.Expression _wrapResultResponse(TypeDeclaration type) {
  return cb
      .refer('wrapResponse')
      .call(<cb.Expression>[], <String, cb.Expression>{
    'result': _referOrNull('output', isNullable: type.isNullable)!.propertyIf(
      type.isEnum,
      'index',
    ),
  });
}

/// final <type> <name> = (<argsVariableName>[<index>] as <type>);
Iterable<cb.Code> _messageArg(
  int index,
  NamedType parameter, {
  String argsVariableName = 'args',
}) {
  final String argType = _addGenericTypes(parameter.type);
  final String argName = _getSafeArgumentName(index, parameter);
  final String genericArgType = _makeGenericTypeArguments(parameter.type);
  final String castCall = _makeGenericCastCall(parameter.type);

  late final cb.Expression assign;
  if (parameter.type.isEnum) {
    assign = cb
        .refer(
          '$argsVariableName[$index] == null ? null : $argType.values[$argsVariableName[$index]! as int]',
        )
        .expression;
  } else {
    assign = cb
        .refer(
          '($argsVariableName[$index] as $genericArgType?)${castCall.isEmpty ? '' : '?$castCall'}',
        )
        .expression;
  }

  return <cb.Code>[
    cb
        .declareFinal(argName, type: cb.refer('$argType?'))
        .assign(assign)
        .statement,
    if (!parameter.type.isNullable)
      _assert(
        condition: cb.refer(argName).notEqualTo(cb.literalNull),
        message: cb.literalString(
          'Argument for \$${_varNamePrefix}channelName was null, expected non-null $argType.',
        ),
      ),
  ];
}

cb.Code _assert({
  required cb.Expression condition,
  required cb.Expression message,
}) {
  return cb.refer('assert').call(<cb.Expression>[condition, message]).statement;
}

cb.Code _basicMessageChannel({
  cb.Expression codec = const cb.Reference(_pigeonChannelCodec),
  cb.Expression? binaryMessenger = const cb.Reference('binaryMessenger'),
}) {
  final cb.Reference basicMessageChannel = cb.refer(
    'BasicMessageChannel<Object?>',
  );
  return cb
      .declareFinal('${_varNamePrefix}channel', type: basicMessageChannel)
      .assign(
        basicMessageChannel.newInstance(
          <cb.Expression>[
            cb.refer('${_varNamePrefix}channelName'),
            codec,
          ],
          <String, cb.Expression>{
            if (binaryMessenger != null) 'binaryMessenger': binaryMessenger,
          },
        ),
      )
      .statement;
}

/// Converts enums to use their index.
///
/// ```dart
/// apple, banana, myEnum${type.isNullable : '?' : ''}.index
/// ```
cb.Expression _hostMessageArgument(
  int index,
  NamedType type, {
  String Function(int index, NamedType type) getArgumentName =
      _getSafeArgumentName,
}) {
  final cb.Reference nameRef = cb.refer(getArgumentName(index, type));
  if (type.type.isEnum) {
    if (type.type.isNullable) {
      return nameRef.nullSafeProperty('index');
    } else {
      return nameRef.property('index');
    }
  } else {
    return nameRef;
  }
}

cb.Reference? _referOrNull(
  String? symbol, {
  bool isFuture = false,
  bool isNullable = false,
}) {
  final String nullability = isNullable ? '?' : '';
  return symbol != null
      ? cb.refer(
          isFuture ? 'Future<$symbol$nullability>' : '$symbol$nullability')
      : null;
}

String _escapeForDartSingleQuotedString(String raw) {
  return raw
      .replaceAll(r'\', r'\\')
      .replaceAll(r'$', r'\$')
      .replaceAll(r"'", r"\'");
}

/// Calculates the name of the codec class that will be generated for [api].
String _getCodecName(Api api) => '_${api.name}Codec';

/// Writes the codec that will be used by [api].
/// Example:
///
/// class FooCodec extends StandardMessageCodec {...}
void _writeCodec(Indent indent, String codecName, Api api, Root root) {
  assert(getCodecClasses(api, root).isNotEmpty);
  final Iterable<EnumeratedClass> codecClasses = getCodecClasses(api, root);
  indent.newln();
  indent.write('class $codecName extends $_standardMessageCodec');
  indent.addScoped(' {', '}', () {
    indent.writeln('const $codecName();');
    indent.writeln('@override');
    indent.write('void writeValue(WriteBuffer buffer, Object? value) ');
    indent.addScoped('{', '}', () {
      enumerate(codecClasses, (int index, final EnumeratedClass customClass) {
        final String ifValue = 'if (value is ${customClass.name}) ';
        if (index == 0) {
          indent.write('');
        }
        indent.add(ifValue);
        indent.addScoped('{', '} else ', () {
          indent.writeln('buffer.putUint8(${customClass.enumeration});');
          indent.writeln('writeValue(buffer, value.encode());');
        }, addTrailingNewline: false);
      });
      indent.addScoped('{', '}', () {
        indent.writeln('super.writeValue(buffer, value);');
      });
    });
    indent.newln();
    indent.writeln('@override');
    indent.write('Object? readValueOfType(int type, ReadBuffer buffer) ');
    indent.addScoped('{', '}', () {
      indent.write('switch (type) ');
      indent.addScoped('{', '}', () {
        for (final EnumeratedClass customClass in codecClasses) {
          indent.writeln('case ${customClass.enumeration}: ');
          indent.nest(1, () {
            indent.writeln(
                'return ${customClass.name}.decode(readValue(buffer)!);');
          });
        }
        indent.writeln('default:');
        indent.nest(1, () {
          indent.writeln('return super.readValueOfType(type, buffer);');
        });
      });
    });
  });
}

/// Creates a Dart type where all type arguments are [Objects].
String _makeGenericTypeArguments(TypeDeclaration type) {
  return type.typeArguments.isNotEmpty
      ? '${type.baseName}<${type.typeArguments.map<String>((TypeDeclaration e) => 'Object?').join(', ')}>'
      : _addGenericTypes(type);
}

/// Creates a `.cast<>` call for an type. Returns an empty string if the
/// type has no type arguments.
String _makeGenericCastCall(TypeDeclaration type) {
  return type.typeArguments.isNotEmpty
      ? '.cast<${_flattenTypeArguments(type.typeArguments)}>()'
      : '';
}

/// Returns an argument name that can be used in a context where it is possible to collide.
String _getSafeArgumentName(int count, NamedType field) =>
    field.name.isEmpty ? 'arg$count' : 'arg_${field.name}';

/// Generates a parameter name if one isn't defined.
String _getParameterName(int count, NamedType field) =>
    field.name.isEmpty ? 'arg$count' : field.name;

/// Generates the parameters code for [func]
/// Example: (func, _getParameterName) -> 'String? foo, int bar'
String _getMethodParameterSignature(Method func) {
  String signature = '';
  if (func.parameters.isEmpty) {
    return signature;
  }

  final List<Parameter> requiredPositionalParams = func.parameters
      .where((Parameter p) => p.isPositional && !p.isOptional)
      .toList();
  final List<Parameter> optionalPositionalParams = func.parameters
      .where((Parameter p) => p.isPositional && p.isOptional)
      .toList();
  final List<Parameter> namedParams =
      func.parameters.where((Parameter p) => !p.isPositional).toList();

  String getParameterString(Parameter p) {
    final String required = p.isRequired && !p.isPositional ? 'required ' : '';

    final String type = _addGenericTypesNullable(p.type);

    final String defaultValue =
        p.defaultValue == null ? '' : ' = ${p.defaultValue}';
    return '$required$type ${p.name}$defaultValue';
  }

  final String baseParameterString = requiredPositionalParams
      .map((Parameter p) => getParameterString(p))
      .join(', ');
  final String optionalParameterString = optionalPositionalParams
      .map((Parameter p) => getParameterString(p))
      .join(', ');
  final String namedParameterString =
      namedParams.map((Parameter p) => getParameterString(p)).join(', ');

  // Parameter lists can end with either named or optional positional parameters, but not both.
  if (requiredPositionalParams.isNotEmpty) {
    signature = baseParameterString;
  }
  final String trailingComma =
      optionalPositionalParams.isNotEmpty || namedParams.isNotEmpty ? ',' : '';
  final String baseParams =
      signature.isNotEmpty ? '$signature$trailingComma ' : '';
  if (optionalPositionalParams.isNotEmpty) {
    final String trailingComma =
        requiredPositionalParams.length + optionalPositionalParams.length > 2
            ? ','
            : '';
    return '$baseParams[$optionalParameterString$trailingComma]';
  }
  if (namedParams.isNotEmpty) {
    final String trailingComma =
        requiredPositionalParams.length + namedParams.length > 2 ? ',' : '';
    return '$baseParams{$namedParameterString$trailingComma}';
  }
  return signature;
}

/// Converts a [List] of [TypeDeclaration]s to a comma separated [String] to be
/// used in Dart code.
String _flattenTypeArguments(List<TypeDeclaration> args) {
  return args
      .map<String>((TypeDeclaration arg) => arg.typeArguments.isEmpty
          ? '${arg.baseName}?'
          : '${arg.baseName}<${_flattenTypeArguments(arg.typeArguments)}>?')
      .join(', ');
}

/// Creates the type declaration for use in Dart code from a [NamedType] making sure
/// that type arguments are used for primitive generic types.
String _addGenericTypes(TypeDeclaration type) {
  final List<TypeDeclaration> typeArguments = type.typeArguments;
  switch (type.baseName) {
    case 'List':
      return (typeArguments.isEmpty)
          ? 'List<Object?>'
          : 'List<${_flattenTypeArguments(typeArguments)}>';
    case 'Map':
      return (typeArguments.isEmpty)
          ? 'Map<Object?, Object?>'
          : 'Map<${_flattenTypeArguments(typeArguments)}>';
    default:
      return type.baseName;
  }
}

String _addGenericTypesNullable(TypeDeclaration type) {
  final String genericType = _addGenericTypes(type);
  return type.isNullable ? '$genericType?' : genericType;
}

/// Converts [inputPath] to a posix absolute path.
String _posixify(String inputPath) {
  final path.Context context = path.Context(style: path.Style.posix);
  return context.fromUri(path.toUri(path.absolute(inputPath)));
}
