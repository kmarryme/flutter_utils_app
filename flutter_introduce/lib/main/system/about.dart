import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info/package_info.dart';

class About extends StatefulWidget {
  About({Key key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  String version = "";

  @override
  void initState() { 
    super.initState();
    PackageInfo.fromPlatform().then((PackageInfo packageInfo){
      setState(() {
        version = packageInfo.version; 
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("关于APP"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(50),
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
              "NAME",
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
          
        ],
      ),
    );
  }
}
