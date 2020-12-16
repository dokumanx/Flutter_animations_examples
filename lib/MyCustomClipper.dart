import 'dart:math' as math;

import 'package:flutter/material.dart';

class ClipperExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyCustomPainter(),
    );
  }
}

class MyBezierClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var controlPoint1 = Offset(size.width / 4, size.height - 60);
    var endPoint1 = Offset(size.width / 2, size.height - 30);

    var controlPoint2 = Offset(3 / 4 * size.width, size.height);
    var endPoint2 = Offset(size.width, size.height - 40);

    return Path()
      ..lineTo(0, size.height)
      ..quadraticBezierTo(
          controlPoint1.dx, controlPoint1.dy, endPoint1.dx, endPoint1.dy)
      ..quadraticBezierTo(
          controlPoint2.dx, controlPoint2.dy, endPoint2.dx, endPoint2.dy)
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class MyArcToPointClipper extends CustomClipper<Path> {
  double radius = 20.0;

  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(radius, 0)
      ..lineTo(size.width - radius, 0)
      ..arcToPoint(Offset(size.width, radius))
      ..lineTo(size.width, size.height - radius)
      ..arcToPoint(Offset(size.width - radius, size.height),
          radius: Radius.circular(radius))
      ..lineTo(radius, size.height)
      ..arcToPoint(Offset(0, size.height - radius),
          clockwise: false, radius: Radius.circular(radius))
      ..lineTo(0, radius)
      ..arcToPoint(Offset(radius, 0), radius: Radius.circular(radius))
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class MyArtToClipper extends CustomClipper<Path> {
  double radius = 50;

  @override
  Path getClip(Size size) {
    double radius = 50;

    return Path()
      ..lineTo(size.width - radius, 0)
      ..arcTo(
          Rect.fromPoints(
              Offset(size.width - radius, 0), Offset(size.width, radius)),
          1.5 * math.pi,
          0.5 * math.pi,
          true)
      ..lineTo(size.width, size.height - radius)
      ..arcTo(
          Rect.fromCircle(
              center: Offset(size.width - radius, size.height - radius),
              radius: radius),
          0,
          0.5 * math.pi,
          false)
      ..lineTo(radius, size.height)
      ..arcTo(Rect.fromLTRB(0, size.height - radius, radius, size.height),
          0.5 * math.pi, 0.5 * math.pi, false)
      ..lineTo(0, radius)
      ..arcTo(Rect.fromLTWH(0, 0, 70, 100), 1 * math.pi, 0.5 * math.pi, false)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class MyCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    Path path = Path()
      ..moveTo(size.width / 4, size.height / 4)
      ..relativeQuadraticBezierTo(
          size.width / 2, size.height, size.width, size.height / 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
