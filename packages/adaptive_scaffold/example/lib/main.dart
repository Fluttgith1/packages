// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:adaptive_scaffold/adaptive_scaffold.dart';
import 'package:flutter/material.dart';

/// A more functional demo of the usage of the adaptive layout helper widgets.
/// Specifically, it is built using an [AdaptiveLayout] and uses static helpers
/// from [AdaptiveScaffold].
///
/// Modeled off of the example on the Material 3 page regarding adaptive layouts.
/// For a more clear cut example usage, please look at adaptive_layout_demo.dart
/// or adaptive_scaffold_demo.dart

void main() {
  runApp(const _MyApp());
}

class _MyApp extends StatelessWidget {
  const _MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adaptive Layout Demo',
      routes: <String, Widget Function(BuildContext)>{
        _ExtractRouteArguments.routeName: (_) => const _ExtractRouteArguments()
      },
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(),
    );
  }
}

/// Creates an example mail page using [AdaptiveLayout].
class MyHomePage extends StatefulWidget {
  /// Creates a const [MyHomePage].
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with TickerProviderStateMixin, ChangeNotifier {
  // A listener used for the controllers to reanimate the staggered animation of
  // the navigation elements.
  ValueNotifier<bool?> showGridView = ValueNotifier<bool?>(false);

  // The index of the selected mail card.
  int? selected;
  void selectCard(int? index) {
    setState(() {
      selected = index;
    });
  }

  // The index of the navigation screen. Only impacts body/secondaryBody
  int _navigationIndex = 0;

  // The controllers used for the staggered animation of the navigation elements.
  late AnimationController _controller;
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;
  @override
  void initState() {
    showGridView.addListener(() {
      Navigator.popUntil(
          context, (Route<dynamic> route) => route.settings.name == '/');
      _controller
        ..reset()
        ..forward();
      _controller1
        ..reset()
        ..forward();
      _controller2
        ..reset()
        ..forward();
      _controller3
        ..reset()
        ..forward();
    });
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..forward();
    _controller1 = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..forward();
    _controller2 = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    )..forward();
    _controller3 = AnimationController(
      duration: const Duration(milliseconds: 1600),
      vsync: this,
    )..forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color iconColor = Color.fromARGB(255, 29, 25, 43);
    final Widget trailingNavRail = Column(
      children: <Widget>[
        const Divider(color: Colors.white, thickness: 1.5),
        const SizedBox(height: 10),
        Row(children: <Widget>[
          const SizedBox(width: 22),
          Text('Folders',
              style: TextStyle(fontSize: 13, color: Colors.grey[700]))
        ]),
        const SizedBox(height: 22),
        Row(
          children: <Widget>[
            const SizedBox(width: 16),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.folder_copy_outlined),
                iconSize: 21),
            const SizedBox(width: 21),
            const Text('Freelance'),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: <Widget>[
            const SizedBox(width: 16),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.folder_copy_outlined),
                iconSize: 21),
            const SizedBox(width: 21),
            const Text('Mortage'),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: <Widget>[
            const SizedBox(width: 16),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.folder_copy_outlined),
                iconSize: 21),
            const SizedBox(width: 21),
            const Flexible(
                child: Text('Taxes', overflow: TextOverflow.ellipsis))
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: <Widget>[
            const SizedBox(width: 16),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.folder_copy_outlined),
                iconSize: 21),
            const SizedBox(width: 21),
            const Flexible(
                child: Text('Receipts', overflow: TextOverflow.ellipsis))
          ],
        ),
      ],
    );

    // These are the destinations used within the AdaptiveScaffold navigation
    // builders.
    const List<NavigationDestination> destinations = <NavigationDestination>[
      NavigationDestination(
          label: 'Inbox', icon: Icon(Icons.inbox, color: iconColor)),
      NavigationDestination(
          label: 'Articles',
          icon: Icon(Icons.article_outlined, color: iconColor)),
      NavigationDestination(
          label: 'Chat',
          icon: Icon(Icons.chat_bubble_outline, color: iconColor)),
      NavigationDestination(
          label: 'Video',
          icon: Icon(Icons.video_call_outlined, color: iconColor))
    ];

    // Updating the listener value.
    showGridView.value = Breakpoints.mediumAndUp.isActive(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 227, 241),
      // Usage of AdaptiveLayout suite begins here. AdaptiveLayout takes
      // LayoutSlots for its variety of screen slots.
      body: AdaptiveLayout(
        // Each SlotLayout has a config which maps Breakpoints to
        // SlotLayoutConfigs.
        primaryNavigation: SlotLayout(
          config: <Breakpoint, SlotLayoutConfig?>{
            // The breakpoint used here is from the Breakpoints class but custom
            // Breakpoints can be defined by extending the Breakpoint class
            Breakpoints.medium: SlotLayout.from(
              // Every SlotLayoutConfig takes a key and a builder. The builder
              // is to save memory that would be spent on initialization.
              key: const Key('primaryNavigation'),
              builder: (_) =>
                  // Usually it would be easier to use a builder from
                  // AdaptiveScaffold for these types of navigations but this
                  // navigation has custom staggered item animations.
                  AdaptiveScaffold.standardNavigationRail(
                onDestinationSelected: (int index) {
                  setState(() {
                    _navigationIndex = index;
                  });
                },
                selectedIndex: _navigationIndex,
                leading: ScaleTransition(
                    scale: _controller1, child: const _MediumComposeIcon()),
                backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                labelType: NavigationRailLabelType.none,
                destinations: <NavigationRailDestination>[
                  slideInNavigationItem(
                      begin: -1,
                      controller: _controller,
                      icon: Icons.inbox,
                      label: 'Inbox'),
                  slideInNavigationItem(
                      begin: -2,
                      controller: _controller1,
                      icon: Icons.article_outlined,
                      label: 'Articles'),
                  slideInNavigationItem(
                      begin: -3,
                      controller: _controller2,
                      icon: Icons.chat_bubble_outline,
                      label: 'Chat'),
                  slideInNavigationItem(
                      begin: -4,
                      controller: _controller3,
                      icon: Icons.video_call_outlined,
                      label: 'Video')
                ],
              ),
            ),
            Breakpoints.large: SlotLayout.from(
                key: const Key('primaryNavigation1'),
                // The AdaptiveScaffold builder here greatly simplifies
                // navigational elements.
                builder: (_) => AdaptiveScaffold.standardNavigationRail(
                      leading: const _LargeComposeIcon(),
                      onDestinationSelected: (int index) {
                        setState(() {
                          _navigationIndex = index;
                        });
                      },
                      selectedIndex: _navigationIndex,
                      trailing: trailingNavRail,
                      extended: true,
                      destinations: destinations
                          .map((_) => AdaptiveScaffold.toRailDestination(_))
                          .toList(),
                    )),
          },
        ),
        body: SlotLayout(
          config: <Breakpoint, SlotLayoutConfig?>{
            Breakpoints.standard: SlotLayout.from(
                key: const Key('body'),
                // The conditional here is for navigation screens. The first
                // screen shows the main screen and every other screeen shows
                //  ExamplePage.
                builder: (_) => (_navigationIndex == 0)
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
                        child: _ItemList(
                            selected: selected,
                            items: allItems,
                            selectCard: selectCard),
                      )
                    : const _ExamplePage()),
          },
        ),
        secondaryBody: _navigationIndex == 0
            ? SlotLayout(
                config: <Breakpoint, SlotLayoutConfig?>{
                  Breakpoints.mediumAndUp: SlotLayout.from(
                      // This overrides the default behavior of the secondaryBody
                      // disappearing as it is animating out.
                      outAnimation: AdaptiveScaffold.stayOnScreen,
                      key: const Key('sBody'),
                      builder: (_) =>
                          _DetailTile(item: allItems[selected ?? 0]))
                },
              )
            : null,
        bottomNavigation: SlotLayout(
          config: <Breakpoint, SlotLayoutConfig?>{
            Breakpoints.small: SlotLayout.from(
                key: const Key('bottomNavigation'),
                // You can define inAnimations or outAnimations to override the
                // default offset transition.
                outAnimation: AdaptiveScaffold.topToBottom,
                builder: (_) => BottomNavigationBarTheme(
                    data: const BottomNavigationBarThemeData(
                        selectedItemColor: Colors.black),
                    child: AdaptiveScaffold.standardBottomNavigationBar(
                        destinations: destinations)))
          },
        ),
      ),
    );
  }

  NavigationRailDestination slideInNavigationItem({
    required double begin,
    required AnimationController controller,
    required IconData icon,
    required String label,
  }) {
    return NavigationRailDestination(
        icon: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(begin, 0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: controller, curve: Curves.easeInOutCubic),
            ),
            child: Icon(icon)),
        label: Text(label));
  }
}

