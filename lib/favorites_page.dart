import 'package:first_flutter_app/my_app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    IconData icon = Icons.favorite;

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text("No favorites"),
      );
    }

    return ListView(
      children: [
        Padding(
            padding: const EdgeInsets.all(20),
            child: Text('You have ${appState.favorites.length} favorites: ')),
        for (final pair in appState.favorites)
          ListTile(
            leading: Icon(icon),
            title: Text(pair.asLowerCase),
          )
      ],
    );
  }
}
