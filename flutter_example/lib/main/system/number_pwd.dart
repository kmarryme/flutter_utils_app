import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_example/main/caching_key/caching_key.dart';
import 'package:flutter_example/utils/utils_function.dart';
import 'package:passcode_screen/passcode_screen.dart';

class NumberPwd extends StatefulWidget {
  NumberPwd({Key key}) : super(key: key);

  @override
  _NumberPwdState createState() => _NumberPwdState();
}

class _NumberPwdState extends State<NumberPwd> {
  final StreamController<bool> _verificationNotifier = StreamController<bool>.broadcast();
  String text = "请输入数字密码";
  String password = "";
  bool flag = true;

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("数字"),
      // ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: PasscodeScreen(
              title: Text(text),
              passwordDigits: 4,
              cancelCallback: () => Navigator.pop(context),
              passwordEnteredCallback: (pwd){
                if(flag){
                  flag = false;
                  password = pwd;
                  _verificationNotifier.add(false);
                  Future((){
                    setState(() {
                      text = "请再次输入";
                    });
                  });
                }else{
                  if(password != pwd){
                    _verificationNotifier.add(false);
                    Future((){
                      setState(() {
                        text = "密码错误";
                      });
                    });
                  }else{
                    utilsetData(CachingKey.open_unlock, true);
                    utilsetData(CachingKey.unlock_method, 2);
                    utilsetData(CachingKey.number_password, pwd);
                    Navigator.pop(context, 2);
                  }
                }
                
              },
              cancelButton: Text('取消'),
              deleteButton: Text('删除'),
              shouldTriggerVerification: _verificationNotifier.stream,  
            ),
          ),
        ],
      ),
    );
  }
}
