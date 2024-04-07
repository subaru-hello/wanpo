import 'package:flutter/material.dart';
import 'package:mobile_client/src/contexts/app_state.dart';
import 'package:mobile_client/src/route/route.dart';
import 'package:provider/provider.dart';

class TopPage extends StatefulWidget {
  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.login),
            onPressed: () {
              appState.navigateTo(routeLogin);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => LoginPage()),
              // );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              "withビション",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton.icon(
              onPressed: () {
                appState.navigateTo(routeDogs);
              },
              icon: Icon(Icons.pets),
              label: Text("他のビションを見る"))
        ],
      ),
    );
  }
}
