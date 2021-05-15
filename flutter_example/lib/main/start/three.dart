import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

import '../../utils/counter_model.dart';

class Three extends StatelessWidget {
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
                    scale: math.max(0, 1 - (1 - (4 * notifier.page - 7))),
                    child: child,
                  );
                },
                child: Container(
                  width: 340,
                  height: 340,
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    shape: BoxShape.circle
                  ),
                ),
              ),
              Consumer<CounterModel>(
                builder: (context, notifier, child) {
                  return Transform(
                    alignment: FractionalOffset.center,
                    transform: Matrix4.translationValues(0, 100 * (1 - (4 * notifier.page - 7)), 0)..rotateZ((-math.pi / 2) * 2 * notifier.page),
                    child: child,
                  );
                },
                child: Container(
                  width: 150,
                  height: 400,
                  alignment: Alignment.center,
                  child: FlutterLogo(size: 200),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.2),
                        Colors.blueAccent.withOpacity(0.2),
                        Colors.blue,
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 20),
        Consumer<CounterModel>(
          builder: (context, notifier, child) {
            return Transform.translate(
              offset: Offset(0, 50 * (1 - (4 * notifier.page - 7))),
              child: child,
            );
          },
          child: Text(
            "开始使用",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, letterSpacing: 5),
          ),
        ),
        SizedBox(height: 20),
        Consumer<CounterModel>(
          builder: (context, notifier, child) {
            return Opacity(
              opacity: math.max(0, 4 * notifier.page - 7),
              child: child,
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28),
            child: Text(
              "现在就试试Flutter，入门很简单。",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).textTheme.body1.color.withOpacity(0.5),
              )
            ),
          ),
        ),
      ],
    );
  }
}