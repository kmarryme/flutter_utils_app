import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowText extends StatelessWidget {
  final String text;
  const ShowText({Key key, @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(20),
        vertical: ScreenUtil().setHeight(10),
      ),
      width: MediaQuery.of(context).size.width,
      child: Text(
        text,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(14),
          backgroundColor: Theme.of(context).backgroundColor,
          color: Theme.of(context).textTheme.body1.color.withOpacity(0.8),
          height: 1.5,
        ),
      ),
    );
  }
}
