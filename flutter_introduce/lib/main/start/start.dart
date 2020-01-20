import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_introduce/index/index.dart';
import 'package:flutter_introduce/utils/counter_model.dart';
import 'package:flutter_introduce/utils/pageIndicator.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'one.dart';
import 'three.dart';
import 'two.dart';

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
              padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).padding.top, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "FLUTTER",
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
                  One(),
                  Two(),
                  Three(),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                PageIndicator(),
                Text(
                  "NEXT",
                  style: TextStyle(
                    fontFamily: "Graphik",
                    fontWeight: FontWeight.w400,
                    letterSpacing: 3
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: IconButton(
                    icon: SvgPicture.asset("assets/svg/arrow_right.svg", width: 200),
                    onPressed: (){
                      if(_pageController.page <= 1){
                        _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                      } else {
                        SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
                        Navigator.pushReplacement(context, CustomRoute(Index()));
                      }
                    },
                  ),
                )
              ],
            ),
            SizedBox(height: 8 + MediaQuery.of(context).padding.bottom)
          ],
        ),
    );
  }
}



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