class _SmallComposeIcon extends StatelessWidget {
  const _SmallComposeIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 254, 215, 227),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 2)),
          ],
        ),
        width: 50,
        height: 50,
        child: const Icon(Icons.edit_outlined));
  }
}

class _MediumComposeIcon extends StatelessWidget {
  const _MediumComposeIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 18),
        child: const Icon(Icons.menu),
      ),
      const _SmallComposeIcon(),
    ]);
  }
}

class _LargeComposeIcon extends StatelessWidget {
  const _LargeComposeIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 5, 0, 12),
      child: Column(children: <Widget>[
        Container(
            padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text('REPLY',
                    style: TextStyle(color: Colors.deepPurple, fontSize: 15)),
                Icon(Icons.menu_open, size: 22)
              ],
            )),
        const SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 225, 231),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            boxShadow: Breakpoints.mediumAndUp.isActive(context)
                ? null
                : <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 2)),
                  ],
          ),
          width: 200,
          height: 50,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
            child: Row(
              children: const <Widget>[
                Icon(Icons.edit_outlined),
                SizedBox(width: 20),
                Center(child: Text('Compose')),
              ],
            ),
          ),
        )
      ]),
    );
  }
}

// ItemList creates the list of cards and the search bar.
class _ItemList extends StatelessWidget {
  const _ItemList({
    Key? key,
    required this.items,
    required this.selectCard,
    required this.selected,
  }) : super(key: key);

