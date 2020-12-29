import 'dart:math' as math;

import 'package:flutter/material.dart';

class AdventDoor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          width: 200.0,
          height: 200.0,
          child: CalendarDoorWidget(
            child: Image.asset(
              "assets/advent9.png",
              fit: BoxFit.fill,
            ),
            innerDoor: buildInnerDoor(context),
            outerDoor: buildOuterDoor(context, number: 8),
          ),
        ),
      ),
    );
  }

  Widget buildOuterDoor(BuildContext context, {int number}) => Container(
        color: Colors.red,
        child: Center(
          child: Text(
            '$number',
            style: Theme.of(context)
                .textTheme
                .headline1
                .copyWith(color: Colors.white),
          ),
        ),
      );

  Widget buildInnerDoor(BuildContext context) => Container(
        color: Colors.green[700],
      );
}

class CalendarDoorWidget extends StatefulWidget {
  final Widget child;
  final Widget innerDoor;
  final Widget outerDoor;
  final bool opened;

  const CalendarDoorWidget(
      {Key key,
      @required this.innerDoor,
      @required this.outerDoor,
      @required this.child,
      this.opened = false})
      : super(key: key);

  @override
  _CalendarDoorWidgetState createState() => _CalendarDoorWidgetState();
}

class _CalendarDoorWidgetState extends State<CalendarDoorWidget>
    with SingleTickerProviderStateMixin {
  static final flipCurve = Cubic(0.455, 0.030, 0.515, 0.955);
  AnimationController _controller;
  Animation<double> animation;

  bool opened;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    animation = CurvedAnimation(curve: flipCurve, parent: _controller)
        .drive(Tween<double>(begin: 0.0, end: 1.0));

    opened = widget.opened;
    if (opened) {
      _controller.value = 1.0;
    }

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onTap() {
    if (opened) return;
    opened = true;
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // If this was 1.0, door would be opened fully.
    // 0.6 means that door will be open of 60%.
    final double openDoorUntil = 0.6;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final Widget door = _controller.value < 0.5 / openDoorUntil
              ? widget.outerDoor
              : widget.innerDoor;

          return Stack(fit: StackFit.expand, children: [
            widget.child,
            Transform(
              alignment: Alignment.centerRight,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(-math.pi * _controller.value * openDoorUntil),
              child: door,
            )
          ]);
        },
      ),
    );
  }
}
