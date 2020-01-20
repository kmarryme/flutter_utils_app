import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/show_text.dart';

class MyRadio extends StatelessWidget {
  const MyRadio({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Radio"),
      ),
      body: SingleChildScrollView(
        child: RadioBody(),
      ),
    );
  }
}

class RadioBody extends StatefulWidget {
  RadioBody({Key key}) : super(key: key);

  @override
  _RadioBodyState createState() => _RadioBodyState();
}

class _RadioBodyState extends State<RadioBody> {
  String value = "1";
  String value1 = "1";
  String value2 = "2";
  String value3 = "3";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Radio(
                  value: value1,
                  groupValue: value,
                  onChanged: (val) {
                    setState(() {
                      value = val;
                    });
                  },
                ),
                Radio(
                  value: value2,
                  groupValue: value,
                  activeColor: Colors.blue,
                  onChanged: (val) {
                    setState(() {
                      value = val;
                    });
                  },
                ),
                Radio(
                  value: value3,
                  groupValue: value,
                  onChanged: (val) {
                    setState(() {
                      value = val;
                    });
                  },
                )
              ],
            ),
          ),
          Text("选择了第 $value 个"),
          ShowText(
            text: '''
String value = "1";
String value1 = "1";
String value2 = "2";
String value3 = "3";

Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
        Radio(
            value: value1,
            groupValue: value,
            onChanged: (val){
                setState(() {
                  value = val;
                });
            },
        ),
        Radio(
            value: value2,
            groupValue: value,
            onChanged: (val){
                setState(() {
                  value = val;
                });
            },
        ),
        Radio(
            value: value3,
            groupValue: value,
            onChanged: (val){
                setState(() {
                  value = val;
                });
            },
        )
    ],
),''',
          ),
        ],
      ),
    );
  }
}