  final List<_Item> items;
  final int? selected;
  final Function selectCard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 0, 0, 0),
      floatingActionButton: Breakpoints.mediumAndUp.isActive(context)
          ? null
          : const _SmallComposeIcon(),
      body: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: const Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Icon(Icons.search),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: CircleAvatar(
                          radius: 18,
                          child: Image.asset('images/woman.png'),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      contentPadding: const EdgeInsets.all(25),
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 135, 129, 138)),
                      hintText: 'Search replies',
                      fillColor: Colors.white))),
          Expanded(
              child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) => _ItemListTile(
                item: items[index],
                email: items[index].emails![0],
                selectCard: selectCard,
                selected: selected),
          ))
        ],
      ),
    );
  }
}

class _ItemListTile extends StatelessWidget {
  const _ItemListTile({
    Key? key,
    required this.item,
    required this.email,
    required this.selectCard,
    required this.selected,
  }) : super(key: key);

  final _Item item;
  final _Email email;
  final int? selected;
  final Function selectCard;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // The behavior of opening a detail view is different on small screens
        // than large screens.
        // Small screens open a modal with the detail view while large screens
        // simply show the details on the secondaryBody.
        selectCard(allItems.indexOf(item));
        if (!Breakpoints.mediumAndUp.isActive(context)) {
          Navigator.of(context).pushNamed(_ExtractRouteArguments.routeName,
              arguments: _ScreenArguments(item: item, selectCard: selectCard));
        } else {
          selectCard(allItems.indexOf(item));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: selected == allItems.indexOf(item)
                  ? const Color.fromARGB(255, 234, 222, 255)
                  : const Color.fromARGB(255, 243, 237, 247),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(radius: 18, child: Image.asset(email.image)),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(email.sender,
                            style: Theme.of(context).textTheme.bodyLarge),
                        const SizedBox(height: 3),
                        Text('${email.time} ago',
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Icon(Icons.star_outline, color: Colors.grey[500]),
                    ),
                  ],
                ),
                const SizedBox(height: 13),
                Text(item.title,
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 9),
                Text(email.body.replaceRange(116, email.body.length, '...'),
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 9),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: (email.bodyImage != '')
                        ? Image.asset(email.bodyImage)
                        : Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailTile extends StatelessWidget {
  const _DetailTile({
    required this.item,
    Key? key,
  }) : super(key: key);
  final _Item item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Container(
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 245, 241, 248),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                                child: Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(item.title,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge),
                                          const SizedBox(height: 7),
                                          Text(
                                              '${item.emails!.length} Messages',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall)
                                        ]))),
                            Container(
                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      child: Icon(Icons.restore_from_trash,
                                          color: Colors.grey[600]),
                                    ),
                                    const SizedBox(width: 15),
                                    Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        child: Icon(Icons.more_vert,
                                            color: Colors.grey[600]))
                                  ],
                                )),
                          ]),
                      const SizedBox(height: 20),
                    ],
                  )),
              Expanded(
                  child: ListView.builder(
                      itemCount: item.emails!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final _Email thisEmail = item.emails![index];
                        return _EmailTile(
                            sender: thisEmail.sender,
                            time: thisEmail.time,
                            senderIcon: thisEmail.image,
                            recepients: thisEmail.recepients,
                            body: thisEmail.body,
                            bodyImage: thisEmail.bodyImage);
                      })),
              //Text(item.body, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailTile extends StatelessWidget {
  const _EmailTile({
    required this.sender,
    required this.time,
    required this.senderIcon,
    required this.recepients,
    required this.body,
    required this.bodyImage,
    Key? key,
  }) : super(key: key);

  final String sender;
  final String time;
  final String senderIcon;
  final String recepients;
  final String body;
  final String bodyImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 18,
                    child: Image.asset(senderIcon),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(sender,
                          style:
                              TextStyle(color: Colors.grey[850], fontSize: 13)),
                      const SizedBox(height: 3),
                      Text('$time ago',
                          style: Theme.of(context).textTheme.caption),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 245, 241, 248),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Icon(Icons.star_outline, color: Colors.grey[500]),
                  ),
                ],
              ),
              if (recepients != '')
                Column(children: <Widget>[
                  const SizedBox(height: 15),
                  Text('To $recepients',
                      style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                ])
              else
                Container(),
              const SizedBox(height: 15),
              Text(body,
                  style: TextStyle(
                      color: Colors.grey[700], height: 1.35, fontSize: 14.5)),
              const SizedBox(height: 9),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child:
                      (bodyImage != '') ? Image.asset(bodyImage) : Container()),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(
                      width: 126,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0))),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 245, 241, 248)),
                          side: MaterialStateProperty.all(const BorderSide(
                              width: 0.0, color: Colors.transparent)),
                        ),
                        child: Text(
                          'Reply',
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 12),
                        ),
                      )),
                  SizedBox(
                      width: 126,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0))),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 245, 241, 248)),
                          side: MaterialStateProperty.all(const BorderSide(
                              width: 0.0, color: Colors.transparent)),
                        ),
                        child: Text(
                          'Reply all',
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 12),
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// The ScreenArguments used to pass arguments to the RouteDetailView as a named
// route.
class _ScreenArguments {
  _ScreenArguments({
    required this.item,
    required this.selectCard,
  });
  final _Item item;
  final Function selectCard;
}

