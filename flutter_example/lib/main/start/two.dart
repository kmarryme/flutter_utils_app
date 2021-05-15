import 'package:flutter/material.dart';
import 'package:flutter_example/utils/counter_model.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class Two extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                  double multiplier;
                  if(notifier.page <= 1.0) {
                    multiplier = math.max(0, 4 * notifier.page - 3);
                  } else {
                    multiplier = math.max(0, 1 - (4 * notifier.page - 4));
                  }
                  return Transform.scale(
                    scale: multiplier,
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
                  double multiplier;
                  if(notifier.page <= 1.0) {
                    multiplier = math.max(0, 4 * notifier.page - 3);
                  } else {
                    multiplier = math.max(0, 1 - (4 * notifier.page - 4));
                  }
                  return Transform.translate(
                    offset: Offset(0, -50 * (1 - multiplier)),
                    child: Opacity(
                      opacity: multiplier,
                      child: child,
                    ),
                  );
                },
                child: Container(
                  width: 150,
                  height: 400,
                  alignment: Alignment.center,
                  color: Colors.blueAccent.withOpacity(0.2),
                  child: FlutterLogo(style: FlutterLogoStyle.stacked, size: 150),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 16),
        Consumer<CounterModel>(
          builder: (context, notifier, child) {
            double multiplier;
            if(notifier.page <= 1.0) {
              multiplier = math.max(0, 4 * notifier.page - 3);
            } else {
              multiplier = math.max(0, 1 - (4 * notifier.page - 4));
            }
            return Transform.translate(
              offset: Offset(0, 50 * (1 - multiplier)),
              child: Opacity(
              opacity: multiplier,
                child: child,
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "全新体验",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, letterSpacing: 5),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28),
                child: Text(
                  "使用Flutter内置美丽的Material和Cupertino Widget为用户带来全新体验。",
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