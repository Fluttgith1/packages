// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: cascade_invocations, diagnostic_describe_all_properties

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router/src/match.dart';
import 'package:go_router/src/typedefs.dart';

Future<GoRouter> createGoRouter(
  WidgetTester tester, {
  GoRouterNavigatorBuilder? navigatorBuilder,
}) async {
  final GoRouter goRouter = GoRouter(
    initialLocation: '/',
    routes: <GoRoute>[
      GoRoute(path: '/', builder: (_, __) => const DummyStatefulWidget()),
      GoRoute(
        path: '/error',
        builder: (_, __) => TestErrorScreen(TestFailure('Exception')),
      ),
    ],
    navigatorBuilder: navigatorBuilder,
  );
  await tester.pumpWidget(MaterialApp.router(
      routeInformationProvider: goRouter.routeInformationProvider,
      routeInformationParser: goRouter.routeInformationParser,
      routerDelegate: goRouter.routerDelegate));
  return goRouter;
}

Widget fakeNavigationBuilder(
  BuildContext context,
  GoRouterState state,
  Widget child,
) =>
    child;

class GoRouterNamedLocationSpy extends GoRouter {
  GoRouterNamedLocationSpy({required super.routes});

  String? name;
  Map<String, String>? params;
  Map<String, String>? queryParams;

  @override
  String namedLocation(
    String name, {
    Map<String, String> params = const <String, String>{},
    Map<String, String> queryParams = const <String, String>{},
  }) {
    this.name = name;
    this.params = params;
    this.queryParams = queryParams;
    return '';
  }
}

class GoRouterGoSpy extends GoRouter {
  GoRouterGoSpy({required super.routes});

  String? myLocation;
  Object? extra;

  @override
  void go(String location, {Object? extra}) {
    myLocation = location;
    this.extra = extra;
  }
}

class GoRouterGoNamedSpy extends GoRouter {
  GoRouterGoNamedSpy({required super.routes});

  String? name;
  Map<String, String>? params;
  Map<String, String>? queryParams;
  Object? extra;

  @override
  void goNamed(
    String name, {
    Map<String, String> params = const <String, String>{},
    Map<String, String> queryParams = const <String, String>{},
    Object? extra,
  }) {
    this.name = name;
    this.params = params;
    this.queryParams = queryParams;
    this.extra = extra;
  }
}

class GoRouterPushSpy extends GoRouter {
  GoRouterPushSpy({required super.routes});

  String? myLocation;
  Object? extra;

  @override
  void push(String location, {Object? extra}) {
    myLocation = location;
    this.extra = extra;
  }
}

class GoRouterPushNamedSpy extends GoRouter {
  GoRouterPushNamedSpy({required super.routes});

  String? name;
  Map<String, String>? params;
  Map<String, String>? queryParams;
  Object? extra;

  @override
  void pushNamed(
    String name, {
    Map<String, String> params = const <String, String>{},
    Map<String, String> queryParams = const <String, String>{},
    Object? extra,
  }) {
    this.name = name;
    this.params = params;
    this.queryParams = queryParams;
    this.extra = extra;
  }
}

class GoRouterPopSpy extends GoRouter {
  GoRouterPopSpy({required super.routes});

  bool popped = false;

  @override
  void pop() {
    popped = true;
  }
}

class GoRouterRefreshStreamSpy extends GoRouterRefreshStream {
  GoRouterRefreshStreamSpy(
    super.stream,
  ) : notifyCount = 0;

  late int notifyCount;

  @override
  void notifyListeners() {
    notifyCount++;
    super.notifyListeners();
  }
}

Future<GoRouter> createRouter(
  List<GoRoute> routes,
  WidgetTester tester, {
  GoRouterRedirect? redirect,
  String initialLocation = '/',
  int redirectLimit = 5,
}) async {
  final GoRouter goRouter = GoRouter(
    routes: routes,
    redirect: redirect,
    initialLocation: initialLocation,
    redirectLimit: redirectLimit,
    errorBuilder: (BuildContext context, GoRouterState state) =>
        TestErrorScreen(state.error!),
  );
  await tester.pumpWidget(
    MaterialApp.router(
      routeInformationProvider: goRouter.routeInformationProvider,
      routeInformationParser: goRouter.routeInformationParser,
      routerDelegate: goRouter.routerDelegate,
    ),
  );
  return goRouter;
}