class _ExtractRouteArguments extends StatelessWidget {
  const _ExtractRouteArguments({Key? key}) : super(key: key);

  static const String routeName = '/detailView';

  @override
  Widget build(BuildContext context) {
    final _ScreenArguments args =
        ModalRoute.of(context)!.settings.arguments! as _ScreenArguments;

    return _RouteDetailView(item: args.item, selectCard: args.selectCard);
  }
}

class _RouteDetailView extends StatelessWidget {
  const _RouteDetailView({
    required this.item,
    required this.selectCard,
    Key? key,
  }) : super(key: key);

  final _Item item;
  final Function selectCard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: TextButton(
              onPressed: () {
                Navigator.popUntil(context,
                    (Route<dynamic> route) => route.settings.name == '/');
                selectCard(null);
              },
              child: const Icon(Icons.arrow_back),
            ),
          ),
          Expanded(child: _DetailTile(item: item)),
        ],
      ),
    );
  }
}

class _ExamplePage extends StatelessWidget {
  const _ExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.grey);
  }
}

class _Item {
  const _Item({
    required this.title,
    required this.emails,
  });

  final String title;
  final List<_Email>? emails;
}

class _Email {
  const _Email({
    required this.sender,
    required this.recepients,
    required this.image,
    required this.time,
    required this.body,
    required this.bodyImage,
  });

