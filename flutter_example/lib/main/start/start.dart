import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_example/index/index.dart';
import 'package:flutter_example/main/caching_key/caching_key.dart';
import 'package:flutter_example/utils/counter_model.dart';
import 'package:flutter_example/utils/pageIndicator.dart';
import 'package:flutter_example/utils/show_alert.dart';
import 'package:flutter_example/utils/utils_function.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gesture_recognition/gesture_view.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:passcode_screen/passcode_screen.dart';
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
  LocalAuthentication localAuth = LocalAuthentication();
  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();
  GlobalKey<GestureState> gestureStateKey = GlobalKey();
  List correctResult = [];
  String numberPwd = "";
  String text = "请绘制启动密码";
  int openUnlock = 0;

  @override
  void initState() {
    super.initState();
    // utilsDeleteData([CachingKey.unlock_method, CachingKey.pattern_list, CachingKey.open_unlock, CachingKey.number_password]);
    utilsGetData(CachingKey.pattern_list, 'string').then((res) {
      if (res != null) {
        List list = json.decode(res);
        correctResult = list;
      }
    });
    utilsGetData(CachingKey.number_password, 'string').then((res) {
      if (res != null) {
        numberPwd = res;
      }
    });
    utilsGetData(CachingKey.open_unlock, 'bool').then((open) {
      if (open != null && open) {
        SystemChrome.setEnabledSystemUIOverlays([]);
        utilsGetData(CachingKey.unlock_method, 'int').then((method) {
          if (method != null) {
            setState(() {
              openUnlock = method;
            });
          }
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
    Widget body = Center(
      child: CupertinoActivityIndicator(
        radius: 20,
      ),
    );
    if (openUnlock == 1) {
      body = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 60),
          Text("$text"),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: GestureView(
                key: this.gestureStateKey,
                size: 400,
                selectColor: Colors.blue,
                onPanUp: (List<int> items) {
                  analysisGesture(items);
                },
                onPanDown: () {
                  gestureStateKey.currentState.selectColor = Colors.blue;
                },
              ),
            ),
          ),
          InkWell(
            child: Text("忘记密码？"),
            onTap: () => toPage(),
          ),
          SizedBox(height: 60),
        ],
      );
    } else if (openUnlock == 2) {
      body = Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: PasscodeScreen(
              title: Text("请输入密码"),
              passwordDigits: 4,
              passwordEnteredCallback: (pwd) {
                if (numberPwd != pwd) {
                  _verificationNotifier.add(false);
                } else {
                  toPage();
                }
              },
              cancelButton: Text('取消'),
              cancelCallback: () {
                showAskAlert(context, "确定要退出APP吗？", (res) {
                  if (res) {
                    exit(0);
                  } else {
                    Navigator.of(context).pop();
                  }
                });
              },
              deleteButton: Text('删除'),
              shouldTriggerVerification: _verificationNotifier.stream,
              bottomWidget: InkWell(
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Text(
                    "忘记密码？",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onTap: () => toPage(),
              ),
            ),
          ),
        ],
      );
    } else if (openUnlock == 3) {
      Future(() {
        const andStrings = const AndroidAuthMessages(
          cancelButton: '取消',
          goToSettingsButton: '去设置',
          biometricNotRecognized: '指纹识别失败',
          goToSettingsDescription: '请设置指纹.',
          biometricHint: '指纹',
          biometricSuccess: '指纹识别成功',
          signInTitle: '指纹验证',
          deviceCredentialsRequiredTitle: '请先录入指纹!',
        );
        localAuth.authenticate(
          localizedReason: '扫描指纹进行身份验证',
          useErrorDialogs: false,
          androidAuthStrings: andStrings,
          /* iOSAuthStrings: iosStrings, */
          stickyAuth: true,
        ).then((bool authenticated) {
          if (authenticated) {
            toPage();
          } else {
            exit(0);
          }
        });
      });
    }
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: body,
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
    context.read<CounterModel>().offsetNotifier(_pageController);
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
                context.read<CounterModel>().index = index;
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
