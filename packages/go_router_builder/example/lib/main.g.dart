// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: always_specify_types, public_member_api_docs

part of 'main.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $homeRoute,
      $loginRoute,
    ];

RouteBase get $homeRoute => GoRouteData.$route(
      path: '/',
      factory: $HomeRouteExtension._fromState,
      isShell: false,
      routes: [
        GoRouteData.$route(
          path: '',
          factory: $FamilyRouteExtension._fromState,
          isShell: true,
          key: const GlobalObjectKey('shell_key'),
          routes: [
            GoRouteData.$route(
              path: 'family/:fid',
              factory: $FamilyIdRouteExtension._fromState,
              isShell: false,
              routes: [
                GoRouteData.$route(
                  path: 'person/:pid',
                  factory: $PersonRouteExtension._fromState,
                  isShell: false,
                  routes: [
                    GoRouteData.$route(
                      path: 'details/:details',
                      factory: $PersonDetailsRouteExtension._fromState,
                      isShell: false,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}

extension $FamilyRouteExtension on FamilyRoute {
  static FamilyRoute _fromState(GoRouterState state) => const FamilyRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}

extension $FamilyIdRouteExtension on FamilyIdRoute {
  static FamilyIdRoute _fromState(GoRouterState state) => FamilyIdRoute(
        state.params['fid']!,
      );

  String get location => GoRouteData.$location(
        '/family/${Uri.encodeComponent(fid)}',
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}

extension $PersonRouteExtension on PersonRoute {
  static PersonRoute _fromState(GoRouterState state) => PersonRoute(
        state.params['fid']!,
        int.parse(state.params['pid']!),
      );

  String get location => GoRouteData.$location(
        '/family/${Uri.encodeComponent(fid)}/person/${Uri.encodeComponent(pid.toString())}',
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}

extension $PersonDetailsRouteExtension on PersonDetailsRoute {
  static PersonDetailsRoute _fromState(GoRouterState state) =>
      PersonDetailsRoute(
        state.params['fid']!,
        int.parse(state.params['pid']!),
        _$PersonDetailsEnumMap._$fromName(state.params['details']!),
        $extra: state.extra as int?,
      );

  String get location => GoRouteData.$location(
        '/family/${Uri.encodeComponent(fid)}/person/${Uri.encodeComponent(pid.toString())}/details/${Uri.encodeComponent(_$PersonDetailsEnumMap[details]!)}',
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}

const _$PersonDetailsEnumMap = {
  PersonDetails.hobbies: 'hobbies',
  PersonDetails.favoriteFood: 'favorite-food',
  PersonDetails.favoriteSport: 'favorite-sport',
};

extension<T extends Enum> on Map<T, String> {
  T _$fromName(String value) =>
      entries.singleWhere((element) => element.value == value).key;
}

RouteBase get $loginRoute => GoRouteData.$route(
      path: '/login',
      factory: $LoginRouteExtension._fromState,
      isShell: false,
    );

extension $LoginRouteExtension on LoginRoute {
  static LoginRoute _fromState(GoRouterState state) => LoginRoute(
        fromPage: state.queryParams['from-page'],
      );

  String get location => GoRouteData.$location(
        '/login',
        queryParams: {
          if (fromPage != null) 'from-page': fromPage!,
        },
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}
