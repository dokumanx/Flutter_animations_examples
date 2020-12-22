import 'package:flutter/material.dart';

class RenderingAnimations extends StatefulWidget {
  @override
  _RenderingAnimationsState createState() => _RenderingAnimationsState();
}

class _RenderingAnimationsState extends State<RenderingAnimations>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = Tween(begin: 0.0, end: 300.0)
        .chain(CurveTween(curve: Curves.easeIn))
        .animate(_controller)
          ..addListener(() {
            setState(() {});
          });

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: animation.value,
      width: animation.value,
      child: FlutterLogo(),
    ));
  }
}
