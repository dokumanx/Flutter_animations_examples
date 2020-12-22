import 'package:flutter/material.dart';

class RefactorWithAnimatedBuilder extends StatefulWidget {
  @override
  _RefactorWithAnimatedBuilderState createState() =>
      _RefactorWithAnimatedBuilderState();
}

class _RefactorWithAnimatedBuilderState
    extends State<RefactorWithAnimatedBuilder>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    animation = Tween(begin: 100.0, end: 300.0)
        .chain(CurveTween(curve: Curves.elasticOut))
        .animate(_controller)
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
    return Center(
      child: GrowTransition(
        child: LogoWidget(),
        animation: animation,
      ),
    );
  }
}

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: FlutterLogo(),
    );
  }
}

class GrowTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  GrowTransition({this.child, this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Container(
        width: animation.value,
        height: animation.value,
        child: child,
      ),
      child: child,
    );
  }
}
