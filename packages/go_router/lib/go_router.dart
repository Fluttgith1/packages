// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// A declarative router for Flutter based on Navigation 2 supporting
/// deep linking, data-driven routes and more
library go_router;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'src/configuration.dart';
import 'src/delegate.dart';
import 'src/information_provider.dart';
import 'src/logging.dart';
import 'src/matching.dart';
import 'src/parser.dart';
import 'src/platform.dart';
import 'src/typedefs.dart';

export 'src/configuration.dart' show GoRouterState, GoRoute;
export 'src/misc/refresh_stream.dart';
export 'src/pages/custom_transition_page.dart';
export 'src/platform.dart' show UrlPathStrategy;
export 'src/typed_routing.dart' show GoRouteData, TypedGoRoute;
export 'src/typedefs.dart';

/// The top-level go router class.
///
/// Create one of these to initialize your app's routing policy.
// ignore: prefer_mixin
class GoRouter extends ChangeNotifier with NavigatorObserver {
  /// Default constructor to configure a GoRouter with a routes builder
  /// and an error page builder.
  GoRouter({
    required List<GoRoute> routes,
    // TODO(johnpryan): Change to a route, improve error API
    GoRouterPageBuilder? errorPageBuilder,
    GoRouterWidgetBuilder? errorBuilder,
    GoRouterRedirect? redirect,
    Listenable? refreshListenable,
    int redirectLimit = 5,
    bool routerNeglect = false,
    String? initialLocation,
    // TODO(johnpryan): Deprecate this parameter
    UrlPathStrategy? urlPathStrategy,
    List<NavigatorObserver>? observers,
    bool debugLogDiagnostics = false,
    // TODO(johnpryan): Deprecate this parameter
    GoRouterNavigatorBuilder? navigatorBuilder,
    String? restorationScopeId,
  }) {
    if (urlPathStrategy != null) {
      setUrlPathStrategy(urlPathStrategy);
    }

    setLogging(enabled: debugLogDiagnostics);
    WidgetsFlutterBinding.ensureInitialized();

    routeConfiguration = RouteConfiguration(
      routes: routes,
      topRedirect: redirect ?? (_) => null,
      redirectLimit: redirectLimit,
    );

    routeConfiguration.validate();

    routeInformationParser = GoRouterInformationParser(
      configuration: routeConfiguration,
      debugRequireGoRouteInformationProvider: true,
    );
    routeInformationProvider = GoRouteInformationProvider(
        initialRouteInformation: RouteInformation(
            location: _effectiveInitialLocation(initialLocation)),
        refreshListenable: refreshListenable);

    routerDelegate = GoRouterDelegate(
      configuration: routeConfiguration,
      errorPageBuilder: errorPageBuilder,
      errorBuilder: errorBuilder,
      routerNeglect: routerNeglect,
      observers: <NavigatorObserver>[
        ...observers ?? <NavigatorObserver>[],
        this
      ],
      restorationScopeId: restorationScopeId,
      // wrap the returned Navigator to enable GoRouter.of(context).go() et al,
      // allowing the caller to wrap the navigator themselves
      builderWithNav:
          (BuildContext context, GoRouterState state, Navigator nav) =>
              InheritedGoRouter(
        goRouter: this,
        child: navigatorBuilder?.call(context, state, nav) ?? nav,
      ),
    );
    assert(() {
      log.info('setting initial location $initialLocation');
      return true;
    }());
  }

  /// The route configuration for the app.
  late final RouteConfiguration routeConfiguration;

  /// The route information parser used by the go router.
  late final GoRouterInformationParser routeInformationParser;

  /// The router delegate used by the go router.
  late final GoRouterDelegate routerDelegate;

  /// The route information provider used by the go router.
  late final GoRouteInformationProvider routeInformationProvider;

  /// Get the current location.
  String get location =>
      routerDelegate.currentConfiguration.location.toString();

  /// Get a location from route name and parameters.
  /// This is useful for redirecting to a named location.
  String namedLocation(
    String name, {
    Map<String, String> params = const <String, String>{},
    Map<String, String> queryParams = const <String, String>{},
  }) =>
      routeInformationParser.configuration.namedLocation(
        name,
        params: params,
        queryParams: queryParams,
      );

  /// Navigate to a URI location w/ optional query parameters, e.g.
  /// `/family/f2/person/p1?color=blue`
  void go(String location, {Object? extra}) {
    assert(() {
      log.info('going to $location');
      return true;
    }());
    routeInformationProvider.value =
        RouteInformation(location: location, state: extra);
  }

  /// Navigate to a named route w/ optional parameters, e.g.
  /// `name='person', params={'fid': 'f2', 'pid': 'p1'}`
  /// Navigate to the named route.
  void goNamed(
    String name, {
    Map<String, String> params = const <String, String>{},
    Map<String, String> queryParams = const <String, String>{},
    Object? extra,
  }) =>
      go(
        namedLocation(name, params: params, queryParams: queryParams),
        extra: extra,
      );

