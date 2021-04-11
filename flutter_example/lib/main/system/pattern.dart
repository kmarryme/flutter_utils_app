import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_example/main/caching_key/caching_key.dart';
import 'package:flutter_example/utils/show_alert.dart';
import 'package:flutter_example/utils/utils_function.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gesture_recognition/gesture_view.dart';

class PatternUnlock extends StatefulWidget {
  PatternUnlock({Key key}) : super(key: key);

  @override
  _PatternUnlockState createState() => _PatternUnlockState();
}

class _PatternUnlockState extends State<PatternUnlock> {
  GlobalKey<GestureState> gestureStateKey = GlobalKey();
  List<int> correctResult = [];
  String text = "绘制解锁图案";
  bool again = false;

  analysisGesture(List<int> items) {
    bool isCorrect = true;
    if (items.length == correctResult.length) {
      for (int i = 0 ; i < items.length ; i++) {
        if (items[i] != correctResult[i]) {
          isCorrect = false;
          break;
        }
      }
    } else {
      isCorrect = false;
    }
    if(isCorrect){
      gestureStateKey.currentState.selectColor = Colors.blue;
      utilsetData(CachingKey.pattern_list, json.encode(items));
      utilsetData(CachingKey.unlock_method, 1);
      Navigator.pop(context, 1);
    }else{
      gestureStateKey.currentState.selectColor = Colors.red;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("图案"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(40),
            ),
            child: Text("$text"),
          ),
          Expanded(
            child: Container(
              height: ScreenUtil().setHeight(500),
              alignment: Alignment.center,
              child: !again ? GestureView(
                immediatelyClear: true,
                size: 400,
                onPanUp: (List<int> items) {
                  if(items.length <= 2){
                    showAlert(context, "最少3位，请重新输入");
                  }else{
                    correctResult = items;
                    setState(() {
                      text = "请再试一次";
                      again = true;
                    });
                  }
                },
              ) : 
              GestureView(
                key: this.gestureStateKey,
                size: 400,
                selectColor: Colors.blue,
                onPanUp: (List<int> items) {
                  analysisGesture(items);
                },
                onPanDown: () {
                  gestureStateKey.currentState.selectColor = Colors.blue;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
