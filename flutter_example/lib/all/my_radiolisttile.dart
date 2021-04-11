import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/show_text.dart';

class MyRadioListTile extends StatelessWidget {
  const MyRadioListTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("RadioListTile"),
      ),
      body: SingleChildScrollView(
        child: RadioListTileBody(),
      ),
    );
  }
}

class RadioListTileBody extends StatefulWidget {
  RadioListTileBody({Key key}) : super(key: key);

  @override
  _RadioListTileBodyState createState() => _RadioListTileBodyState();
}

class _RadioListTileBodyState extends State<RadioListTileBody> {
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
          RadioListTile<String>(
            title: Text("标题$value1"),
            value: value1,
            groupValue: value,
            subtitle: Text("副标题"),
            secondary: Text("选择了第 $value 个"),
            onChanged: (val) {
              setState(() {
                value = val;
              });
            },
          ),
          RadioListTile<String>(
            title: Text("标题$value2"),
            activeColor: Colors.blue,
            value: value2,
            groupValue: value,
            subtitle: Text("副标题"),
            secondary: Text("选择了第 $value 个"),
            onChanged: (val) {
              setState(() {
                value = val;
              });
            },
          ),
          RadioListTile<String>(
            title: Text("标题$value3"),
            value: value3,
            groupValue: value,
            controlAffinity: ListTileControlAffinity.trailing,
            subtitle: Text("我的选择框在右边"),
            onChanged: (val) {
              setState(() {
                value = val;
              });
            },
          ),
          ShowText(
            text: '''
String value = "1";
String value1 = "1";
String value2 = "2";
String value3 = "3";

RadioListTile<String>(
  title: Text("标题$value1"),
  value: value1,
  groupValue: value,
  subtitle: Text("副标题"),
  secondary: Text("选择了第 $value 个"),
  onChanged: (val) {
    setState(() {
      value = val;
    });
  },
),

RadioListTile<String>(
  title: Text("标题$value2"),
  activeColor: Colors.blue,
  value: value2,
  groupValue: value,
  subtitle: Text("副标题"),
  secondary: Text("选择了第 $value 个"),
  onChanged: (val) {
    setState(() {
      value = val;
    });
  },
),

RadioListTile<String>(
  title: Text("标题$value3"),
  value: value3,
  groupValue: value,
  controlAffinity: ListTileControlAffinity.trailing,
  subtitle: Text("我的选择框在右边"),
  onChanged: (val) {
    setState(() {
      value = val;
    });
  },
),''',
          )
        ],
      ),
    );
  }
}
