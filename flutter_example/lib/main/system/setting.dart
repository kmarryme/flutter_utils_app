import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/main/caching_key/caching_key.dart';
import 'package:flutter_example/utils/counter_model.dart';
import 'package:flutter_example/utils/utils_function.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  Setting({Key key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text("设置"),
            expandedHeight: 200,
            floating: false,
            pinned: true,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Opacity(
                      opacity: 0.8,
                      child: Image.asset(
                        "images/bg2.jpg",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color:
                          Theme.of(context).backgroundColor.withOpacity(0.05),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height - 300,
            elevation: 0,
            leading: Container(),
            flexibleSpace: Container(
              padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(20),
              ),
              child: Column(
                children: <Widget>[
                  SettingTheme(),
                  SizedBox(height: 15),
                  StartUp(),
                  SizedBox(height: 15),
                  SecretProtection(),
                  SizedBox(height: 15),
                  GuideSetting(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///主题设置
class SettingTheme extends StatefulWidget {
  SettingTheme({Key key}) : super(key: key);

  @override
  _SettingThemeState createState() => _SettingThemeState();
}

class _SettingThemeState extends State<SettingTheme> {
  List<String> nameList = ["白天模式", "黑夜模式"];
  bool appThemeFlag = true;

  @override
  void initState() {
    utilsGetData(CachingKey.app_theme_key, 'bool').then((val) {
      if (val != null) {
        setState(() {
          appThemeFlag = val;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 50,
        color: Theme.of(context).backgroundColor,
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(10),
          vertical: ScreenUtil().setHeight(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.color_lens),
                Text(
                  "主题设置",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  context.watch<CounterModel>().appTheme ? "白天模式" : "黑夜模式",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
              ],
            )
          ],
        ),
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Select(
              initIndex: appThemeFlag ? 0 : 1,
              title: "主题设置",
              names: nameList,
              callback: (int index) {
                appThemeFlag = index == 0 ? true : false;
                context.read<CounterModel>().changeTheme(appThemeFlag);
                utilsetData(CachingKey.app_theme_key, appThemeFlag);
              },
            );
          },
        );
      },
    );
  }
}

class StartUp extends StatefulWidget {
  StartUp({Key key}) : super(key: key);

  @override
  _StartUpState createState() => _StartUpState();
}

class _StartUpState extends State<StartUp> {
  int index = 1;
  List<String> nameList = ["搜索页面", "第一个页面"];

  @override
  void initState() {
    super.initState();
    utilsGetData(CachingKey.start_key, 'int').then((val) {
      if (val != null) {
        setState(() {
          index = val;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: ScreenUtil().setHeight(50),
        color: Theme.of(context).backgroundColor,
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(10),
          vertical: ScreenUtil().setHeight(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.home),
                Text(
                  "启动默认进入",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  nameList[index],
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Select(
              initIndex: index,
              title: "启动默认进入",
              names: nameList,
              callback: (int ind) {
                utilsetData(CachingKey.start_key, ind);
                setState(() {
                  index = ind;
                });
              },
            );
          },
        );
      },
    );
  }
}

class SecretProtection extends StatefulWidget {
  SecretProtection({Key key}) : super(key: key);

  @override
  _SecretProtectionState createState() => _SecretProtectionState();
}

class _SecretProtectionState extends State<SecretProtection> {
  String secret = "关闭";

  @override
  void initState() {
    super.initState();
    utilsGetData(CachingKey.open_unlock, 'bool').then((unlock) {
      if (unlock != null && unlock) {
        utilsGetData(CachingKey.unlock_method, 'int').then((method) {
          WidgetsBinding.instance.addPostFrameCallback((callback) {
            if (method != null) {
              context.read<CounterModel>().changesUnlockMethod(method);
            } else {
              context.read<CounterModel>().changesUnlockMethod(0);
            }
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int unlock = context.watch<CounterModel>().unlockMethod;
    if (unlock == 0) {
      secret = "关闭";
    } else if (unlock == 1) {
      secret = "图案";
    } else if (unlock == 2) {
      secret = "数字";
    } else if (unlock == 3) {
      secret = "指纹";
    }
    return InkWell(
      child: Container(
        height: ScreenUtil().setHeight(50),
        color: Theme.of(context).backgroundColor,
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(10),
          vertical: ScreenUtil().setHeight(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.screen_lock_portrait),
                Text(
                  "密码方式",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  "$secret", //密码  图案
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, "/unlock_method");
      },
    );
  }
}

class GuideSetting extends StatefulWidget {
  GuideSetting({Key key}) : super(key: key);

  @override
  _GuideSettingState createState() => _GuideSettingState();
}

class _GuideSettingState extends State<GuideSetting> {
  bool switchFlag = true;

  @override
  void initState() {
    super.initState();
    utilsGetData(CachingKey.guide_key, 'bool').then((val) {
      if (val != null) {
        setState(() {
          switchFlag = val;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(50),
      color: Theme.of(context).backgroundColor,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(10),
        vertical: ScreenUtil().setHeight(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.phone_android),
              Text(
                "APP启动是否显示引导页面",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          CupertinoSwitch(
            value: switchFlag,
            onChanged: (val) {
              setState(() {
                switchFlag = val;
              });
              // utilsDeleteData([CachingKey.unlock_method]);
              utilsetData(CachingKey.guide_key, switchFlag);
            },
          ),
        ],
      ),
    );
  }
}

class Select extends StatefulWidget {
  final int initIndex;
  final String title;
  final List<String> names;
  final callback;
  Select({Key key, this.initIndex, this.names, this.callback, this.title})
      : super(key: key);

  @override
  _SelectState createState() => _SelectState();
}

class _SelectState extends State<Select> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(250),
      child: Column(
        children: <Widget>[
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
            color: Theme.of(context).backgroundColor,
            height: ScreenUtil().setHeight(35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  child: Text(
                    "取消",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onTap: () => Navigator.pop(context),
                ),
                Text(widget.title),
                InkWell(
                  child: Text(
                    "确定",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {
                    widget.callback(index);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: CupertinoPicker(
              scrollController: FixedExtentScrollController(
                initialItem: widget.initIndex,
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              magnification: 1.1,
              useMagnifier: true,
              looping: false,
              squeeze: 1,
              itemExtent: ScreenUtil().setHeight(25),
              children: widget.names
                  .map((text) => Text(
                        text,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.body1.color,
                        ),
                      ))
                  .toList(),
              onSelectedItemChanged: (int ind) {
                index = ind;
              },
            ),
          ),
        ],
      ),
    );
  }
}
