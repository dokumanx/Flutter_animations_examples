import 'package:flutter/material.dart';

class MyExplicitAnimation extends StatefulWidget {
  @override
  _MyExplicitAnimationState createState() => _MyExplicitAnimationState();
}

class _MyExplicitAnimationState extends State<MyExplicitAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3))
          ..repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BeamTransition(animation: _controller));
  }
}

class BeamClipper extends CustomClipper<Path> {
  const BeamClipper();

  @override
  getClip(Size size) {
    return Path()
      ..lineTo(size.width / 2, size.height / 2)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(size.width / 2, size.height / 2)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BeamTransition extends AnimatedWidget {
  BeamTransition({@required this.animation}) : super(listenable: animation);

  Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: const BeamClipper(),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(
              gradient: RadialGradient(
                  stops: [0, animation.value / 1.2, animation.value],
                  radius: 1.5,
                  colors: [Colors.yellow, Colors.orange, Colors.transparent])),
          height: 400,
          width: double.infinity,
        ),
      ),
    );
  }
}
