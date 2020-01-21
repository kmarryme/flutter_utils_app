import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              background: Image.asset(
                "images/bg2.jpg",
                fit: BoxFit.fitWidth,
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
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        color: Colors.blue.withOpacity(0.1),
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
                    fontSize: ScreenUtil().setSp(18),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  "白天模式",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(16),
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
        
      },
    );
  }
}
