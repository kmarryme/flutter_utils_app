import 'package:flutter/material.dart';

import '../utils/show_text.dart';

class MyCheckboxListTile extends StatelessWidget {
  const MyCheckboxListTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CheckboxListTile"),
      ),
      body: SingleChildScrollView(
        child: CheckboxListTileBody(),
      ),
    );
  }
}

class CheckboxListTileBody extends StatefulWidget {
  CheckboxListTileBody({Key key}) : super(key: key);

  @override
  _CheckboxListTileBodyState createState() => _CheckboxListTileBodyState();
}

class _CheckboxListTileBodyState extends State<CheckboxListTileBody> {
  bool value1 = true;
  bool value2 = false;
  bool value3 = false;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: Column(
        children: <Widget>[
          CheckboxListTile(
            title: Text("标题1"),
            subtitle: Text("副标题"),
            secondary: Icon(Icons.format_list_numbered_rtl),
            value: value1,
            onChanged: (val){
              setState(() {
                value1 = val;
              });
            },
          ),
          CheckboxListTile(
            title: Text("标题2"),
            subtitle: Text("副标题"),
            secondary: Icon(Icons.format_list_numbered_rtl),
            activeColor: Colors.blue,
            value: value2,
            onChanged: (val){
              setState(() {
                value2 = val;
              });
            },
          ),
          CheckboxListTile(
            title: Text("标题3"),
            subtitle: Text("副标题"),
            secondary: Text("我的选择框在左边"),
            controlAffinity: ListTileControlAffinity.leading,
            value: value3,
            onChanged: (val){
              setState(() {
                value3 = val;
              });
            },
          ),
          Text("选择了第 ${value1 ? ' 1 ' : ''}${value2 ? ' 2 ' : ''}${value3 ? ' 3 ' : ''} 个"),
          ShowText(
            text: '''
bool value1 = true;
bool value2 = false;
bool value3 = false;

CheckboxListTile(
  title: Text("标题1"),
  subtitle: Text("副标题"),
  secondary: Icon(Icons.format_list_numbered_rtl),
  value: value1,
  onChanged: (val){
    setState(() {
      value1 = val;
    });
  },
),
CheckboxListTile(
  title: Text("标题2"),
  subtitle: Text("副标题"),
  secondary: Icon(Icons.format_list_numbered_rtl),
  activeColor: Colors.blue,
  value: value2,
  onChanged: (val){
    setState(() {
      value2 = val;
    });
  },
),
CheckboxListTile(
  title: Text("标题3"),
  subtitle: Text("副标题"),
  secondary: Text("我的选择框在左边"),
  controlAffinity: ListTileControlAffinity.leading,
  value: value3,
  onChanged: (val){
    setState(() {
      value3 = val;
    });
  },
),''',
          )
        ],
      ),
    );
  }
}
