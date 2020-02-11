import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_introduce/main/caching_key/caching_key.dart';
import 'package:flutter_introduce/utils/counter_model.dart';
import 'package:flutter_introduce/utils/show_alert.dart';
import 'package:flutter_introduce/utils/utils_function.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class UnlockMethod extends StatefulWidget {
  UnlockMethod({Key key}) : super(key: key);

  @override
  _UnlockMethodState createState() => _UnlockMethodState();
}

class _UnlockMethodState extends State<UnlockMethod> {
  int backres = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("密码方式"),
      ),
      body: SingleChildScrollView(
        child: OpenUnlock(
          callback: (int res) {
            backres = res;
            Provider.of<CounterModel>(context).changesUnlockMethod(backres);
          },
        ),
      ),
    );
  }
}

class OpenUnlock extends StatefulWidget {
  final callback;
  OpenUnlock({Key key, this.callback}) : super(key: key);

  @override
  _OpenUnlockState createState() => _OpenUnlockState();
}

class _OpenUnlockState extends State<OpenUnlock> {
  LocalAuthentication localAuth = LocalAuthentication();
  bool openFlag = false;
  int value = 0;
  int value1 = 1;
  int value2 = 2;
  int value3 = 3;

  @override
  void initState() {
    super.initState();
    utilsGetData(CachingKey.unlock_method, "int").then((res) {
      if (res != null) {
        value = res;
        widget.callback(value);
      }
    });
    utilsGetData(CachingKey.open_unlock, 'bool').then((res) {
      if (res == null || !res) {
        setState(() {
          openFlag = false;
        });
      } else {
        setState(() {
          openFlag = true;
        });
      }
    });
  }

  cupertinoDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("请选择密码方式"),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text("图案"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, "/pattern_unlock").then((res) {
                  if (res != null) {
                    setState(() {
                      openFlag = true;
                      value = res;
                    });
                  }
                });
              },
            ),
            CupertinoDialogAction(
              child: Text("数字"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, "/number_pwd").then((res) {
                  if (res != null) {
                    setState(() {
                      openFlag = true;
                      value = res;
                    });
                  }
                });
              },
            ),
            CupertinoDialogAction(
              child: Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Theme.of(context).backgroundColor,
          margin: EdgeInsets.only(
            top: ScreenUtil().setHeight(30),
          ),
          padding: EdgeInsets.symmetric(
            vertical: ScreenUtil().setHeight(5),
            horizontal: ScreenUtil().setWidth(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("开启密码锁定"),
              CupertinoSwitch(
                value: openFlag,
                onChanged: (openres) {
                  // utilsDeleteData([CachingKey.unlock_method, CachingKey.pattern_list, CachingKey.open_unlock, CachingKey.number_password]);
                  utilsGetData(CachingKey.unlock_method, 'int').then((res) {
                    if (res == null || res == 0) {
                      showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: ScreenUtil().setHeight(10),
                              ),
                              child: Text("您还没有密码方式"),
                            ),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                child: Text('取消'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              CupertinoDialogAction(
                                child: Text("创建"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  cupertinoDialog();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      setState(() {
                        openFlag = openres;
                      });
                      utilsetData(CachingKey.open_unlock, openFlag);
                    }
                    widget.callback(!openFlag ? 0 : value);
                  });
                },
              ),
            ],
          ),
        ),
        Offstage(
          offstage: !openFlag,
          child: Container(
            color: Theme.of(context).backgroundColor,
            margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(20),
            ),
            padding: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(5),
              horizontal: ScreenUtil().setWidth(15),
            ),
            child: Column(
              children: <Widget>[
                RadioListTile<int>(
                  title: Text(
                    "图案",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.body1.color,
                    ),
                  ),
                  value: value1,
                  groupValue: value,
                  activeColor: Colors.blue,
                  controlAffinity: ListTileControlAffinity.trailing,
                  onChanged: (val) {
                    utilsGetData(CachingKey.pattern_list, "string").then((res) {
                      if (res != null) {
                        utilsetData(CachingKey.unlock_method, value1);
                        setState(() {
                          value = val;
                        });
                      } else {
                        showAskAlert(context, "您还没有图案，是否去设置？", (res) {
                          Navigator.pop(context);
                          if (res) {
                            Navigator.pushNamed(context, "/pattern_unlock")
                                .then((res) {
                              if (res != null) {
                                setState(() {
                                  value = val;
                                });
                              }
                            });
                          }
                        });
                      }
                      widget.callback(value);
                    });
                  },
                ),
                RadioListTile<int>(
                  title: Text(
                    "数字",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.body1.color,
                    ),
                  ),
                  activeColor: Colors.blue,
                  value: value2,
                  groupValue: value,
                  controlAffinity: ListTileControlAffinity.trailing,
                  onChanged: (val) {
                    utilsGetData(CachingKey.number_password, "string")
                        .then((res) {
                      if (res != null) {
                        utilsetData(CachingKey.unlock_method, value2);
                        setState(() {
                          value = val;
                        });
                      } else {
                        showAskAlert(context, "您还没有密码，是否去设置？", (res) {
                          Navigator.pop(context);
                          if (res) {
                            Navigator.pushNamed(context, "/number_pwd")
                                .then((res) {
                              if (res != null) {
                                setState(() {
                                  value = val;
                                });
                              }
                            });
                          }
                        });
                      }
                      widget.callback(value);
                    });
                  },
                ),
                RadioListTile<int>(
                  title: Text(
                    "Touch ID指纹",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.body1.color,
                    ),
                  ),
                  activeColor: Colors.blue,
                  value: value3,
                  groupValue: value,
                  controlAffinity: ListTileControlAffinity.trailing,
                  onChanged: (val) {
                    localAuth.canCheckBiometrics.then((bool res) async {
                      if (res) {
                        utilsetData(CachingKey.unlock_method, value3);
                        setState(() {
                          value = val;
                        });
                      } else {
                        showAlert(context, "您的设备不支持");
                      }
                      widget.callback(value);
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        Offstage(
          offstage: !openFlag,
          child: Container(
            margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(20),
            ),
            child: Column(
              children: <Widget>[
                InkWell(
                  child: Container(
                    color: Theme.of(context).backgroundColor,
                    margin: EdgeInsets.only(top: ScreenUtil().setHeight(5)),
                    padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(10),
                      horizontal: ScreenUtil().setWidth(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("重置图案密码"),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                  onTap: () => Navigator.pushNamed(context, "/pattern_unlock"),
                ),
                InkWell(
                  child: Container(
                    color: Theme.of(context).backgroundColor,
                    margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                    padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(10),
                      horizontal: ScreenUtil().setWidth(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("重置数字密码"),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                  onTap: () => Navigator.pushNamed(context, "/number_pwd"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
