import 'package:flutter/material.dart';

class MyExpantedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                padding: EdgeInsets.all(8.0),
                child: Text("Hello, world!"),
                color: Colors.blue),
            Container(
                width: 80,
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Hello, earth! Hello, earth! Hello, earth!",
                ),
                color: Colors.red),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                padding: EdgeInsets.all(8.0),
                child: Text("Hello, earth!"),
                color: Colors.green)
          ],
        ),
      ),
    );
  }
}
