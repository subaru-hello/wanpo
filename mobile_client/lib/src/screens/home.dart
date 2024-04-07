import 'package:flutter/material.dart';
import 'package:mobile_client/src/contexts/app_state.dart';
import 'package:mobile_client/src/contexts/navigator_contexts.dart';
import 'package:mobile_client/src/widgets/bottom_navigation_bar.dart';
import 'package:mobile_client/src/widgets/drawer.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    Widget page = appState.currentPage;
    return ChangeNotifierProvider<NavigatorNotifierState>(
        create: (context) => NavigatorNotifierState(),
        child: LayoutBuilder(builder: (context, constraints) {
          return Scaffold(
            appBar: AppBar(
              title: Icon(Icons.pets),
            ),
            drawer: WanpoDrawer(),
            body: Row(children: [
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page, // 現在選択されているページを表示
                ),
              ),
            ]),
            bottomNavigationBar: WanpoBottomNavigationBar(),
          );
        }));
  }
}
