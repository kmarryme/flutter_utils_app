import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowText extends StatelessWidget {
  final String text;
  final double height;
  const ShowText({Key key, @required this.text, @required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(20),
        vertical: ScreenUtil().setHeight(10),
      ),
      width: MediaQuery.of(context).size.width,
      height: height,
      child: CupertinoTextField(
        enabled: false,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(14),
          color: Theme.of(context).textTheme.body1.color.withOpacity(0.5),
        ),
        controller: TextEditingController(
          text: text,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
        ),
      ),
    );
  }
}