class TestErrorScreen extends DummyScreen {
  const TestErrorScreen(this.ex, {super.key});
  final Exception ex;
}

class HomeScreen extends DummyScreen {
  const HomeScreen({super.key});
}

class Page1Screen extends DummyScreen {
  const Page1Screen({super.key});
}

class Page2Screen extends DummyScreen {
  const Page2Screen({super.key});
}

class LoginScreen extends DummyScreen {
  const LoginScreen({super.key});
}

class FamilyScreen extends DummyScreen {
  const FamilyScreen(this.fid, {super.key});
  final String fid;
}

class FamiliesScreen extends DummyScreen {
  const FamiliesScreen({required this.selectedFid, super.key});
  final String selectedFid;
}

class PersonScreen extends DummyScreen {
  const PersonScreen(this.fid, this.pid, {super.key});
  final String fid;
  final String pid;
}

class DummyScreen extends StatelessWidget {
  const DummyScreen({super.key});

  @override
  Widget build(BuildContext context) => const Placeholder();
}

Widget dummy(BuildContext context, GoRouterState state) => const DummyScreen();

extension Extension on GoRouter {
  Page<dynamic> _pageFor(RouteMatch match) {
    final List<RouteMatch> matches = routerDelegate.matches.matches;
    final int i = matches.indexOf(match);
    final List<Page<dynamic>> pages =
        routerDelegate.builder.getPages(DummyBuildContext(), matches).toList();
    return pages[i];
  }

  Widget screenFor(RouteMatch match) =>
      (_pageFor(match) as MaterialPage<void>).child;
}

class DummyBuildContext implements BuildContext {
  @override
  bool get debugDoingBuild => throw UnimplementedError();

  @override
  InheritedWidget dependOnInheritedElement(InheritedElement ancestor,
      {Object aspect = 1}) {
    throw UnimplementedError();
  }

  @override
  T? dependOnInheritedWidgetOfExactType<T extends InheritedWidget>(
      {Object? aspect}) {
    throw UnimplementedError();
  }

  @override
  DiagnosticsNode describeElement(String name,
      {DiagnosticsTreeStyle style = DiagnosticsTreeStyle.errorProperty}) {
    throw UnimplementedError();
  }

  @override
  List<DiagnosticsNode> describeMissingAncestor(
      {required Type expectedAncestorType}) {
    throw UnimplementedError();
  }

  @override
  DiagnosticsNode describeOwnershipChain(String name) {
    throw UnimplementedError();
  }

  @override
  DiagnosticsNode describeWidget(String name,
      {DiagnosticsTreeStyle style = DiagnosticsTreeStyle.errorProperty}) {
    throw UnimplementedError();
  }

  @override
  void dispatchNotification(Notification notification) {
    throw UnimplementedError();
  }

  @override
  T? findAncestorRenderObjectOfType<T extends RenderObject>() {
    throw UnimplementedError();
  }

  @override
  T? findAncestorStateOfType<T extends State<StatefulWidget>>() {
    throw UnimplementedError();
  }

  @override
  T? findAncestorWidgetOfExactType<T extends Widget>() {
    throw UnimplementedError();
  }

  @override
  RenderObject? findRenderObject() {
    throw UnimplementedError();
  }

  @override
  T? findRootAncestorStateOfType<T extends State<StatefulWidget>>() {
    throw UnimplementedError();
  }

  @override
  InheritedElement?
      getElementForInheritedWidgetOfExactType<T extends InheritedWidget>() {
    throw UnimplementedError();
  }

  @override
  BuildOwner? get owner => throw UnimplementedError();

  @override
  Size? get size => throw UnimplementedError();

  @override
  void visitAncestorElements(bool Function(Element element) visitor) {}

  @override
  void visitChildElements(ElementVisitor visitor) {}

  @override
  Widget get widget => throw UnimplementedError();
}

class DummyStatefulWidget extends StatefulWidget {
  const DummyStatefulWidget({super.key});

  @override
  State<DummyStatefulWidget> createState() => DummyStatefulWidgetState();
}

class DummyStatefulWidgetState extends State<DummyStatefulWidget> {
  @override
  Widget build(BuildContext context) => Container();
}
