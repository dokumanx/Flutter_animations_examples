import 'dart:math' as math;

import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool flipped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlipWidget(
            from: buildImageWithClipRRect("assets/image.jpg"),
            to: buildImageWithClipRRect("assets/image_covered.jpg"),
            animationStatus:
                flipped ? AnimationStatus.forward : AnimationStatus.reverse,
          ),
          SizedBox(
            height: 30,
          ),
          buildButton(context),
        ],
      )),
    );
  }

  // Another way of building image with ConstrainedBox And AspectRatio
  // More complex and redundant way. But good to see different approaches
  // in any way.
  Widget buildImage() {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 300, maxWidth: 300),
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage("assets/image.jpg"),
                fit: BoxFit.cover,
              )),
        ),
      ),
    );
  }

  Widget buildImageWithClipRRect(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Image.asset(
        image,
        height: 250,
        width: 300,
        fit: BoxFit.cover,
      ),
    );
  }

  OutlineButton buildButton(BuildContext context) {
    final String buttonText = flipped ? "Reverse flip" : " Flip forward";

    return OutlineButton(
      onPressed: () {
        setState(() {
          flipped = !flipped;
        });
      },
      child: Text(buttonText),
      borderSide: BorderSide(
        width: 2.0,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

class FlipWidget extends StatefulWidget {
  final Widget from;
  final Widget to;
  final AnimationStatus animationStatus;

  const FlipWidget({Key key, this.from, this.to, this.animationStatus})
      : super(key: key);

  @override
  _FlipWidgetState createState() => _FlipWidgetState();
}

class _FlipWidgetState extends State<FlipWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  CurvedAnimation curvedAnimation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    final flipCurve = Cubic(0.455, 0.030, 0.515, 0.955);

    curvedAnimation = CurvedAnimation(parent: _controller, curve: flipCurve);

    super.initState();
  }

  @override
  void didUpdateWidget(covariant FlipWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.animationStatus != widget.animationStatus) {
      switch (widget.animationStatus) {
        case AnimationStatus.forward:
          _controller.reset();
          _controller.forward();
          break;
        case AnimationStatus.reverse:
          _controller.reverse();
          break;
        default:
          break;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final Widget child = _controller.value <= 0.5 &&
                widget.animationStatus != AnimationStatus.completed
            ? widget.from
            : widget.to;

        final mirror = _controller.value <= 0.5
            ? Container(
                child: child,
              )
            : Transform(
                alignment: Alignment.bottomCenter,
                transform: Matrix4.rotationX(math.pi),
                child: child,
              );

        return slideUpTransition(
            child: alignmentRotateTransition(child: mirror));
      },
    );
  }

  Widget alignmentRotateTransition({Widget child}) {
    final alignTransition =
        AlignmentTween(begin: Alignment.topCenter, end: Alignment.bottomCenter);

    return Transform(
      alignment: alignTransition.animate(curvedAnimation).value,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(_controller.value * math.pi),
      child: child,
    );
  }

  Widget slideUpTransition({Widget child}) {
    final Tween<Offset> slideUp =
        Tween<Offset>(begin: Offset.zero, end: Offset(0, -1));
    return SlideTransition(
      position: slideUp.animate(curvedAnimation),
      child: child,
    );
  }
}
