import 'package:flutter/material.dart';
import 'package:flutter_introduce/utils/counter_model.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class One extends StatelessWidget {
  const One({Key key}) : super(key: key);

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
                    color: Theme.of(context).backgroundColor,
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
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Consumer<CounterModel>(
          builder: (context, notifier, child){
            return Opacity(
              opacity: math.max(0, 1 - 4 * notifier.page),
              child: child,
            );
          },
          child: Column(
            children: <Widget>[
              Text("12345",style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, letterSpacing: 5)),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28),
                child: Text(
                  "123456789012345678901234567890",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).textTheme.body1.color.withOpacity(0.5),
                  )
                )
              )
            ],
          ),
        )
      ],
    );
  }
}