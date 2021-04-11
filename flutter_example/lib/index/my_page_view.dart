import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_example/utils/custom_route.dart';
import 'model.dart';

class MyPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Wrap(
        alignment: WrapAlignment.start,
        runSpacing: 20,
        children: Data.allDataModel.map((e) {
          return Container(
            width: 100,
            child: Column(
              children: <Widget>[
                Container(
                  child: InkWell(
                    child: Container(
                      width: 70,
                      height: 70,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.2),
                        ),
                        child: e.widget,
                      ),
                      onTap: () {
                        int type = Random().nextInt(4);
                        Navigator.push(
                          context,
                          CustomRoute(e.page, type),
                        );
                      },
                    ),
                  ),
                  Text(
                    "${e.name}",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            );
          }).toList(),
      ),
    );
  }
}

