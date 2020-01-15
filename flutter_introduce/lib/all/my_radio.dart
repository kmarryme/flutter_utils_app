import 'package:flutter/material.dart';

class MyRadio extends StatelessWidget {
  const MyRadio({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "Radio",
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Radio"),
        ),
        body: SingleChildScrollView(
          child: RadioBody(),
        ),
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
  bool select = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: Radio(
            value: select,
            onChanged: (bool value){
              setState(() {
                select = !select;
              });
            },
          ),
        )
      ],
    );
  }
}