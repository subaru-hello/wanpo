import 'package:flutter/material.dart';
import 'package:mobile_client/src/screens/dog_page.dart';

class TopPage extends StatefulWidget {
  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DogPage()));
              },
              icon: Icon(Icons.pets),
              label: Text("他のビションを見る"))
        ],
      ),
    );
  }
}
