import 'package:flutter/material.dart';
import 'package:flutter_animations/johannes_mike_examples/animated_list_example.dart';
import 'file:///D:/flutter_sample_projects/flutter_animations/lib/johannes_mike_examples/advent_door.dart';
import 'package:flutter_animations/tensor_examples/custom_scroll_simulation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AnimatedListExample(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(duration: Duration(seconds: 5), vsync: this)
          ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotationTransition(
              alignment: Alignment.center,
              turns: _controller,
              child: Container(
                color: Colors.blue,
                height: 100,
                width: 100,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TimeStopper(
              controller: _controller,
            )
          ],
        ),
      ),
    );
  }
}

class TimeStopper extends StatelessWidget {
  final AnimationController controller;

  const TimeStopper({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.pinkAccent,
      onPressed: () {
        if (controller.isAnimating) {
          controller.stop();
        } else {
          controller.repeat();
        }
      },
      child: Text(controller.isAnimating ? "Stop" : "Start"),
    );
  }
}
