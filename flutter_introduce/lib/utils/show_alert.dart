import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showAlert(BuildContext context, String text) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Padding(
          padding: EdgeInsets.symmetric(
            vertical: ScreenUtil().setHeight(10),
          ),
          child: Text("$text"),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text('确定'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
