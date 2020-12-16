import 'package:flutter/material.dart';

const owl_url =
    'https://raw.githubusercontent.com/flutter/website/master/src/images/owl.jpg';

class FadeInDemo extends StatefulWidget {
  _FadeInDemoState createState() => _FadeInDemoState();
}

class _FadeInDemoState extends State<FadeInDemo> {
  double opacity = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Image.network(owl_url),
      RaisedButton(
          child: Text(
            'Show details',
            style: TextStyle(color: Colors.blueAccent),
          ),
          onPressed: () {
            setState(() {
              opacity = opacity == 0 ? 1 : 0;
            });
          }),
      SizedBox(height: 20.0),
      AnimatedOpacity(
        opacity: opacity,
        duration: Duration(seconds: 1),
        curve: Curves.easeOutBack,
        child: Column(
          children: <Widget>[
            Text('Type: Owl'),
            Text('Age: 39'),
            Text('Employment: None'),
          ],
        ),
      )
    ]);
  }
}
