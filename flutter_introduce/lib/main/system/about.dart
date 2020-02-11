import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class About extends StatelessWidget {
  const About({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("关于我们"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(50),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.help, size:80,),
          ),
          
        ],
      ),
    );
  }
}