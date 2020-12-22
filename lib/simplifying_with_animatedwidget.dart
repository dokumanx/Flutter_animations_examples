import 'package:flutter/material.dart';

class SimplifyWithAnimatedWidget extends StatefulWidget {
  @override
  _SimplifyWithAnimatedWidgetState createState() =>
      _SimplifyWithAnimatedWidgetState();
}

class _SimplifyWithAnimatedWidgetState extends State<SimplifyWithAnimatedWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = Tween(begin: 0.0, end: 300.0)
        .chain(CurveTween(curve: Curves.easeInCubic))
        .animate(_controller)
          ..addStatusListener((status) {
            print("Animation Current Status: $status");
          })
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
      animation: animation,
    );
  }
}

class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      ),
    );
  }
}
