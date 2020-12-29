import 'dart:math' as math;

import 'package:flutter/material.dart';

class CustomScrollSimulationExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Hello"),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 400,
                  maxHeight: constraints.maxHeight,
                ),
                child: ListView.builder(
                  physics: CustomScrollPyhsics(),
                  itemExtent: 250.0,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 9.0),
                      child: Material(
                        elevation: 4.0,
                        borderRadius: BorderRadius.circular(5.0),
                        color: index % 2 == 0 ? Colors.cyan : Colors.deepOrange,
                        child: Center(
                          child: Text(
                            "$index",
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                .copyWith(color: Colors.black),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ));
  }
}

class CustomSimulation extends Simulation {
  final double initPosition;
  final double velocity;

  CustomSimulation({this.initPosition, this.velocity});

  @override
  double x(double time) {
    var max =
        math.max(math.min(initPosition, 0.0), initPosition + velocity * time);
    print("This is distance: " + max.toString());
    return max;
  }

  @override
  double dx(double time) {
    print("This is velocity: " + velocity.toString());
    return velocity;
  }

  @override
  bool isDone(double time) {
    return true;
  }
}

class CustomScrollPyhsics extends ScrollPhysics {
  @override
  ScrollPhysics applyTo(ScrollPhysics ancestor) {
    return CustomScrollPyhsics();
  }

  @override
  Simulation createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    return CustomSimulation(initPosition: position.pixels, velocity: velocity);
  }
}