  /// Push a URI location onto the page stack w/ optional query parameters, e.g.
  /// `/family/f2/person/p1?color=blue`
  void push(String location, {Object? extra}) {
    assert(() {
      log.info('pushing $location');
      return true;
    }());
    routeInformationParser
        .parseRouteInformation(
            DebugGoRouteInformation(location: location, state: extra))
        .then<void>((RouteMatchList matches) {
      routerDelegate.push(matches.last);
    });
  }

  /// Push a named route onto the page stack w/ optional parameters, e.g.
  /// `name='person', params={'fid': 'f2', 'pid': 'p1'}`
  void pushNamed(
    String name, {
    Map<String, String> params = const <String, String>{},
    Map<String, String> queryParams = const <String, String>{},
    Object? extra,
  }) =>
      push(
        namedLocation(name, params: params, queryParams: queryParams),
        extra: extra,
      );

  /// Returns `true` if there is more than 1 page on the stack.
  bool canPop() => routerDelegate.canPop();

  /// Pop the top page off the GoRouter's page stack.
  void pop() {
    assert(() {
      log.info('popping $location');
      return true;
    }());
    routerDelegate.pop();
  }

  /// Refresh the route.
  void refresh() {
    assert(() {
      log.info('refreshing $location');
      return true;
    }());
    routeInformationProvider.notifyListeners();
  }

  /// Set the app's URL path strategy (defaults to hash). call before runApp().
  static void setUrlPathStrategy(UrlPathStrategy strategy) =>
      setUrlPathStrategyImpl(strategy);

  /// Find the current GoRouter in the widget tree.
  static GoRouter of(BuildContext context) {
    final InheritedGoRouter? inherited =
        context.dependOnInheritedWidgetOfExactType<InheritedGoRouter>();
    assert(inherited != null, 'No GoRouter found in context');
    return inherited!.goRouter;
  }

  /// The [Navigator] pushed `route`.
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      notifyListeners();

  /// The [Navigator] popped `route`.
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      notifyListeners();

  /// The [Navigator] removed `route`.
  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      notifyListeners();

  /// The [Navigator] replaced `oldRoute` with `newRoute`.
  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) =>
      notifyListeners();

  @override
  void dispose() {
    routeInformationProvider.dispose();
    routerDelegate.dispose();
    super.dispose();
  }

  String _effectiveInitialLocation(String? initialLocation) {
    final String platformDefault =
        WidgetsBinding.instance.platformDispatcher.defaultRouteName;
    if (initialLocation == null) {
      return platformDefault;
    } else if (platformDefault == '/') {
      return initialLocation;
    } else {
      return platformDefault;
    }
  }
}

/// GoRouter implementation of InheritedWidget.
///
/// Used for to find the current GoRouter in the widget tree. This is useful
/// when routing from anywhere in your app.
class InheritedGoRouter extends InheritedWidget {
  /// Default constructor for the inherited go router.
  const InheritedGoRouter({
    required Widget child,
    required this.goRouter,
    Key? key,
  }) : super(child: child, key: key);

  /// The [GoRouter] that is made available to the widget tree.
  final GoRouter goRouter;

  /// Used by the Router architecture as part of the InheritedWidget.
  @override
  // ignore: prefer_expression_function_bodies
  bool updateShouldNotify(covariant InheritedGoRouter oldWidget) {
    // avoid rebuilding the widget tree if the router has not changed
    return goRouter != oldWidget.goRouter;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<GoRouter>('goRouter', goRouter));
  }
}

/// Dart extension to add navigation function to a BuildContext object, e.g.
/// context.go('/');
extension GoRouterHelper on BuildContext {
  /// Get a location from route name and parameters.
  String namedLocation(
    String name, {
    Map<String, String> params = const <String, String>{},
    Map<String, String> queryParams = const <String, String>{},
  }) =>
      GoRouter.of(this)
          .namedLocation(name, params: params, queryParams: queryParams);

  /// Navigate to a location.
  void go(String location, {Object? extra}) =>
      GoRouter.of(this).go(location, extra: extra);

  /// Navigate to a named route.
  void goNamed(
    String name, {
    Map<String, String> params = const <String, String>{},
    Map<String, String> queryParams = const <String, String>{},
    Object? extra,
  }) =>
      GoRouter.of(this).goNamed(
        name,
        params: params,
        queryParams: queryParams,
        extra: extra,
      );

  /// Push a location onto the page stack.
  void push(String location, {Object? extra}) =>
      GoRouter.of(this).push(location, extra: extra);

  /// Navigate to a named route onto the page stack.
  void pushNamed(
    String name, {
    Map<String, String> params = const <String, String>{},
    Map<String, String> queryParams = const <String, String>{},
    Object? extra,
  }) =>
      GoRouter.of(this).pushNamed(
        name,
        params: params,
        queryParams: queryParams,
        extra: extra,
      );

  /// Returns `true` if there is more than 1 page on the stack.
  bool canPop() => GoRouter.of(this).canPop();

  /// Pop the top page off the Navigator's page stack by calling
  /// [Navigator.pop].
  void pop() => GoRouter.of(this).pop();
}
