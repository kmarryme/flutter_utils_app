import 'package:flutter/material.dart';

import '../utils/show_text.dart';

class MyCheckBox extends StatelessWidget {
  const MyCheckBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CheckBox"),
      ),
      body: SingleChildScrollView(
        child: CheckBoxBody(),
      ),
    );
  }
}

class CheckBoxBody extends StatefulWidget {
  CheckBoxBody({Key key}) : super(key: key);

  @override
  _CheckBoxBodyState createState() => _CheckBoxBodyState();
}

class _CheckBoxBodyState extends State<CheckBoxBody> {
  bool value1 = true;
  bool value2 = false;
  bool value3 = false;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Checkbox(
                value: value1,
                onChanged: (val){
                  setState(() {
                    value1 = val;
                  });
                },
              ),
              Checkbox(
                value: value2,
                activeColor: Colors.blue,
                onChanged: (val){
                  setState(() {
                    value2 = val;
                  });
                },
              ),
              Checkbox(
                value: value3,
                onChanged: (val){
                  setState(() {
                    value3 = val;
                  });
                },
              )
            ],
          ),
          Text("选择了第 ${value1 ? ' 1 ' : ''}${value2 ? ' 2 ' : ''}${value3 ? ' 3 ' : ''} 个"),
          ShowText(
            text: '''
bool value1 = true;
bool value2 = false;
bool value3 = false;

Checkbox(
  value: value1,
  onChanged: (val){
    setState(() {
      value1 = val;
    });
  },
),
Checkbox(
  value: value2,
  activeColor: Colors.blue,
  onChanged: (val){
    setState(() {
      value2 = val;
    });
  },
),
Checkbox(
  value: value3,
  onChanged: (val){
    setState(() {
      value3 = val;
    });
  },
)
            ''',
          )
        ],
      ),
    );
  }
}
