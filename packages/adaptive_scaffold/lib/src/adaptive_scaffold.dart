// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'adaptive_layout.dart';
import 'breakpoint.dart';
import 'breakpoints.dart';
import 'slot_layout.dart';
import 'slot_layout_config.dart';

/// [AdaptiveScaffold] is an abstraction that passes properties to
/// [AdaptiveLayout] and reduces repetition and a burden on the developer.
class AdaptiveScaffold extends StatefulWidget {
  /// Returns an [AdaptiveScaffold] by passing information down to an
  /// [AdaptiveLayout].
  const AdaptiveScaffold({
    this.destinations,
    this.selectedIndex = 0,
    this.smallBody,
    this.body,
    this.largeBody,
    this.smallSecondaryBody,
    this.secondaryBody,
    this.largeSecondaryBody,
    this.bodyRatio,
    this.breakpoints = const <Breakpoint>[Breakpoints.small, Breakpoints.medium, Breakpoints.large],
    this.drawerBreakpoint = Breakpoints.onlySmallDesktop,
    this.internalAnimations = true,
    this.horizontalBody = true,
    this.onSelectedIndexChange,
    this.useDrawer = true,
    this.appBar,
    super.key,
  });

  /// The destinations to be used in navigation items. These are converted to
  /// [NavigationRailDestination]s and [BottomNavigationBarItem]s and inserted
  /// into the appropriate places. If passing destinations, you must also pass a
  /// selected index to be used by the [NavigationRail].
  final List<NavigationDestination>? destinations;

  /// The index to be used by the [NavigationRail] if applicable.
  final int? selectedIndex;

  /// Widget to be displayed in the body slot at the smallest breakpoint.
  ///
  /// If nothing is entered for this property, then the default [body] is
  /// displayed in the slot. If null is entered for this slot, the slot stays
  /// empty.
  final WidgetBuilder? smallBody;

  /// Widget to be displayed in the body slot at the middle breakpoint.
  ///
  /// The default displayed body.
  final WidgetBuilder? body;

  /// Widget to be displayed in the body slot at the largest breakpoint.
  ///
  /// If nothing is entered for this property, then the default [body] is
  /// displayed in the slot. If null is entered for this slot, the slot stays
  /// empty.
  final WidgetBuilder? largeBody;

  /// Widget to be displayed in the secondaryBody slot at the smallest
  /// breakpoint.
  ///
  /// If nothing is entered for this property, then the default [secondaryBody]
  /// is displayed in the slot. If null is entered for this slot, the slot stays
  /// empty.
  final WidgetBuilder? smallSecondaryBody;

  /// Widget to be displayed in the secondaryBody slot at the middle breakpoint.
  ///
  /// The default displayed secondaryBody.
  final WidgetBuilder? secondaryBody;

  /// Widget to be displayed in the seconaryBody slot at the smallest
  /// breakpoint.
  ///
  /// If nothing is entered for this property, then the default [secondaryBody]
  /// is displayed in the slot. If null is entered for this slot, the slot stays
  /// empty.
  final WidgetBuilder? largeSecondaryBody;

  /// Defines the fractional ratio of body to the secondaryBody.
  ///
  /// For example 1 / 3 would mean body takes up 1/3 of the available space and
  /// secondaryBody takes up the rest.
  ///
  /// If this value is null, the ratio is defined so that the split axis is in
  /// the center of the screen.
  final double? bodyRatio;

  /// Must be of length 3. The list defining breakpoints for the
  /// [AdaptiveLayout] the breakpoint is active from the value at the index up
  /// until the value at the next index.
  ///
  /// Defaults to small, medium, large breakpoints from breakpoints.dart.
  final List<Breakpoint> breakpoints;

  /// Whether or not the developer wants the smooth entering slide transition on
  /// secondaryBody.
  ///
  /// Defaults to true.
  final bool internalAnimations;

  /// Whether to orient the body and secondaryBody in horizontal order (true) or
  /// in vertical order (false).
  ///
  /// Defaults to true.
  final bool horizontalBody;

  /// Whether to use a [Drawer] over a [BottomNavigationBar] when not on mobile
  /// and Breakpoint is small.
  ///
  /// Defaults to true.
  final bool useDrawer;

  /// Option to override the drawerBreakpoint for the usage of [Drawer] over the
  /// usual [BottomNavigationBar].
  ///
  /// Defaults to [Breakpoints.onlySmallDesktop].
  final Breakpoint drawerBreakpoint;

  /// Option to override the default [AppBar] when using drawer in desktop
  /// small.
  final AppBar? appBar;

  /// Callback function for when the index of a [NavigationRail] changes.
  final Function(int)? onSelectedIndexChange;

