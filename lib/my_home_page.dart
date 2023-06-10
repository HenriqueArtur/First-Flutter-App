import 'dart:js';

import 'package:first_flutter_app/favorites_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
    Widget page = pageToRender(selectedIndex);
    // The container for the current page, with its background color
    // and subtle switching animation.
    var mainArea = mainAreaBoxComponent(colorScheme, page);

    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return constraints.maxWidth < 450
            ? mainAreaCompactComponent(
                mainArea,
                selectedIndex,
                (value) => setState(() => (selectedIndex = value)),
              )
            : mainAreaComponent(mainArea, selectedIndex,
                (value) => setState(() => (selectedIndex = value)));
      }),
    );
  }
}

Widget pageToRender(int selectedIndex) {
  switch (selectedIndex) {
    case 0:
      return GeneratorPage();
    case 1:
      return FavoritesPage();
    default:
      throw UnimplementedError('no widget for $selectedIndex');
  }
}

ColoredBox mainAreaBoxComponent(ColorScheme colorScheme, Widget page) {
  return ColoredBox(
    color: colorScheme.surfaceVariant,
    child: AnimatedSwitcher(
      duration: Duration(milliseconds: 200),
      child: page,
    ),
  );
}

Widget mainAreaComponent(
    ColoredBox mainArea, int selectedIndex, Function setIndex) {
  return Column(children: [
    Expanded(child: mainArea),
    SafeArea(
        child: BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites")
      ],
      currentIndex: selectedIndex,
      onTap: (value) => setIndex(value),
    )),
    Expanded(child: mainArea),
  ]);
}

Widget mainAreaCompactComponent(
    ColoredBox mainArea, int selectedIndex, Function setIndex) {
  return Column(children: [
    Expanded(child: mainArea),
    SafeArea(
        child: BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites")
      ],
      currentIndex: selectedIndex,
      onTap: (value) => setIndex(value),
    )),
  ]);
}
