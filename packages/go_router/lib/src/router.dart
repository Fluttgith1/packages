// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';

import 'configuration.dart';
import 'delegate.dart';
import 'information_provider.dart';
import 'logging.dart';
import 'matching.dart';
import 'misc/inherited_router.dart';
import 'parser.dart';
import 'platform.dart';
import 'typedefs.dart';

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
    // See https://github.com/flutter/flutter/issues/108144
    GoRouterPageBuilder? errorPageBuilder,
    GoRouterWidgetBuilder? errorBuilder,
    GoRouterRedirect? redirect,
    Listenable? refreshListenable,
    int redirectLimit = 5,
    bool routerNeglect = false,
    String? initialLocation,
    // TODO(johnpryan): Deprecate this parameter
    // See https://github.com/flutter/flutter/issues/108132
    UrlPathStrategy? urlPathStrategy,
    List<NavigatorObserver>? observers,
    bool debugLogDiagnostics = false,
    // TODO(johnpryan): Deprecate this parameter
    // See https://github.com/flutter/flutter/issues/108145
    GoRouterNavigatorBuilder? navigatorBuilder,
    String? restorationScopeId,
  }) {
    if (urlPathStrategy != null) {
      setUrlPathStrategy(urlPathStrategy);
    }

    setLogging(enabled: debugLogDiagnostics);
    WidgetsFlutterBinding.ensureInitialized();

    _routeConfiguration = RouteConfiguration(
      routes: routes,
      topRedirect: redirect ?? (_) => null,
      redirectLimit: redirectLimit,
    );

    _routeInformationParser = GoRouteInformationParser(
      configuration: _routeConfiguration,
      debugRequireGoRouteInformationProvider: true,
    );

    _routeInformationProvider = GoRouteInformationProvider(
        initialRouteInformation: RouteInformation(
            location: _effectiveInitialLocation(initialLocation)),
        refreshListenable: refreshListenable);

    _routerDelegate = GoRouterDelegate(
      configuration: _routeConfiguration,
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

  late final RouteConfiguration _routeConfiguration;
  late final GoRouteInformationParser _routeInformationParser;
  late final GoRouterDelegate _routerDelegate;
  late final GoRouteInformationProvider _routeInformationProvider;

  /// The router delegate. Provide this to the MaterialApp or CupertinoApp's
  /// `.router()` constructor
  GoRouterDelegate get routerDelegate => _routerDelegate;

  /// The route information provider used by [GoRouter].
  GoRouteInformationProvider get routeInformationProvider =>
      _routeInformationProvider;

  /// The route information parser used by [GoRouter].
  GoRouteInformationParser get routeInformationParser =>
      _routeInformationParser;

  /// The route configuration. Used for testing.
  // TODO(johnpryan): Remove this, integration tests shouldn't need access
  @visibleForTesting
  RouteConfiguration get routeConfiguration => _routeConfiguration;

  /// Get the current location.
  String get location =>
      _routerDelegate.currentConfiguration.location.toString();

  /// Get a location from route name and parameters.
  /// This is useful for redirecting to a named location.
  // TODO(johnpryan): Deprecate this API
  // See https://github.com/flutter/flutter/issues/107729
  String namedLocation(
    String name, {
    Map<String, String> params = const <String, String>{},
    Map<String, String> queryParams = const <String, String>{},
  }) =>
      _routeInformationParser.configuration.namedLocation(
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
    _routeInformationProvider.value =
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
    _routeInformationParser
        .parseRouteInformation(
            DebugGoRouteInformation(location: location, state: extra))
        .then<void>((RouteMatchList matches) {
      _routerDelegate.push(matches.last);
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

  /// Replaces the top-most page of the page stack with the given URL location
  /// w/ optional query parameters, e.g. `/family/f2/person/p1?color=blue`.
  ///
  /// See also:
  /// * [go] which navigates to the location.
  /// * [push] which pushes the location onto the page stack.
  void replace(String location, {Object? extra}) {
    routeInformationParser
        .parseRouteInformation(
      DebugGoRouteInformation(location: location, state: extra),
    )
        .then<void>((List<GoRouteMatch> matches) {
      routerDelegate.replace(matches.last);
    });
  }

  /// Replaces the top-most page of the page stack with the named route w/
  /// optional parameters, e.g. `name='person', params={'fid': 'f2', 'pid':
  /// 'p1'}`.
  ///
  /// See also:
  /// * [goNamed] which navigates a named route.
  /// * [pushNamed] which pushes a named route onto the page stack.
  void replaceNamed(
    String name, {
    Map<String, String> params = const <String, String>{},
    Map<String, String> queryParams = const <String, String>{},
    Object? extra,
  }) {
    replace(
      namedLocation(name, params: params, queryParams: queryParams),
      extra: extra,
    );
  }

  /// Returns `true` if there is more than 1 page on the stack.
  bool canPop() => _routerDelegate.canPop();

  /// Pop the top page off the GoRouter's page stack.
  void pop() {
    assert(() {
      log.info('popping $location');
      return true;
    }());
    _routerDelegate.pop();
  }

  /// Refresh the route.
  void refresh() {
    assert(() {
      log.info('refreshing $location');
      return true;
    }());
    _routeInformationProvider.notifyListeners();
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
    _routeInformationProvider.dispose();
    _routerDelegate.dispose();
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
