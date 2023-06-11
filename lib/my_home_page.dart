import 'package:first_flutter_app/favorites_page.dart';
import 'package:flutter/material.dart';

import 'generator_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    Widget page = selectPage(selectedIndex);

    // The container for the current page, with its background color
    // and subtle switching animation.
    var mainArea = ColoredBox(
      color: colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: page,
      ),
    );

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 450) {
            return mobileRender(
                mainArea,
                selectedIndex,
                (value) => {
                      setState(() {
                        selectedIndex = value;
                      })
                    });
          } else {
            return desktopRender(
                mainArea,
                selectedIndex,
                (value) => {
                      setState(() {
                        selectedIndex = value;
                      })
                    },
                constraints);
          }
        },
      ),
    );
  }
}

Widget selectPage(int pageIndex) {
  switch (pageIndex) {
    case 0:
      return GeneratorPage();
    case 1:
      return FavoritesPage();
    default:
      throw UnimplementedError('no widget for $pageIndex');
  }
}

Widget mobileRender(
    ColoredBox mainArea, int selectedIndex, Function onTapCallback) {
  return Column(
    children: [
      Expanded(child: mainArea),
      SafeArea(
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
          ],
          currentIndex: selectedIndex,
          onTap: (value) => onTapCallback(value),
        ),
      )
    ],
  );
}

Widget desktopRender(ColoredBox mainArea, int selectedIndex,
    Function onTapCallback, BoxConstraints constraints) {
  return Row(
    children: [
      SafeArea(
        child: NavigationRail(
          extended: constraints.maxWidth >= 600,
          destinations: [
            NavigationRailDestination(
              icon: Icon(Icons.home),
              label: Text('Home'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.favorite),
              label: Text('Favorites'),
            ),
          ],
          selectedIndex: selectedIndex,
          onDestinationSelected: (value) => onTapCallback(value),
        ),
      ),
      Expanded(child: mainArea),
    ],
  );
}
