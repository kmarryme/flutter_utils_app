import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_introduce/index/index.dart';
import 'package:flutter_introduce/main/caching_key/caching_key.dart';
import 'package:flutter_introduce/utils/counter_model.dart';
import 'package:flutter_introduce/utils/pageIndicator.dart';
import 'package:flutter_introduce/utils/utils_function.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gesture_recognition/gesture_view.dart';
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
  GlobalKey<GestureState> gestureStateKey = GlobalKey();
  List correctResult = List();
  String text = "请绘制启动密码";
  bool openUnlock = false;

  @override
  void initState() {
    super.initState();
    utilsGetData(CachingKey.pattern_list, 'string').then((res) {
      if (res != null) {
        List list = json.decode(res);
        correctResult = list;
      }
    });
    utilsGetData(CachingKey.open_unlock, 'bool').then((open) {
      if (open != null && open) {
        SystemChrome.setEnabledSystemUIOverlays([]);
        setState(() {
          openUnlock = true;
        });
      } else {
        toPage();
      }
    });
  }

  toPage() {
    utilsGetData(CachingKey.guide_key, 'bool').then((val) {
      if (val == null || val) {
        SystemChrome.setEnabledSystemUIOverlays([]);
        Navigator.pushReplacement(context, CustomRoute(StartIndex()));
      } else {
        Navigator.pushReplacement(context, CustomRoute(Index()));
      }
    });
  }

  analysisGesture(List<int> items) {
    bool isCorrect = true;
    if (items.length == correctResult.length) {
      for (int i = 0; i < items.length; i++) {
        if (items[i] != correctResult[i]) {
          isCorrect = false;
          break;
        }
      }
    } else {
      isCorrect = false;
    }
    if (isCorrect) {
      text = "密码正确";
      toPage();
    } else {
      text = "密码错误";
      gestureStateKey.currentState.selectColor = Colors.red;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !openUnlock
          ? Center(
              child: CupertinoActivityIndicator(
                radius: 20,
              ),
            )
          : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("$text"),
              GestureView(
                key: this.gestureStateKey,
                size: MediaQuery.of(context).size.width,
                selectColor: Colors.blue,
                onPanUp: (List<int> items) {
                  analysisGesture(items);
                },
                onPanDown: () {
                  gestureStateKey.currentState.selectColor = Colors.blue;
                },
              ),
              InkWell(
                child: Text("忘记密码？"),
                onTap: () => toPage(),
              ),
            ],
          ),
    );
  }
}

class StartIndex extends StatefulWidget {
  StartIndex({Key key}) : super(key: key);

  @override
  _StartIndexState createState() => _StartIndexState();
}

class _StartIndexState extends State<StartIndex> {
  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<CounterModel>(context).offsetNotifier(_pageController);
    return Scaffold(
      // backgroundColor: Color(0xffF2F2F2),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).padding.top, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "FLUTTER",
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: "Graphik",
                      fontWeight: FontWeight.w800),
                ),
                Stack(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.shopping_basket),
                      onPressed: () {},
                    ),
                    Positioned(
                      right: 10,
                      bottom: 8,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
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
              onPageChanged: (int index) {
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
              Text("NEXT",
                  style: TextStyle(
                      fontFamily: "Graphik",
                      fontWeight: FontWeight.w400,
                      letterSpacing: 3)),
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: IconButton(
                  icon: SvgPicture.asset(
                    "assets/svg/arrow_right.svg",
                    width: 200,
                    color: Theme.of(context).iconTheme.color.withOpacity(0.8),
                  ),
                  onPressed: () {
                    if (_pageController.page <= 1) {
                      _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease);
                    } else {
                      SystemChrome.setEnabledSystemUIOverlays(
                          SystemUiOverlay.values);
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
            });
}
