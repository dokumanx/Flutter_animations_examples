import 'package:flutter/material.dart';

class SimultaneousAnimations extends StatefulWidget {
  @override
  _SimultaneousAnimationsState createState() => _SimultaneousAnimationsState();
}

class _SimultaneousAnimationsState extends State<SimultaneousAnimations>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = _controller.drive(CurveTween(curve: Curves.easeInCubic))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
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
    return AnimatedLogo(
      animation: _animation,
    );
  }
}

class AnimatedLogo extends AnimatedWidget {
  static final Tween<double> sizeAnimation = Tween(begin: 100.0, end: 300.0);
  static final Tween<double> opacityAnimation = Tween(begin: 0.1, end: 1.0);

  AnimatedLogo({Animation<double> animation}) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Opacity(
        opacity: opacityAnimation.evaluate(animation),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          height: sizeAnimation.evaluate(animation),
          width: sizeAnimation.evaluate(animation),
          child: FlutterLogo(),
        ),
      ),
    );
  }
}