  /// Callback function for when the index of a [NavigationRail] changes.
  static WidgetBuilder emptyBuilder = (_) => const SizedBox();

  /// Public helper method to be used for creating a [NavigationRail] from a
  /// list of [NavigationDestination]s. Takes in a [selectedIndex] property for
  /// the current selected item in the [NavigationRail] and [extended] for
  /// whether the [NavigationRail] is extended or not.
  static Builder toNavigationRail({
    required List<NavigationDestination> destinations,
    double width = 72,
    int selectedIndex = 0,
    bool extended = false,
    Color backgroundColor = Colors.transparent,
    Widget? leading,
    Widget? trailing,
    NavigationRailLabelType labelType = NavigationRailLabelType.none,
  }) {
    if (extended && width == 72) {
      width = 150;
    }
    return Builder(
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: width,
            height: MediaQuery.of(context).size.height,
            child: NavigationRail(
              labelType: labelType,
              leading: leading,
              trailing: trailing,
              backgroundColor: backgroundColor,
              extended: extended,
              selectedIndex: selectedIndex,
              destinations: <NavigationRailDestination>[
                for (NavigationDestination destination in destinations)
                  NavigationRailDestination(
                    label: Text(destination.label),
                    icon: destination.icon,
                  )
              ],
            ),
          ),
        );
      },
    );
  }

  /// Public helper method to be used for creating a [BottomNavigationBar] from
  /// a list of [NavigationDestination]s.
  static BottomNavigationBar toBottomNavigationBar(
      {required List<NavigationDestination> destinations,
      Color selectedItemColor = Colors.black,
      Color backgroundColor = Colors.transparent}) {
    return BottomNavigationBar(
      backgroundColor: backgroundColor,
      selectedItemColor: selectedItemColor,
      items: <BottomNavigationBarItem>[
        for (NavigationDestination destination in destinations)
          BottomNavigationBarItem(
            label: destination.label,
            icon: destination.icon,
          )
      ],
    );
  }

  /// Animation from bottom offscreen up onto the screen.
  static AnimatedWidget bottomToTop(Widget child, Animation<double> animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  /// Animation from on the screen down off the screen.
  static AnimatedWidget topToBottom(Widget child, Animation<double> animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(0, 1),
      ).animate(animation),
      child: child,
    );
  }

  /// Animation from left off the screen into the screen.
  static AnimatedWidget leftOutIn(Widget child, Animation<double> animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  /// Animation from on screen to left off screen.
  static AnimatedWidget leftInOut(Widget child, Animation<double> animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(-1, 0),
      ).animate(animation),
      child: child,
    );
  }

  /// Animation from right off screen to on screen.
  static AnimatedWidget rightOutIn(Widget child, Animation<double> animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  /// Fade in animation.
  static Widget fadeIn(Widget child, Animation<double> animation) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeInCubic),
      child: child,
    );
  }

  /// Fade out animation.
  static Widget fadeOut(Widget child, Animation<double> animation) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: ReverseAnimation(animation), curve: Curves.easeInCubic),
      child: child,
    );
  }

  /// Keep widget on screen while it is leaving
  static Widget stayOnScreen(Widget child, Animation<double> animation) {
    return FadeTransition(
      opacity: Tween<double>(begin: 1.0, end: 1.0).animate(animation),
      child: child,
    );
  }
  @override
  State<AdaptiveScaffold> createState() => _AdaptiveScaffoldState();
}


