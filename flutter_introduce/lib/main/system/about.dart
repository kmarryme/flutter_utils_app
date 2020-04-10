import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_introduce/configuration.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  About({Key key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  bool _isExpanded = false;
  bool _updateIsExpaned = false;
  String version = "";

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        version = packageInfo.version;
      });
    });
  }

  Container itemRow(String name, String url) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(10),
        vertical: ScreenUtil().setHeight(10),
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: Theme.of(context).backgroundColor,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: Text(
                "$name",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: InkWell(
                child: Text(
                  "$url",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () {
                  launch(url);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("关于${Config.app_name}"),
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(40),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.help,
              size: 80,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(20),
            ),
            child: Text(
              Config.app_name,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(28),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(20),
            ),
            child: Text("Version $version"),
          ),
          Container(
            margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(20),
              bottom: ScreenUtil().setHeight(20),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(20),
            ),
            child: Column(
              children: <Widget>[
                Text(Config.statement,textAlign: TextAlign.center,),
                InkWell(
                  child: Text(
                    Config.email,
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: (){
                    launch("mailto:${Config.email}");
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(5),
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              child: ExpansionPanelList(
                children: [
                  ExpansionPanel(
                    isExpanded: _isExpanded,
                    canTapOnHeader: true,
                    headerBuilder: (context, isExpanded) {
                      return ListTile(
                        title: Text(
                          "此APP使用技术",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.body1.color,
                          ),
                        ),
                        subtitle: Text(
                          "感谢FLUTTER团队以及所有开发者",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.body1.color,
                          ),
                        ),
                      );
                    },
                    body: ListBody(
                      children: <Widget>[
                        itemRow("FLUTTER", "https://flutter.dev"),
                        itemRow("provider",
                            "https://github.com/rrousselGit/provider"),
                        itemRow(
                            "local_auth", "https://github.com/flutter/plugins"),
                        itemRow("flutter_svg",
                            "https://github.com/dnfield/flutter_svg"),
                        itemRow("url_launcher",
                            "https://github.com/flutter/plugins"),
                        itemRow("share_extend",
                            "https://github.com/zhouteng0217/ShareExtend"),
                        itemRow("package_info",
                            "https://github.com/flutter/plugins"),
                        itemRow("flutter_slidable",
                            "https://github.com/letsar/flutter_slidable"),
                        itemRow("passcode_screen",
                            "https://github.com/xPutnikx/flutter-passcodev"),
                        itemRow("flutter_screenutil",
                            "https://github.com/OpenFlutter/flutter_screenutil"),
                        itemRow("fab_circular_menu",
                            "https://github.com/marianocordoba/fab-circular-menu"),
                        itemRow("shared_preferences",
                            "https://github.com/flutter/plugins"),
                        itemRow("gesture_recognition",
                            "https://github.com/flutter-food/gesture_recognition"),
                      ],
                    ),
                  ),
                  ExpansionPanel(
                    isExpanded: _updateIsExpaned,
                    canTapOnHeader: true,
                    headerBuilder: (context, isExpanded) {
                      return ListTile(
                        title: Text(
                          "更新内容",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.body1.color,
                          ),
                        ),
                      );
                    },
                    body: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(15),
                      ),
                      margin: EdgeInsets.only(
                        bottom: ScreenUtil().setHeight(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(Config.update_content),
                          InkWell(
                            child: Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(
                                top: ScreenUtil().setHeight(10),
                              ),
                              child: Text(
                                "去更新 >",
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            onTap: () {
                              if(Platform.isIOS){
                                launch("itms-apps://itunes.apple.com/cn/app/");
                              }else{
                                
                              }
                              
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                expansionCallback: (panelIndex, isExpanded) {
                  setState(() {
                    if (panelIndex == 0) {
                      _isExpanded = !isExpanded;
                    } else {
                      _updateIsExpaned = !isExpanded;
                    }
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
