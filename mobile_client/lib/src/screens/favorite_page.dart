import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../contexts/app_state.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // App stateを呼び出している
    var appState = context.watch<AppState>();
    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('いいねをした日誌がありません'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('あなたがいいねした日誌は '
              '${appState.favorites.length} 個です:'),
        ),
        for (var favo in appState.wordCombined)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(favo),
          ),
      ],
    );
  }
}