class _AdaptiveScaffoldState extends State<AdaptiveScaffold> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: widget.drawerBreakpoint.isActive(context) ? widget.appBar ?? AppBar() : null,
        drawer: widget.drawerBreakpoint.isActive(context)
            ? Drawer(
                child: NavigationRail(
                  extended: true,
                  selectedIndex: widget.selectedIndex,
                  destinations: widget.destinations!.map(_toRailDestination).toList(),
                  onDestinationSelected: widget.onSelectedIndexChange,
                ),
              )
            : null,
        body: AdaptiveLayout(
          horizontalBody: widget.horizontalBody,
          bodyRatio: widget.bodyRatio,
          internalAnimations: widget.internalAnimations,
          primaryNavigation: widget.destinations != null && widget.selectedIndex != null
              ? SlotLayout(
                  config: <Breakpoint, SlotLayoutConfig>{
                    widget.breakpoints[1]: SlotLayoutConfig(
                      key: const Key('primaryNavigation'),
                      builder: (_) => SizedBox(
                        width: 72,
                        height: MediaQuery.of(context).size.height,
                        child: NavigationRail(
                          selectedIndex: widget.selectedIndex,
                          destinations: widget.destinations!.map(_toRailDestination).toList(),
                          onDestinationSelected: widget.onSelectedIndexChange,
                        ),
                      ),
                    ),
                    widget.breakpoints[2]: SlotLayoutConfig(
                      key: const Key('primaryNavigation1'),
                      builder: (_) => SizedBox(
                        width: 192,
                        height: MediaQuery.of(context).size.height,
                        child: NavigationRail(
                          extended: true,
                          selectedIndex: widget.selectedIndex,
                          destinations: widget.destinations!.map(_toRailDestination).toList(),
                          onDestinationSelected: widget.onSelectedIndexChange,
                        ),
                      ),
                    ),
                  },
                )
              : null,
          bottomNavigation: widget.destinations != null && widget.selectedIndex != null && Breakpoints.smallMobile.isActive(context)
              ? SlotLayout(
                  config: <Breakpoint, SlotLayoutConfig>{
                    widget.breakpoints[0]: SlotLayoutConfig(
                      key: const Key('bottomNavigation'),
                      builder: (_) => BottomNavigationBar(
                        unselectedItemColor: Colors.grey,
                        selectedItemColor: Colors.black,
                        items: widget.destinations!.map(_toBottomNavItem).toList(),
                      ),
                    ),
                    widget.breakpoints[1]: SlotLayoutConfig.empty(),
                    widget.breakpoints[2]: SlotLayoutConfig.empty(),
                  },
                )
              : null,
          body: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig?>{
              Breakpoints.standard: SlotLayoutConfig(
                key: const Key('body'),
                inAnimation: AdaptiveScaffold.fadeIn,
                outAnimation: AdaptiveScaffold.fadeOut,
                builder: widget.body,
              ),
              if(widget.smallBody!=null) widget.breakpoints[0]: (widget.smallBody!= AdaptiveScaffold.emptyBuilder) ? SlotLayoutConfig(
                key: const Key('smallBody'),
                inAnimation: AdaptiveScaffold.fadeIn,
                outAnimation: AdaptiveScaffold.fadeOut,
                builder: widget.smallBody,
              ):null,
              if(widget.body!=null) widget.breakpoints[1]: (widget.body!= AdaptiveScaffold.emptyBuilder) ? SlotLayoutConfig(
                key: const Key('body'),
                inAnimation: AdaptiveScaffold.fadeIn,
                outAnimation: AdaptiveScaffold.fadeOut,
                builder: widget.body,
              ):null,
              if(widget.largeBody!=null) widget.breakpoints[2]: (widget.largeBody!= AdaptiveScaffold.emptyBuilder) ? SlotLayoutConfig(
                key: const Key('largeBody'),
                inAnimation: AdaptiveScaffold.fadeIn,
                outAnimation: AdaptiveScaffold.fadeOut,
                builder: widget.largeBody,
              ):null,
            },
          ),
          secondaryBody: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig?>{
              Breakpoints.standard: SlotLayoutConfig(
                key: const Key('sBody'),
                outAnimation: AdaptiveScaffold.stayOnScreen,
                builder: widget.secondaryBody,
              ),
              if(widget.smallSecondaryBody!=null) widget.breakpoints[0]: (widget.smallSecondaryBody!= AdaptiveScaffold.emptyBuilder) ? SlotLayoutConfig(
                key: const Key('smallSBody'),
                outAnimation: AdaptiveScaffold.stayOnScreen,
                builder: widget.smallSecondaryBody,
              ):null,
              if(widget.secondaryBody!=null) widget.breakpoints[1]: (widget.secondaryBody!= AdaptiveScaffold.emptyBuilder) ? SlotLayoutConfig(
                key: const Key('sBody'),
                outAnimation: AdaptiveScaffold.stayOnScreen,
                builder: widget.secondaryBody,
              ):null,
             if(widget.largeSecondaryBody!=null) widget.breakpoints[2]: (widget.largeSecondaryBody!= AdaptiveScaffold.emptyBuilder) ? SlotLayoutConfig(
                key: const Key('largeSBody'),
                outAnimation: AdaptiveScaffold.stayOnScreen,
                builder: widget.largeSecondaryBody,
              ):null,
            },
          ),
        ),
      ),
    );
  }
}

NavigationRailDestination _toRailDestination(NavigationDestination destination) {
  return NavigationRailDestination(
    label: Text(destination.label),
    icon: destination.icon,
  );
}

BottomNavigationBarItem _toBottomNavItem(NavigationDestination destination) {
  return BottomNavigationBarItem(
    label: destination.label,
    icon: destination.icon,
  );
}
