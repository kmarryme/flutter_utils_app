import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_introduce/main/caching_key/caching_key.dart';
import 'package:flutter_introduce/utils/utils_function.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UnlockMethod extends StatefulWidget {
  UnlockMethod({Key key}) : super(key: key);

  @override
  _UnlockMethodState createState() => _UnlockMethodState();
}

class _UnlockMethodState extends State<UnlockMethod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("密码方式"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[OpenUnlock()],
        ),
      ),
    );
  }
}

class OpenUnlock extends StatefulWidget {
  OpenUnlock({Key key}) : super(key: key);

  @override
  _OpenUnlockState createState() => _OpenUnlockState();
}

class _OpenUnlockState extends State<OpenUnlock> {
  bool openFlag = false;

  @override
  void initState() {
    super.initState();
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
                Navigator.pushNamed(context, "/pattern_unlock").then((res){
                  if(res != null && res){
                    setState(() {
                      openFlag = true;
                    });
                    utilsetData(CachingKey.unlock_method, 1);
                  }
                });
              },
            ),
            CupertinoDialogAction(
              child: Text("数字"),
              onPressed: () {
                Navigator.of(context).pop();
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
    return Container(
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
              });
            },
          ),
        ],
      ),
    );
  }
}