  final String sender;
  final String recepients;
  final String image;
  final String time;
  final String body;
  final String bodyImage;
}

/// List of items, each representing a thread of emails which will populate
/// the different layouts.
const List<_Item> allItems = <_Item>[
  _Item(
    title: 'Dinner Club',
    emails: <_Email>[
      _Email(
        sender: 'So Duri',
        recepients: 'me, Ziad and Lily',
        image: 'images/young-man.png',
        time: '20 min',
        body:
            "I think it's time for us to finally try that new noodle shop downtown that doesn't use menus. I'm so intrigued by this idea of a noodle restaurant where no one gets to order for themselves - could be fun, or terrible, or both :)",
        bodyImage: '',
      ),
      _Email(
          sender: 'Me',
          recepients: 'me, Ziad, and Lily',
          image: 'images/woman.png',
          time: '4 min',
          body:
              'Yes! I forgot about that place! Im definitely up for taking a risk this week and handing control over to this mysterious noodle chef. I wonder what happens if you have allergies though? Lucky none of us have any otherwise Id be a bit concerned.',
          bodyImage: ''),
      _Email(
          sender: 'Ziad Aouad',
          recepients: 'me, Ziad and Lily',
          image: 'images/man.png',
          time: '2 min',
          body:
              'Hey guys! Im pretty sure if you tell your waiter about any food restrictions or allergies, they should be able to cater to it. Im super excited though, see yall soon!',
          bodyImage: ''),
    ],
  ),
  _Item(
    title: '7 Best Yoga Poses for Strength Training',
    emails: <_Email>[
      _Email(
        sender: 'Elaine Howley',
        time: '2 hours',
        body:
            'Though many people think of yoga as mostly a way to stretch out and relax, in actuality, it can provide a fantastic full-body workout that can even make you stronger.',
        image: 'images/beauty.png',
        bodyImage: 'images/yoga.png',
        recepients: '',
      ),
    ],
  ),
  _Item(
    title: 'A Programming Language for Hardware Accelerators',
    emails: <_Email>[
      _Email(
        sender: 'Laney Mansell',
        time: '10 min',
        body:
            'Moore’s Law needs a hug. The days of stuffing transistors on little silicon computer chips are numbered, and their life rafts — hardware accelerators — come with a price. ',
        image: 'images/woman2.png',
        bodyImage: '',
        recepients: '',
      ),
    ],
  ),
];
