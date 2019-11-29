import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_introduce/utils/counter_model.dart';
import 'package:provider/provider.dart';

import 'samurai.dart';

///启动页面
class Start extends StatefulWidget {
  Start({Key key}) : super(key: key);

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  PageController _pageController;

@override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<CounterModel>(context).offsetNotifier(_pageController);
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Hops",
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: "Graphik",
                      fontWeight: FontWeight.w800
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.shopping_basket),
                        onPressed: (){},
                      ),
                      Positioned(
                        right: 10,
                        bottom: 8,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int index){
                  Provider.of<CounterModel>(context).index = index;
                },
                children: <Widget>[
                  Samurai(),
                  Samurai(),
                  Samurai(),
                  // Reject(),
                  // Greatwave()
                ],
              ),
            )
          ],
        ),
    );
  }
}

// onPressed: () => Navigator.pushAndRemoveUntil(context, CustomRoute(TabIndex()), (route) => route == null)),

///跳转动画
class CustomRoute extends PageRouteBuilder {
  final Widget widget;
  CustomRoute(this.widget)
    : super(
      transitionDuration: Duration(seconds: 1),
      pageBuilder: (
        BuildContext context,
        Animation<double> animaton1,
        Animation<double> animaton2,
      ) {
        return widget;
        },
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animaton1,
          Animation<double> animaton2,
          Widget child,
        ) {
            return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              parent: animaton1,
                curve: Curves.fastOutSlowIn,
              )),
              child: child,
            );
          }
        );
}
