import 'package:flutter/material.dart';
import 'package:flutter_introduce/utils/counter_model.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class Samurai extends StatelessWidget {
  const Samurai({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 500,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Consumer<CounterModel>(
                builder: (context, notifier, child) {
                  return Transform.scale(
                    scale: math.max(0, 1 - notifier.page),
                    child: Opacity(
                      opacity: math.max(0, math.max(0, 1 - notifier.page)),
                      child: child,
                    ),
                  );
                },
                child: Container(
                  width: 340,
                  height: 340,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle
                  ),
                ),
              ),
              Consumer<CounterModel>(
                builder: (context, notifier, child) {
                  return Transform.rotate(
                    angle: math.max(0, (math.pi / 3) * 4 * notifier.page),
                    child: child,
                  );
                },
                child: Container(
                  width: 150,
                  height: 400,
                  color: Colors.red,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}